import Foundation
import RxSwift

class SearchViewModel : MviViewModel<SearchIntent, SearchResult, SearchViewState> {

    private func pageHint(page: SearchPage) -> String {
        switch page {
        case .Phonetic:
            return "Search phonetic pinyin..."
        case .English:
            return "Search english translations..."
        case .Character:
            return "寻找汉语词典"
        }
    }
    
    override func dispatcher(intent: SearchIntent) -> Observable<SearchResult> {
        switch intent {
        case .SearchHint(let page):
            return Observable.just(SearchResult.SearchHint(hint: pageHint(page: page)))
        }
    }
    
    override func reducer(previousState: SearchViewState, result: SearchResult) -> SearchViewState {
        switch result {
        case .SearchHint(let hint):
            return SearchViewState.SearchHint(hint: hint)
        }
    }
}
