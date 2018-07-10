import UIKit
import RxCocoa
import RxSwift

class PinyinPhoneticTableView: PinyinListTableView<PinyinPhoneticTableViewCell> {

    override func cellId() -> String {
        return "phoneticCell"
    }

    override func nibName() -> String {
        return "PinyinPhoneticTableViewCell"
    }

    override func createCell(tableView: UITableView, indexPath: IndexPath) -> PinyinPhoneticTableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId(), for: indexPath)
         if let pinyinPhoneticTableViewCell = cell as? PinyinPhoneticTableViewCell {
            return pinyinPhoneticTableViewCell
         } else {
            fatalError("cell must be a PinyinPhoneticTableViewCell")
         }
    }

    override func bindCell(cell: PinyinPhoneticTableViewCell, pinyin: Pinyin) -> PinyinPhoneticTableViewCell {
        cell.phoneticScriptText.text = pinyin.phoneticScriptText
        return cell
    }
}
