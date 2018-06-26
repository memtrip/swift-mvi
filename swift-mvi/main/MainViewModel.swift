import Foundation

import RxSwift

class MainViewModel : MviViewModel<MainViewIntent, MainResult, MainViewState> {
 
    override func dispatcher(intent: MainViewIntent) -> Observable<MainResult> {
        switch intent {
        case .Init(let userId):
            print(userId)
            return Observable.just(MainResult.InProgress)
        case .LoadPinyin:
            return Observable.just(MainResult.GenericError("error message"))
        }
    }
    
    override func reducer(previousState: MainViewState, result: MainResult) -> MainViewState {
        switch result {
        case .InProgress:
            return MainViewState.InProgress
        case .Pinyin:
            return MainViewState.Pinyin
        case .GenericError(let error):
            return MainViewState.GenericError(error: error)
        }
    }
}
