import Foundation
import RxSwift

class PinyinListViewModel : MviViewModel<PinyinListIntent, PinyinListResult, PinyinListViewState> {
    
    let search: PinyinSearch
    let defaultSearchTerm: String
    
    init(search: PinyinSearch, defaultSearchTerm: String) {
        self.search = search
        self.defaultSearchTerm = defaultSearchTerm
        super.init(initialState: PinyinListViewState.Populate(pinyinList: []))
    }
    
    override func dispatcher(intent: PinyinListIntent) -> Observable<PinyinListResult> {
        switch intent {
        case .Idle:
            return Observable.just(PinyinListResult.Idle)
        case .Search(let terms):
            return self.search.query(terms: terms == "" ? self.defaultSearchTerm : terms)
                .map { pinyinList in  PinyinListResult.Populate(pinyinList: pinyinList) }
                .catchErrorJustReturn(PinyinListResult.OnError)
                .asObservable()
        case .SelectItem(let pinyin):
            return Observable.just(PinyinListResult.NavigateToDetails(pinyin: pinyin))
        case .PlayAudio(let audioSrc):
            return Observable.just(PinyinListResult.PlayAudio(audioSrc: audioSrc))
        }
    }
    
    override func reducer(previousState: PinyinListViewState, result: PinyinListResult) -> PinyinListViewState {
        switch result {
        case .Idle:
            return PinyinListViewState.Idle
        case .Populate(let pinyinList):
            return PinyinListViewState.Populate(pinyinList: pinyinList)
        case .NavigateToDetails(let pinyin):
            return PinyinListViewState.NavigateToDetails(pinyin: pinyin)
        case .PlayAudio(let audioSrc):
            return PinyinListViewState.PlayAudio(audioSrc: audioSrc)
        case .OnError:
            return PinyinListViewState.OnError
        }
    }
}
