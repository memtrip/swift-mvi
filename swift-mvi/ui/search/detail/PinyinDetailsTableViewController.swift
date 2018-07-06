import UIKit

class PinyinDetailTableViewController : UITableViewController {
    @IBOutlet weak var phoneticScript: UILabel!
    @IBOutlet weak var englishTranslation: UILabel!
    @IBOutlet weak var chineseCharacters: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 240
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
