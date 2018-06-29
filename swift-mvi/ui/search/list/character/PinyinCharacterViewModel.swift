import Foundation
import RxSwift

class PinyinCharacterViewModel : PinyinListViewModel {
    
    init() {
        super.init(search: CharacterSearch(), defaultSearchTerm: "汉语")
    }
}
