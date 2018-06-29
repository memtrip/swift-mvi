import UIKit
import RxSwift
import RxCocoa

class PinyinDetailViewController : MviViewController<PinyinDetailIntent, PinyinDetailResult, PinyinDetailViewState, PinyinDetailViewModel> {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var containerView: UIView!
    
    lazy var tableView: PinyinDetailTableViewController = {
        return (self.childViewControllers.last as! PinyinDetailTableViewController)
    }()
    
    override func idleIntent() -> PinyinDetailIntent {
        return PinyinDetailIntent.Init
    }
    
    override func intents() -> Observable<PinyinDetailIntent> {
        return Observable.merge(
            Observable.just(PinyinDetailIntent.Init),
            doneButton.rx.tap.map { PinyinDetailIntent.Exit }
        )
    }
    
    override func render(state: PinyinDetailViewState) {
        navigationBar.topItem?.title = state.phoneticScriptText
        tableView.phoneticScript.text = state.phoneticScriptText
        tableView.englishTranslation.text = state.englishTranslationText
        tableView.chineseCharacters.text = state.chineseCharacters

        if (state.action == PinyinDetailViewState.Action.Back) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func provideViewModel() -> PinyinDetailViewModel {
        return PinyinDetailViewModel(initialState: PinyinDetailViewState(
            phoneticScriptText: getDestinationBundle()!.dictionary["phoneticScriptText"] as! String,
            englishTranslationText: getDestinationBundle()!.dictionary["englishTranslationText"] as! String,
            chineseCharacters: getDestinationBundle()!.dictionary["chineseCharacters"] as! String,
            audioSrc: getDestinationBundle()!.dictionary["audioSrc"] as! String?,
            action: PinyinDetailViewState.Action.None
        ))
    }
}
