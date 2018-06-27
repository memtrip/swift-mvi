import Foundation
import RxSwift

class MainViewModel : MviViewModel<MainViewIntent, MainResult, MainViewState> {
    
    let fetchAndSavePinyin = FetchAndSavePinyin()
    let countPinyin = CountPinyin()
    
    private func fetch() -> Observable<MainResult> {
        
        return countPinyin
            .count()
            .flatMap { count in
                if count > 0 {
                    return Single.just(MainResult.OnPinyinLoaded)
                } else {
                    return self.fetchAndSavePinyin
                        .save()
                        .map { _ in MainResult.OnPinyinLoaded }
                }
            }
            .catchErrorJustReturn(MainResult.GenericError)
            .asObservable()
            .startWith(MainResult.InProgress)
    }
    
    override func dispatcher(intent: MainViewIntent) -> Observable<MainResult> {
        switch intent {
        case .Init:
            return fetch()
        case .Retry:
            return fetch()
        }
    }
    
    override func reducer(previousState: MainViewState, result: MainResult) -> MainViewState {
        switch result {
        case .InProgress:
            return MainViewState.InProgress
        case .OnPinyinLoaded:
            return MainViewState.OnPinyinLoaded
        case .GenericError:
            return MainViewState.GenericError
        }
    }
}
