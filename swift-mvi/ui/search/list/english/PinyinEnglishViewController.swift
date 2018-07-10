import UIKit
import RxCocoa
import RxSwift

class PinyinEnglishViewController: PinyinListViewController<PinyinEnglishViewModel> {

    private lazy var pinyinEnglishTableView: PinyinEnglishTableView = {
        let tableView = PinyinEnglishTableView(frame: self.view.bounds, style: UITableViewStyle.plain)
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
        self.view.addSubview(pinyinEnglishTableView)
    }

    override func populate(pinyinList: [Pinyin]) {
        pinyinEnglishTableView.populate(pinyin: pinyinList)
    }

    override func provideViewModel() -> PinyinEnglishViewModel {
        return PinyinEnglishViewModel()
    }

    override func intents() -> Observable<PinyinListIntent> {
        return Observable.merge(
            super.intents(),
            pinyinEnglishTableView.rx.itemSelected
                .asObservable()
                .map { index in self.pinyinEnglishTableView.get(index: index.row) }
                .map { pinyin in PinyinListIntent.selectItem(pinyin: pinyin) }
        )
    }
}
