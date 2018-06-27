import UIKit
import RxSwift

class MviViewController<I : MviIntent, R: MviResult, VS: MviViewState, VM : MviViewModel<I, R, VS>>: UIViewController {
    
    private let disposable = CompositeDisposable()
    private var viewModel: VM?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.viewModel = provideViewModel()
        self.viewModel!.bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        _ = disposable.insert(viewModel!.states().subscribe(onNext: {
            state in
                print(state)
                self.render(state: state)
        }))
        viewModel!.processIntents(intents: intents())
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        disposable.dispose()
    }
    
    func intents() -> Observable<I> {
        return Observable.empty()
    }
    
    func render(state: VS) {
        fatalError("render() must be overidden in concrete implementations of MviViewController")
    }
    
    func provideViewModel() -> VM {
        fatalError("viewModel() must be overidden in concrete implementations of MviViewController")
    }
}
