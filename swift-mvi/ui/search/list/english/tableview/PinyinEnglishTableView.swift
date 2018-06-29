import UIKit

class PinyinEnglishTableView : PinyinListTableView<PinyinEnglishTableViewCell> {
    
    override func cellId() -> String {
        return "englishCell"
    }
    
    override func nibName() -> String {
        return "PinyinEnglishTableViewCell"
    }
    
    override func createCell(tableView: UITableView, indexPath: IndexPath) -> PinyinEnglishTableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: self.cellId(), for: indexPath) as! PinyinEnglishTableViewCell
    }
    
    override func bindCell(cell: PinyinEnglishTableViewCell, pinyin: Pinyin) -> PinyinEnglishTableViewCell {
        cell.englishTranslationText.text = pinyin.englishTranslationText
        return cell
    }
}
