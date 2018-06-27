import Foundation
import RxSwift

class PinyinListViewModel : MviViewModel<PinyinListIntent, PinyinListResult, PinyinListViewState> {
    
    func defaultSearchTerm() -> String {
        fatalError("defaultSearchTerm must be implemented")
    }
    
    func search(terms: String) -> Single<Array<Pinyin>> {
        fatalError("search must be implemented")
    }
    
    override func dispatcher(intent: PinyinListIntent) -> Observable<PinyinListResult> {
        switch intent {
        case .Search(let terms):
            return search(terms: terms == "" ? defaultSearchTerm() : terms)
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
