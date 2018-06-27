import UIKit
import RxSwift

class MviViewModel<I : MviIntent, R : MviResult, VS: MviViewState> {
    
    private let intentsSubject: PublishSubject<I> =  PublishSubject()
    private let initialState: VS
    private let disposable = CompositeDisposable()
    
    private var statesObservable: Observable<VS>?
    
    init(initialState: VS) {
        self.initialState = initialState
    }
    
    func states() -> Observable<VS> {
        if let states = statesObservable {
            return states
        } else {
            fatalError("The MviViewController should call bind immediately after initialising MviViewModel")
        }
    }
    
    func bind() {
        statesObservable = intentsSubject
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
    }
    
    func processIntents(intents: Observable<I>) {
        _ = disposable.insert(intents.subscribe(intentsSubject))
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
