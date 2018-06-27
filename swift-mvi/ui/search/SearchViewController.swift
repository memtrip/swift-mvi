import UIKit
import RxCocoa
import RxSwift

class SearchViewController: MviViewController<SearchIntent, SearchResult, SearchViewState, SearchViewModel> {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func intents() -> Observable<SearchIntent> {
        return Observable.merge(
            segmentControl.rx
                .selectedSegmentIndex
                .asObservable()
                .map { value in SearchIntent.SearchHint(page: SearchPage.values[value]) }
        )
    }
    
    override func render(state: SearchViewState) {
        switch state {
        case  SearchViewState.SearchHint(let hint):
            searchBar.placeholder = hint
        }
    }
    
    override func provideViewModel() -> SearchViewModel {
        return SearchViewModel(initialState: SearchViewState.SearchHint(hint: ""))
    }
}
