import Foundation
import RxSwift

extension ConnectableObservableType {
    func autoconnect() -> Observable<E> {
        return Observable.create { observer in
            return self.do(onSubscribe: {
                _ = self.connect()
            }).subscribe { (event: Event<Self.E>) in
                switch event {
                case .next(let value):
                    observer.on(.next(value))
                case .error(let error):
                    observer.on(.error(error))
                case .completed:
                    observer.on(.completed)
                }
                
            }
        }
    }
}

extension ObservableType where E: Sequence, E.Iterator.Element: Equatable {
    func distinctUntilChanged() -> Observable<E> {
        return distinctUntilChanged { (lhs, rhs) -> Bool in
            return Array(lhs) == Array(rhs)
        }
    }
}
