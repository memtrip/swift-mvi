import Foundation
import RxSwift

class EnglishViewModel : PinyinListViewModel {
    
    let englishSearch = EnglishSearch()
    
    override func defaultSearchTerm() -> String {
        return "pinyin"
    }
    
    override func search(terms: String) -> Single<Array<Pinyin>> {
        return englishSearch.search(terms: terms)
    }
}
