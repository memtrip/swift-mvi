import UIKit

class PinyinCharacterTableView: PinyinListTableView<PinyinCharacterTableViewCell> {

    override func cellId() -> String {
        return "characterCell"
    }

    override func nibName() -> String {
        return "PinyinCharacterTableViewCell"
    }

    override func createCell(tableView: UITableView, indexPath: IndexPath) -> PinyinCharacterTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId(), for: indexPath)
        if let pinyinCharacterTableViewCell = cell as? PinyinCharacterTableViewCell {
            return pinyinCharacterTableViewCell
        } else {
            fatalError("cell must be a PinyinCharacterTableViewCell")
        }
    }

    override func bindCell(cell: PinyinCharacterTableViewCell, pinyin: Pinyin) -> PinyinCharacterTableViewCell {
        cell.chineseCharactersText.text = pinyin.chineseCharacters
        return cell
    }
}
