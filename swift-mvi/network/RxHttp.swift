import Foundation
import RxSwift
import Alamofire

class Http<R: Decodable, E: Decodable> {

    let connection: Connection = ConnectionFactory().create()

    func single(httpRequest: HttpRequest) -> Single<HttpResponse<R>> {
        return Single<HttpResponse<R>>.create { single in
            return self.call(
                httpRequest: httpRequest,
                onSuccess: { response in single(.success(response)) },
                onError: { error in single(.error(error)) }
            )
        }
    }

    func completable(httpRequest: HttpRequest) -> Completable {
        return Completable.create { completable in
            return self.call(
                httpRequest: httpRequest,
                onSuccess: { _ in
                    completable(.completed)
                },
                onError: { error in
                    completable(.error(error)) }
                )
        }
    }

    private func call(
        httpRequest: HttpRequest,
        onSuccess: @escaping ((_ response: HttpResponse<R>) -> Void),
        onError: @escaping ((_ error: HttpErrorResponse<E>) -> Void)
    ) -> Disposable {

        Logger.log(value: httpRequest.url)
        Logger.log(value: "method:\(String(describing: httpRequest.method))")
        Logger.log(value: "headers:\(String(describing: httpRequest.headers))")
        Logger.log(value: "params:\(String(describing: httpRequest.params))")

        connection.request(
            httpRequest.url,
            method: httpRequest.method,
            parameters: httpRequest.params,
            headers: httpRequest.headers).responseData { response in

            if let res = response.response {

                Logger.log(value: "status_code: \(res.statusCode)")

                if res.statusCode >= 200 && res.statusCode < 300 {

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
