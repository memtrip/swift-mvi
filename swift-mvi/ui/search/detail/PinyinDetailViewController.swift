import UIKit
import RxSwift
import RxCocoa

class PinyinDetailViewController: MxViewController<
    PinyinDetailIntent, PinyinDetailResult, PinyinDetailViewState, PinyinDetailViewModel> {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var cardViewHeight: NSLayoutConstraint!

    lazy var tableViewController: PinyinDetailTableViewController = {
        if let viewController = self.childViewControllers.last as? PinyinDetailTableViewController {
            return viewController
        } else {
            fatalError("The PinyinDetailViewController must have a PinyinDetailTableViewController child")
        }
    }()

    override func viewDidLayoutSubviews() {
        cardViewHeight.constant = tableViewController.tableView.contentSize.height
    }

    override func idleIntent() -> PinyinDetailIntent {
        return PinyinDetailIntent.start
    }

    override func intents() -> Observable<PinyinDetailIntent> {
        return Observable.merge(
            Observable.just(PinyinDetailIntent.start),
            tableViewController.playButton.rx.tap.map { PinyinDetailIntent.playAudio },
            doneButton.rx.tap.map { PinyinDetailIntent.exit }
        )
    }

    override func render(state: PinyinDetailViewState) {
        navigationBar.topItem?.title = state.phoneticScriptText
        tableViewController.phoneticScript.text = state.phoneticScriptText
        tableViewController.englishTranslation.text = state.englishTranslationText
        tableViewController.chineseCharacters.text = state.chineseCharacters

        tableViewController.tableView.reloadData()
        tableViewController.tableView.layoutIfNeeded()

        cardViewHeight.constant = tableViewController.tableView.contentSize.height

        if state.audioSrc.isEmpty {
            tableViewController.playButton.gone()
        } else {
            tableViewController.playButton.visible()
            tableViewController.playButton.imageView?.tintColor = UIColor.App.Primary
        }

        switch state.action {
        case .back:
            self.dismiss(animated: true, completion: nil)
        case .playAudio(let url):
            SoundPlayer.shared.play(url: url)
        case .none:
            break
        }
    }

    override func provideViewModel() -> PinyinDetailViewModel {

        if let bundle = getDestinationBundle() {
            return PinyinDetailViewModel(initialState: PinyinDetailViewState(
                phoneticScriptText: bundle.dictionary["phoneticScriptText"] as? String ?? "-",
                englishTranslationText: bundle.dictionary["englishTranslationText"] as? String ?? "-",
                chineseCharacters: bundle.dictionary["chineseCharacters"] as? String ?? "-",
                audioSrc: bundle.dictionary["audioSrc"] as? String ?? "-",
                action: PinyinDetailViewState.Action.none
            ))
        } else {
            fatalError("PinyinDetailViewController is expecting a bundle")
        }
    }
}
