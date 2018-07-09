import UIKit
import RxSwift
import RxCocoa

class PinyinDetailViewController : MxViewController<PinyinDetailIntent, PinyinDetailResult, PinyinDetailViewState, PinyinDetailViewModel> {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var containerView: UIView!
    
    lazy var tableViewController: PinyinDetailTableViewController = {
        return (self.childViewControllers.last as! PinyinDetailTableViewController)
    }()
    
    override func idleIntent() -> PinyinDetailIntent {
        return PinyinDetailIntent.Init
    }
    
    override func intents() -> Observable<PinyinDetailIntent> {
        return Observable.merge(
            Observable.just(PinyinDetailIntent.Init),
            tableViewController.playButton.rx.tap.map { PinyinDetailIntent.PlayAudio },
            doneButton.rx.tap.map { PinyinDetailIntent.Exit }
        )
    }
    
    override func render(state: PinyinDetailViewState) {
        navigationBar.topItem?.title = state.phoneticScriptText
        tableViewController.phoneticScript.text = state.phoneticScriptText
        tableViewController.englishTranslation.text = state.englishTranslationText
        tableViewController.chineseCharacters.text = state.chineseCharacters
        tableViewController.tableView.reloadData()
        
        if (state.audioSrc.isEmpty) {
            tableViewController.playButton.gone()
        } else {
            tableViewController.playButton.visible()
        }
        
        switch state.action {
        case .Back:
            self.dismiss(animated: true, completion: nil)
        case .PlayAudio(let url):
            SoundPlayer.shared.play(url: url)
        case .None:
            break
        }
    }
    
    override func provideViewModel() -> PinyinDetailViewModel {
        return PinyinDetailViewModel(initialState: PinyinDetailViewState(
            phoneticScriptText: getDestinationBundle()!.dictionary["phoneticScriptText"] as! String,
            englishTranslationText: getDestinationBundle()!.dictionary["englishTranslationText"] as! String,
            chineseCharacters: getDestinationBundle()!.dictionary["chineseCharacters"] as! String,
            audioSrc: getDestinationBundle()!.dictionary["audioSrc"] as! String,
            action: PinyinDetailViewState.Action.None
        ))
    }
}
