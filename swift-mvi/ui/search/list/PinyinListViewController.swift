import Foundation
import RxSwift

class PinyinListViewController<VM: PinyinListViewModel>:
    MxViewController<PinyinListIntent, PinyinListResult, PinyinListViewState, VM> {

    func populate(pinyinList: [Pinyin]) {
        fatalError("populate() must be implemented")
    }

    override func idleIntent() -> PinyinListIntent {
        return PinyinListIntent.idle
    }

    override func intents() -> Observable<PinyinListIntent> {
        if let viewController = self.parent as? SearchViewController {
            return viewController
                .searchBar.rx.text
                .asObservable()
                .map { terms in PinyinListIntent.search(terms: terms!) }
        } else {
            fatalError("PinyinListViewConroller can only function as a child of SearchViewController")
        }
    }

    override func render(state: PinyinListViewState) {
        switch state {
        case .idle:
            break
        case .populate(let pinyinList):
            populate(pinyinList: pinyinList)
        case .navigateToDetails(let pinyin):
            setDestinationBundle(bundle: SegueBundle(identifier: "searchToDetails", dictionary: [
                "phoneticScriptText": pinyin.phoneticScriptText,
                "englishTranslationText": pinyin.englishTranslationText,
                "chineseCharacters": pinyin.chineseCharacters,
                "audioSrc": pinyin.audioSrc
            ]))

            performSegueOnParent(withIdentifier: "searchToDetails", sender: self)

        case .error:
            fatalError("The database must be corrupted :(")
        }
    }
}
