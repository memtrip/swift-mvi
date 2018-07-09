import UIKit
import RxSwift

class MxViewController<I : MxIntent, R: MxResult, VS: MxViewState, VM : MxViewModel<I, R, VS>>: UIViewController, BundleSender, Mvi {
    
    typealias Intent = I
    typealias ViewState = VS
    typealias ViewModel = VM
 
    private let disposeBag = DisposeBag()
    private var destinationBundle: SegueBundle?
    
    private lazy var viewModel: ViewModel = {
        return provideViewModel()
    }()
    
    override func viewDidLoad() {
        DispatchQueue.main.async {
            self.viewModel.states().observeOn(MainScheduler.instance).subscribe(onNext: {
                state in
                Logger.log(value: "\(state)", trim: true)
                self.render(state: state)
            }).disposed(by: self.disposeBag)
            
            self.viewModel.processIntents(intents: self.intents())
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let bundle = (sender as! BundleSender).getDestinationBundle() {
            if segue.identifier == bundle.identifier {
                (segue.destination as! BundleSender).setDestinationBundle(bundle: bundle)
            }
        }
        
        viewModel.publish(intent: idleIntent())
    }
    
    func performSegueOnParent(withIdentifier: String, sender: Any?) {
        self.parent?.performSegue(withIdentifier: withIdentifier, sender: sender)
        viewModel.publish(intent: idleIntent())
    }
    
    private func log(state: ViewState) {
        print(state)
    }
    
    //
    // MARK -> @protocol/Mvi
    //
    func intents() -> Observable<Intent> {
        return Observable.empty()
    }
    
    func idleIntent() -> Intent {
        fatalError("idleIntent() must be overidden in concrete implementations of MviViewController")
    }
    
    func render(state: ViewState) {
        fatalError("render() must be overidden in concrete implementations of MviViewController")
    }
    
    func provideViewModel() -> ViewModel {
        fatalError("viewModel() must be overidden in concrete implementations of MviViewController")
    }
    
    //
    // MARK -> @protocol/BundleSender
    //
    func setDestinationBundle(bundle: SegueBundle) {
        self.destinationBundle = bundle
    }
    
    func getDestinationBundle() -> SegueBundle? {
        return self.destinationBundle
    }
}

protocol Mvi {
    associatedtype Intent
    associatedtype ViewState
    associatedtype ViewModel
    
    func intents() -> Observable<Intent>
    
    func idleIntent() -> Intent
    
    func render(state: ViewState)
    
    func provideViewModel() -> ViewModel
}
