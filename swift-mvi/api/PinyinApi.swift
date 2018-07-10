import Foundation
import RxSwift
import Alamofire

protocol PinyinApi {
    func getDictionary() -> Single<HttpResponse<PinyinWrapperJson>>
}

class PinyinApiImpl: PinyinApi {

    var headers: HTTPHeaders = [
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Accept-Language": "en-GB"
    ]

    func getDictionary() -> Single<HttpResponse<PinyinWrapperJson>> {
        return Http<PinyinWrapperJson, ErrorJson>().single(
            httpRequest: HttpRequest(
                url: ApiConfig.ENDPOINT + "/pinyin/",
                method: .get,
                headers: headers
            )
        )
    }
}
