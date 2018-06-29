import UIKit

class PinyinCharacterTableView : PinyinListTableView<PinyinCharacterTableViewCell> {

    override func cellId() -> String {
        return "characterCell"
    }
    
    override func nibName() -> String {
        return "PinyinCharacterTableViewCell"
    }
    
    override func createCell(tableView: UITableView, indexPath: IndexPath) -> PinyinCharacterTableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: self.cellId(), for: indexPath) as! PinyinCharacterTableViewCell
    }
    
    override func bindCell(cell: PinyinCharacterTableViewCell, pinyin: Pinyin) -> PinyinCharacterTableViewCell {
        cell.chineseCharactersText.text = pinyin.chineseCharacters
        return cell
    }
}
