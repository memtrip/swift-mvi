import Foundation
import RxSwift

class PinyinEnglishViewModel: PinyinListViewModel {

    init() {
        super.init(search: EnglishSearch(), defaultSearchTerm: "pinyin")
    }
}
