import Foundation
import RxSwift

class EntryViewModel : MviViewModel<EntryIntent, EntryResult, EntryViewState> {
    
    let fetchAndSavePinyin = FetchAndSavePinyin()
    let countPinyin = CountPinyin()
    
    private func fetch() -> Observable<EntryResult> {
        
        return countPinyin
            .count()
            .flatMap { count in
                if count > 0 {
                    return Single.just(EntryResult.OnPinyinLoaded)
                } else {
                    return self.fetchAndSavePinyin
                        .save()
                        .map { _ in EntryResult.OnPinyinLoaded }
                }
            }
            .catchErrorJustReturn(EntryResult.GenericError)
            .asObservable()
            .startWith(EntryResult.InProgress)
    }
    
    override func dispatcher(intent: EntryIntent) -> Observable<EntryResult> {
        switch intent {
        case .Init:
            return fetch()
        case .Retry:
            return fetch()
        }
    }
    
    override func reducer(previousState: EntryViewState, result: EntryResult) -> EntryViewState {
        switch result {
        case .InProgress:
            return EntryViewState.InProgress
        case .OnPinyinLoaded:
            return EntryViewState.OnPinyinLoaded
        case .GenericError:
            return EntryViewState.GenericError
        }
    }
}
