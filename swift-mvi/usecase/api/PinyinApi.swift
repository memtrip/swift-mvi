import Foundation
import RxSwift
import Alamofire

protocol PinyinApi {
    func getDictionary() -> Single<PinyinWrapperJson>
}

class PinyinApiImpl: PinyinApi {
    
    var headers: HTTPHeaders = [
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Accept-Language":"en-GB"
    ]
    
    func getDictionary() -> Single<PinyinWrapperJson> {
        return Http().single(
            url: ApiConfig.ENDPOINT + "/pinyin/",
            method: .get,
            headers: headers
        )
    }
}
