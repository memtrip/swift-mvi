import Foundation
import RxSwift
import Alamofire
import ObjectMapper
import SwiftyJSON

class Http<R : HttpResponse> {
    
    func single(
        url: String,
        method: HTTPMethod,
        headers: HTTPHeaders
    ) -> Single<R> {
        return single(url: url, method: method, params: nil, headers: headers)
    }
    
    func single(url: String, method: HTTPMethod, params: Parameters?, headers: HTTPHeaders) -> Single<R> {
        return Single<R>.create { single in
            return self.call(
                url: url,
                method: method,
                params: params,
                headers: headers,
                onSuccess: { response in single(.success(response)) },
                onError: { error in single(.error(error)) }
            )
        }
    }
    
    func completable(
        url: String,
        method: HTTPMethod,
        headers: HTTPHeaders
    ) -> Completable {
        return completable(url: url, method: method, headers: headers)
    }
    
    func completable(
        url: String,
        method: HTTPMethod,
        params: Parameters?,
        headers: HTTPHeaders
    ) -> Completable {
        return Completable.create { completable in
            return self.call(
                url: url,
                method: method,
                params: params,
                headers: headers,
                onSuccess: { response in completable(.completed) },
                onError: { error in completable(.error(error)) }
            )
        }
    }
    
    private func call(
        url: String,
        method: HTTPMethod,
        params: Parameters?,
        headers: HTTPHeaders,
        onSuccess: @escaping ((_ response: R)->Void),
        onError: @escaping ((_ error: HttpErrorResponse)->Void)
    ) -> Disposable {
        
        Logger.log(value: url)
        Logger.log(value: "params:\(String(describing: params))")
        
        Alamofire.request(
            url,
            method: method,
            parameters: params,
            encoding: JSONEncoding.default,
            headers: headers).responseJSON { response in
                            
            if let res = response.response {
                if (res.statusCode >= 200 && res.statusCode < 300) {
                    
                    Logger.log(value: "status_code: \(res.statusCode)")
                    
                    if let body = response.result.value {
                        
                        Logger.log(value: "response: \(body)")
                        
                        if let json = JSON(body).rawString() {
                            if let response: R = Mapper<R>().map(JSONString: json) {
                                onSuccess(response)
                            } else {
                                let response: R = Mapper<R>().map(JSONString: "{}")!
                                onSuccess(response)
                            }
                        } else {
                            let response: R = Mapper<R>().map(JSONString: "{}")!
                            onSuccess(response)
                        }
                    } else {
                        let response: R = Mapper<R>().map(JSONString: "{}")!
                        onSuccess(response)
                    }
                } else {
                    if let body = response.result.value {
                        Logger.log(value: "\(body)")
           
                        onError(HttpErrorResponse(
                            code: res.statusCode,
                            body: JSON(body).rawString()!
                        ))
                    } else {
                        onError(HttpErrorResponse(
                            code: res.statusCode,
                            body: ""
                        ))
                    }
                }
            } else {
                onError(HttpErrorResponse(
                    code: -1,
                    body: ""
                ))
            }
        }
        
        return Disposables.create()
    }
}
