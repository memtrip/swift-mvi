import Foundation
import RxSwift

class FetchAndSavePinyin {
    
    private let pinyinApi: PinyinApi = PinyinApiImpl()
    private let savePinyin = SavePinyin()
    
    func save() -> Single<[Pinyin]> {
        return pinyinApi.getDictionary().flatMap {
            response in return self.savePinyin.insert(pinyinJson: response.body!.pinyin)
        }
    }
}
