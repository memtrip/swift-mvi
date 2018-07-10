import UIKit

class PinyinEnglishTableView: PinyinListTableView<PinyinEnglishTableViewCell> {

    override func cellId() -> String {
        return "englishCell"
    }

    override func nibName() -> String {
        return "PinyinEnglishTableViewCell"
    }

    override func createCell(tableView: UITableView, indexPath: IndexPath) -> PinyinEnglishTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId(), for: indexPath)
        if let pinyinEnglishTableViewCell = cell as? PinyinEnglishTableViewCell {
            return pinyinEnglishTableViewCell
        } else {
            fatalError("cell must be a PinyinEnglishTableViewCell")
        }
    }

    override func bindCell(cell: PinyinEnglishTableViewCell, pinyin: Pinyin) -> PinyinEnglishTableViewCell {
        cell.englishTranslationText.text = pinyin.englishTranslationText
        return cell
    }
}
