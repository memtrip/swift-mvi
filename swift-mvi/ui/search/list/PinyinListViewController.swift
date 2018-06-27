import Foundation
import RxSwift

class PinyinListViewController: MviViewController<PinyinListIntent, PinyinListResult, PinyinListViewState, PinyinListViewModel> {
    
    func populate(pinyinList: Array<Pinyin>) {
        fatalError("populate() must be implemented")
    }
    
    override func intents() -> Observable<PinyinListIntent> {
        return Observable.just(PinyinListIntent.Search(terms: "pinyin"))
    }
    
    override func render(state: PinyinListViewState) {
        switch state {
        case .Populate(let pinyinList):
            populate(pinyinList: pinyinList)
        case .NavigateToDetails(let pinyin):
            print("navigate to details")
        case .PlayAudio(let audioSrc):
            print("play audio")
        case .OnError:
            fatalError("The database must be corrupted :(")
        }
    }
    
    override func provideViewModel() -> PinyinListViewModel {
        return PinyinListViewModel(initialState: PinyinListViewState.Populate(pinyinList: []))
    }
}
