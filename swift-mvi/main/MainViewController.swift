import UIKit
import RxSwift
import RxCocoa

class MainViewController: MviViewController<MainViewIntent, MainResult, MainViewState, MainViewModel> {

    @IBOutlet weak var errorContainer: UIStackView!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func intents() -> Observable<MainViewIntent> {
        return Observable.merge(
            Observable.just(MainViewIntent.Init),
            retryButton.rx.tap.map { MainViewIntent.Retry }
        )
    }
    
    override func render(state: MainViewState) {
        print(state)
        
        switch state {
        case  MainViewState.InProgress:
            errorContainer.gone()
            activityIndicatorView.visible()
        case  MainViewState.OnPinyinLoaded:
            activityIndicatorView.gone()
        case  MainViewState.GenericError:
            errorContainer.visible()
            activityIndicatorView.gone()
        }
    }
    
    override func provideViewModel() -> MainViewModel {
        return MainViewModel(initialState: MainViewState.InProgress)
    }
}
