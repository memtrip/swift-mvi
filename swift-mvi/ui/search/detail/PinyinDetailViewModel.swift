import Foundation
import RxSwift

class PinyinDetailViewModel : MviViewModel<PinyinDetailIntent, PinyinDetailResult, PinyinDetailViewState> {
    
    override func dispatcher(intent: PinyinDetailIntent) -> Observable<PinyinDetailResult> {
        fatalError("dispatcher must be implemented in concrete implementations of MviViewModel")
    }
    
    override func reducer(previousState: PinyinDetailViewState, result: PinyinDetailResult) -> PinyinDetailViewState {
        fatalError("reducer must be implemented in concrete implementations of MviViewModel")
    }
}
