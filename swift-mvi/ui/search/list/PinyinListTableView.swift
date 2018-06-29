import UIKit

class PinyinListTableView<C : UITableViewCell> : UITableView, UITableViewDelegate, UITableViewDataSource {
    
    private var pinyin = Array<Pinyin>()
    
    func populate(pinyin: Array<Pinyin>) {
        self.pinyin.removeAll()
        self.pinyin.append(contentsOf: pinyin)
        self.reloadData()
    }
    
    func get(index: Int) -> Pinyin {
        return pinyin[index]
    }
    
    func cellId() -> String {
        fatalError("cellId() must be overidden in concrete implementations of PinyinListTableView")
    }
    
    func nibName() -> String {
        fatalError("nibName() must be overidden in concrete implementations of PinyinListTableView")
    }
    
    func createCell(tableView: UITableView, indexPath: IndexPath) -> C {
        fatalError("createCell() must be overidden in concrete implementations of PinyinListTableView")
    }
    
    func bindCell(cell: C, pinyin: Pinyin) -> C {
        fatalError("bindCell() must be overidden in concrete implementations of PinyinListTableView")
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.separatorStyle = UITableViewCellSeparatorStyle.none
        self.delegate = self
        self.dataSource = self
        
        self.register(UINib(nibName: nibName(), bundle: nil), forCellReuseIdentifier: cellId())
        
        self.estimatedRowHeight = 200
        self.rowHeight = UITableViewAutomaticDimension
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    // MARK -> @protocol/UITableViewDataSource
    //    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return pinyin.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = createCell(tableView: tableView, indexPath: indexPath)
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return bindCell(
            cell: cell,
            pinyin: self.pinyin[indexPath.row]
        )
    }
    
    //
    // MARK -> @protocol/UITableViewDelegate
    //
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
