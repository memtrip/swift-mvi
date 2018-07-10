import UIKit
import RxSwift
import RxCocoa

class PinyinCharacterViewController : PinyinListViewController<PinyinCharacterViewModel> {
    
    private lazy var pinyinCharacterTableView: PinyinCharacterTableView = {
        let tableView = PinyinCharacterTableView(frame: self.view.bounds, style: UITableViewStyle.plain)
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
        self.view.addSubview(pinyinCharacterTableView)
    }
    
    override func populate(pinyinList: Array<Pinyin>) {
        pinyinCharacterTableView.populate(pinyin: pinyinList)
    }
    
    override func provideViewModel() -> PinyinCharacterViewModel {
        return PinyinCharacterViewModel()
    }
    
    override func intents() -> Observable<PinyinListIntent> {
        return Observable.merge(
            super.intents(),
            pinyinCharacterTableView.rx.itemSelected
                .asObservable()
                .map { index in self.pinyinCharacterTableView.get(index: index.row) }
                .map { pinyin in PinyinListIntent.SelectItem(pinyin: pinyin) }
        )
    }
}
