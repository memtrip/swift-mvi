import Foundation
import RxSwift

class PinyinDetailViewModel : MviViewModel<PinyinDetailIntent, PinyinDetailResult, PinyinDetailViewState> {
    
    override func dispatcher(intent: PinyinDetailIntent) -> Observable<PinyinDetailResult> {
        switch intent {
        case .Init:
            return Observable.just(PinyinDetailResult.Init)
        case .PlayAudio:
            return Observable.just(PinyinDetailResult.PlayAudio)
        case .Exit:
            return Observable.just(PinyinDetailResult.Exit)
        }
    }
    
    override func reducer(previousState: PinyinDetailViewState, result: PinyinDetailResult) -> PinyinDetailViewState {
        switch result {
        case .Init:
            return previousState
        case .PlayAudio:
            return previousState.copy(copy: {
                copy in copy.action = PinyinDetailViewState.Action.PlayAudio(url: previousState.audioSrc)
            })
        case .Exit:
            return previousState.copy(copy: {
                copy in copy.action = PinyinDetailViewState.Action.Back
            })
        }
    }
}
