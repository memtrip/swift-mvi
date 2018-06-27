import Foundation
import RxSwift

class PhoneticViewModel : PinyinListViewModel {
    
    let phoneticSearch = PhoneticSearch()
    
    override func defaultSearchTerm() -> String {
        return "pinyin"
    }
    
    override func search(terms: String) -> Single<Array<Pinyin>> {
        return phoneticSearch.search(terms: terms)
    }
}
