import Foundation
import RxSwift

class SearchViewModel: MxViewModel<SearchIntent, SearchResult, SearchViewState> {

    private func pageHint(page: SearchPage) -> String {
        switch page {
        case .phonetic:
            return "Search phonetic pinyin..."
        case .english:
            return "Search english translations..."
        case .character:
            return "寻找汉语词典"
        }
    }

    override func dispatcher(intent: SearchIntent) -> Observable<SearchResult> {
        switch intent {
        case .idle:
            return Observable.just(SearchResult.idle)
        case .searchHint(let page):
            return Observable.just(SearchResult.page(hint: pageHint(page: page), page: page))
        }
    }

    override func reducer(previousState: SearchViewState, result: SearchResult) -> SearchViewState {
        switch result {
        case .idle:
            return previousState
        case .page(let hint, let page):
            return SearchViewState(hint: hint, page: page)
        }
    }
}
