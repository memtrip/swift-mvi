import UIKit
import RxSwift
import RxCocoa

class EntryViewController: MviViewController<EntryIntent, EntryResult, EntryViewState, EntryViewModel> {

    @IBOutlet weak var errorContainer: UIStackView!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func intents() -> Observable<EntryIntent> {
        return Observable.merge(
            Observable.just(EntryIntent.Init),
            retryButton.rx.tap.map { EntryIntent.Retry }
        )
    }
    
    override func render(state: EntryViewState) {        
        switch state {
        case  EntryViewState.InProgress:
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
        return EntryViewModel(initialState: EntryViewState.InProgress)
    }
}
