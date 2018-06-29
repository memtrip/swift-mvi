import UIKit
import RxSwift

class MviViewModel<I : MviIntent, R : MviResult, VS: MviViewState> {
    
    private let intentsSubject: PublishSubject<I> =  PublishSubject()
    private let initialState: VS
    private let disposable = CompositeDisposable()
    
    private lazy var statesObservable: Observable<VS> = {
        return intentsSubject
            .flatMap {
                intent in self.log(intent: intent)
            }
            .flatMap {
                intent in self.dispatcher(intent: intent)
            }
            .scan(initialState) { [unowned self]
                previousState, result in return self.reducer(previousState: previousState, result: result)
            }
            .replay(1)
            .autoconnect()
    }()
    
    init(initialState: VS) {
        self.initialState = initialState
    }
    
    func states() -> Observable<VS> {
        return statesObservable
    }
    
    func processIntents(intents: Observable<I>) {
        _ = disposable.insert(intents.subscribe(intentsSubject))
    }
    
    func publish(intent: I) {
        intentsSubject.onNext(intent)
    }
    
    private func log(intent: I) -> Observable<I> {
        return Observable.just(intent)
    }
    
    //
    // MARK -> Must be overriden by concrete implementations
    //
    func dispatcher(intent: I) -> Observable<R> {
        fatalError("dispatcher must be implemented in concrete implementations of MviViewModel")
    }
    
    func reducer(previousState: VS, result: R) -> VS {
        fatalError("reducer must be implemented in concrete implementations of MviViewModel")
    }
}
