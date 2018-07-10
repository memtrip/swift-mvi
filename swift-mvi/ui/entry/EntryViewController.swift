import UIKit
import RxSwift
import RxCocoa
import Lottie

class EntryViewController: MxViewController<EntryIntent, EntryResult, EntryViewState, EntryViewModel> {

    @IBOutlet weak var lottieAnimationContainer: UIView!
    @IBOutlet weak var errorContainer: UIStackView!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    lazy var animationView: LOTAnimationView = {
        let animationView = LOTAnimationView(name: "lottie_chinese")
        animationView.frame = lottieAnimationContainer.bounds
        animationView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        lottieAnimationContainer.addSubview(animationView)
        return animationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView.play { (finished) in
            self.viewModel.publish(intent: EntryIntent.Init)
        }
    }
    
    override func intents() -> Observable<EntryIntent> {
        return Observable.merge(
            retryButton.rx.tap.map { EntryIntent.Retry }
        )
    }
    
    override func idleIntent() -> EntryIntent {
        return EntryIntent.Idle
    }
    
    override func render(state: EntryViewState) {        
        switch state {
        case .Idle:
            break
        case EntryViewState.InProgress:
            errorContainer.gone()
            activityIndicatorView.visible()
        case  EntryViewState.OnPinyinLoaded:
            activityIndicatorView.gone()
            performSegue(withIdentifier: "entryToSearch", sender: self)
        case EntryViewState.GenericError:
            errorContainer.visible()
            activityIndicatorView.gone()
        }
    }
    
    override func provideViewModel() -> EntryViewModel {
        return EntryViewModel(
            countPinyin: CountPinyinImpl(),
            fetchAndSavePinyin: FetchAndSavePinyinImpl(),
            initialState: EntryViewState.InProgress)
    }
}
