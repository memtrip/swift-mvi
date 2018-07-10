import UIKit
import RxSwift
import RxCocoa

class PinyinPhoneticViewController : PinyinListViewController<PinyinPhoneticViewModel> {
    
    private lazy var pinyinPhoneticTableView: PinyinPhoneticTableView = {
        let tableView = PinyinPhoneticTableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.frame = self.view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = UIColor.App.Background
        
        if let view = tableView.backgroundView {
            view.backgroundColor = UIColor.App.Background
        }

        return tableView
    }()
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(pinyinPhoneticTableView)
    }
    
    override func populate(pinyinList: Array<Pinyin>) {
        pinyinPhoneticTableView.populate(pinyin: pinyinList)
    }
    
    override func provideViewModel() -> PinyinPhoneticViewModel {
        return PinyinPhoneticViewModel()
    }
    
    override func intents() -> Observable<PinyinListIntent> {
        return Observable.merge(
            super.intents(),
            pinyinPhoneticTableView.rx.itemSelected
                .asObservable()
                .map { index in self.pinyinPhoneticTableView.get(index: index.row) }
                .map { pinyin in PinyinListIntent.SelectItem(pinyin: pinyin) }
        )
    }
}
