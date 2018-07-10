import Foundation
import RxSwift

class PinyinDetailViewModel: MxViewModel<PinyinDetailIntent, PinyinDetailResult, PinyinDetailViewState> {

    override func dispatcher(intent: PinyinDetailIntent) -> Observable<PinyinDetailResult> {
        switch intent {
        case .start:
            return Observable.just(PinyinDetailResult.start)
        case .playAudio:
            return Observable.just(PinyinDetailResult.playAudio)
        case .exit:
            return Observable.just(PinyinDetailResult.exit)
        }
    }

    override func reducer(previousState: PinyinDetailViewState, result: PinyinDetailResult) -> PinyinDetailViewState {
        switch result {
        case .start:
            return previousState
        case .playAudio:
            return previousState.copy(copy: { copy in
                copy.action = PinyinDetailViewState.Action.playAudio(url: previousState.audioSrc)
            })
        case .exit:
            return previousState.copy(copy: { copy in
                copy.action = PinyinDetailViewState.Action.back
            })
        }
    }
}
