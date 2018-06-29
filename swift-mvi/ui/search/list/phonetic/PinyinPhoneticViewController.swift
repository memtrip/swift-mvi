import UIKit
import RxSwift
import RxCocoa

class PinyinPhoneticViewController : PinyinListViewController<PinyinCharacterViewModel> {
    
    private lazy var pinyinPhoneticTableView: PinyinPhoneticTableView = {
        let tableView = PinyinPhoneticTableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.frame = self.view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(pinyinPhoneticTableView)
    }
    
    override func populate(pinyinList: Array<Pinyin>) {
        pinyinPhoneticTableView.populate(pinyin: pinyinList)
    }
    
    override func provideViewModel() -> PinyinCharacterViewModel {
        return PinyinCharacterViewModel()
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
