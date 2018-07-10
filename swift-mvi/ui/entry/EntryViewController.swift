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

        animationView.play { _ in
            self.viewModel.publish(intent: EntryIntent.start)
        }
    }

    override func intents() -> Observable<EntryIntent> {
        return Observable.merge(
            retryButton.rx.tap.map { EntryIntent.retry }
        )
    }

    override func idleIntent() -> EntryIntent {
        return EntryIntent.idle
    }

    override func render(state: EntryViewState) {
        switch state {
        case .idle:
            break
        case EntryViewState.progress:
            errorContainer.gone()
            activityIndicatorView.visible()
        case  EntryViewState.pinyinLoaded:
            activityIndicatorView.gone()
            performSegue(withIdentifier: "entryToSearch", sender: self)
        case EntryViewState.error:
            errorContainer.visible()
            activityIndicatorView.gone()
        }
    }

    override func provideViewModel() -> EntryViewModel {
        return EntryViewModel(
            countPinyin: CountPinyinImpl(),
            fetchAndSavePinyin: FetchAndSavePinyinImpl(),
            initialState: EntryViewState.progress)
    }
}
