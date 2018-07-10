import Foundation
import RxSwift

class EntryViewModel: MxViewModel<EntryIntent, EntryResult, EntryViewState> {

    let countPinyin: CountPinyin
    let fetchAndSavePinyin: FetchAndSavePinyin

    init (countPinyin: CountPinyin, fetchAndSavePinyin: FetchAndSavePinyin, initialState: EntryViewState) {
        self.countPinyin = countPinyin
        self.fetchAndSavePinyin = fetchAndSavePinyin
        super.init(initialState: initialState)
    }

    private func fetch() -> Observable<EntryResult> {

        return countPinyin
            .count()
            .flatMap { count in
                if count > 0 {
                    return Single.just(EntryResult.pinyinLoaded)
                } else {
                    return self.fetchAndSavePinyin
                        .save()
                        .map { _ in EntryResult.pinyinLoaded }
                }
            }
            .catchErrorJustReturn(EntryResult.error)
            .asObservable()
            .startWith(EntryResult.progress)
    }

    override func dispatcher(intent: EntryIntent) -> Observable<EntryResult> {
        switch intent {
        case .idle:
            return Observable.just(EntryResult.idle)
        case .start:
            return fetch()
        case .retry:
            return fetch()
        }
    }

    override func reducer(previousState: EntryViewState, result: EntryResult) -> EntryViewState {
        switch result {
        case .idle:
            return EntryViewState.idle
        case .progress:
            return EntryViewState.progress
        case .pinyinLoaded:
            return EntryViewState.pinyinLoaded
        case .error:
            return EntryViewState.error
        }
    }
}
