import Foundation
import RxSwift

class PinyinListViewModel: MxViewModel<PinyinListIntent, PinyinListResult, PinyinListViewState> {

    let search: PinyinSearch
    let defaultSearchTerm: String

    init(search: PinyinSearch, defaultSearchTerm: String) {
        self.search = search
        self.defaultSearchTerm = defaultSearchTerm
        super.init(initialState: PinyinListViewState.populate(pinyinList: []))
    }

    override func dispatcher(intent: PinyinListIntent) -> Observable<PinyinListResult> {
        switch intent {
        case .idle:
            return Observable.just(PinyinListResult.idle)
        case .search(let terms):
            return self.search.query(terms: terms == "" ? self.defaultSearchTerm : terms)
                .map { pinyinList in  PinyinListResult.populate(pinyinList: pinyinList) }
                .catchErrorJustReturn(PinyinListResult.error)
                .asObservable()
        case .selectItem(let pinyin):
            return Observable.just(PinyinListResult.navigateToDetails(pinyin: pinyin))
        }
    }

    override func reducer(previousState: PinyinListViewState, result: PinyinListResult) -> PinyinListViewState {
        switch result {
        case .idle:
            return PinyinListViewState.idle
        case .populate(let pinyinList):
            return PinyinListViewState.populate(pinyinList: pinyinList)
        case .navigateToDetails(let pinyin):
            return PinyinListViewState.navigateToDetails(pinyin: pinyin)
        case .error:
            return PinyinListViewState.error
        }
    }
}
