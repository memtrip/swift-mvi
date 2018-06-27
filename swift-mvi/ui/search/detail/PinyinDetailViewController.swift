import UIKit
import RxSwift
import RxCocoa

class PinyinDetailViewController : MviViewController<PinyinDetailIntent, PinyinDetailResult, PinyinDetailViewState, PinyinDetailViewModel> {
    
    override func intents() -> Observable<PinyinDetailIntent> {
        return Observable.empty()
    }
    
    override func render(state: PinyinDetailViewState) {
        fatalError("render() must be overidden in concrete implementations of MviViewController")
    }
    
    override func provideViewModel() -> PinyinDetailViewModel {
        fatalError("viewModel() must be overidden in concrete implementations of MviViewController")
    }
}
