import Foundation
import RxSwift

class PinyinPhoneticViewModel: PinyinListViewModel {

    init() {
        super.init(search: PhoneticSearch(), defaultSearchTerm: "pinyin")
    }
}
