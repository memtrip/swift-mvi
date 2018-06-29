import Foundation
import RxSwift
import Alamofire

class Http<R : Decodable, E: Decodable> {
    
    let connection: Connection = ConnectionFactory().create()
    
    func single(
        url: String,
        method: HTTPMethod,
        headers: HTTPHeaders
    ) -> Single<HttpResponse<R>> {
        return single(url: url, method: method, params: nil, headers: headers)
    }
    
    func single(url: String, method: HTTPMethod, params: Parameters?, headers: HTTPHeaders) -> Single<HttpResponse<R>> {
        return Single<HttpResponse<R>>.create { single in
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
        onSuccess: @escaping ((_ response: HttpResponse<R>)->Void),
        onError: @escaping ((_ error: HttpErrorResponse<E>)->Void)
    ) -> Disposable {
        
        Logger.log(value: url)
        Logger.log(value: "method:\(String(describing: method))")
        Logger.log(value: "headers:\(String(describing: headers))")
        Logger.log(value: "params:\(String(describing: params))")
        
        connection.request(
            url,
            method: method,
            parameters: params,
            headers: headers).responseData { response in
                            
            if let res = response.response {
                
                Logger.log(value: "status_code: \(res.statusCode)")
                
                if (res.statusCode >= 200 && res.statusCode < 300) {
                    
                    if let body = response.result.value {
                
                        Logger.log(value: "response: \(body)")
                        
                        do {
                            let decodedBody = try JSONDecoder().decode(R.self, from: body)
                            onSuccess(HttpResponse(statusCode: res.statusCode, body: decodedBody))
                        } catch {
                            onError(HttpErrorResponse(statusCode: -9, body: nil))
                        }
                    } else {
                        onSuccess(HttpResponse(statusCode: res.statusCode, body: nil))
                    }
                } else {
                    
                    if let body = response.result.value {
                        
                        Logger.log(value: "error_response: \(body)")
                        
                        do {
                            let decodedBody = try JSONDecoder().decode(E.self, from: body)
                            onError(HttpErrorResponse(statusCode: res.statusCode, body: decodedBody))
                        } catch {
                            onError(HttpErrorResponse(statusCode: res.statusCode, body: nil))
                        }
                    } else {
                        onError(HttpErrorResponse(statusCode: res.statusCode, body: nil))
                    }
                }
            } else {
                onError(HttpErrorResponse(statusCode: -1, body: nil))
            }
        }
        
        return Disposables.create()
    }
}
