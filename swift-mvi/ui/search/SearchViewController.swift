import UIKit
import RxCocoa
import RxSwift

class SearchViewController: MxViewController<SearchIntent, SearchResult, SearchViewState, SearchViewModel> {
 
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var rootView: UIView!
    
    private lazy var phoneticViewController: PinyinPhoneticViewController = {
        return PinyinPhoneticViewController()
    }()
    
    private lazy var englishViewController: PinyinEnglishViewController = {
        return PinyinEnglishViewController()
    }()
    
    private lazy var characterViewController: PinyinCharacterViewController = {
        return PinyinCharacterViewController()
    }()
    
    override func idleIntent() -> SearchIntent {
        return SearchIntent.Idle
    }
    
    override func intents() -> Observable<SearchIntent> {
        return Observable.merge(
            segmentControl.rx
                .selectedSegmentIndex
                .asObservable()
                .map { value in SearchIntent.SearchHint(page: SearchPage.values[value]) }
        )
    }
    
    override func render(state: SearchViewState) {
        searchBar.placeholder = state.hint
        
        switch state.page {
        case .Phonetic:
            replaceChildViewController(viewController: phoneticViewController)
        case .English:
            replaceChildViewController(viewController: englishViewController)
        case .Character:
            replaceChildViewController(viewController: characterViewController)
        }
    }
    
    private func replaceChildViewController(viewController: UIViewController) {
        addChildViewController(viewController)
        rootView.addSubview(viewController.view)
        
        viewController.view.frame = rootView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParentViewController: self)
    }
    
    override func provideViewModel() -> SearchViewModel {
        return SearchViewModel(initialState: SearchViewState(hint: "", page: SearchPage.Phonetic))
    }
}
