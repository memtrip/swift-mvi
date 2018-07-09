import Foundation
import RxSwift

class PinyinListViewController<VM : PinyinListViewModel>: MviViewController<PinyinListIntent, PinyinListResult, PinyinListViewState, VM> {
    
    func populate(pinyinList: Array<Pinyin>) {
        fatalError("populate() must be implemented")
    }
    
    override func idleIntent() -> PinyinListIntent {
        return PinyinListIntent.Idle
    }
    
    override func intents() -> Observable<PinyinListIntent> {
        return (self.parent as! SearchViewController)
            .searchBar.rx.text
            .asObservable()
            .map { terms in PinyinListIntent.Search(terms: terms!) }
    }
    
    override func render(state: PinyinListViewState) {
        switch state {
        case .Idle:
            break
        case .Populate(let pinyinList):
            populate(pinyinList: pinyinList)
        case .NavigateToDetails(let pinyin):
            setDestinationBundle(bundle: SegueBundle(identifier: "searchToDetails", dictionary: [
                "phoneticScriptText":pinyin.phoneticScriptText,
                "englishTranslationText":pinyin.englishTranslationText,
                "chineseCharacters":pinyin.chineseCharacters,
                "audioSrc":pinyin.audioSrc
            ]))
            
            performSegueOnParent(withIdentifier: "searchToDetails", sender: self)
            
        case .OnError:
            fatalError("The database must be corrupted :(")
        }
    }
}
