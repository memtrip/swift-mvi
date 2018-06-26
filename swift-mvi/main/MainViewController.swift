import UIKit

import RxSwift
import RxCocoa

class MainViewController: MviViewController<MainViewIntent, MainResult, MainViewState, MainViewModel> {

    @IBOutlet weak var buttonOne: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func intents() -> Observable<MainViewIntent> {
        return Observable.merge(
            Observable.just(MainViewIntent.Init(userId: "12")),
            buttonOne.rx.tap.map { MainViewIntent.LoadPinyin }
        )
    }
    
    override func render(state: MainViewState) {
        print(state)
    }
    
    override func provideViewModel() -> MainViewModel {
        return MainViewModel(initialState: MainViewState.InProgress)
    }
}
