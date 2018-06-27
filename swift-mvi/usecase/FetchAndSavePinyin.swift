import Foundation
import RxSwift

class FetchAndSavePinyin {
    
    private let pinyinApi: PinyinApi = PinyinApiImpl()
    private let savePinyin = SavePinyin()
    
    func save() -> Single<[Pinyin]> {
        return pinyinApi.getDictionary().flatMap {
            json in return self.savePinyin.insert(pinyinJson: json.pinyin!)
        }
    }
}
