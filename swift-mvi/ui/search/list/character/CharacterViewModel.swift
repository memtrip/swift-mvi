import Foundation
import RxSwift

class CharacterViewModel : PinyinListViewModel {
    
    let characterSearch = CharacterSearch()
    
    override func defaultSearchTerm() -> String {
        return "汉语"
    }
    
    override func search(terms: String) -> Single<Array<Pinyin>> {
        return characterSearch.search(terms: terms)
    }
}
