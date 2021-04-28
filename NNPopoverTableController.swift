//
//  NNPopoverTableController.swift
//  NNPopoverButton
//
//  Created by Bin Shang on 2021/4/28.
//

import UIKit


@objc public protocol NNPopoverTableDelegate{
    @objc func popover(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)

}

@objcMembers public class NNPopoverTableController: UITableViewController {
    
    public weak var delegate: NNPopoverTableDelegate?
    public var block: ((UITableView, IndexPath)->Void)?

    public var list: [String] = []{
        willSet{
            tableView.reloadData()
        }
    }
    
    private var indexP: IndexPath = IndexPath(row: 0, section: 0)

    // MARK: -lifcycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white;

        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.separatorStyle = .singleLine;
        tableView.separatorInset = .zero;
        tableView.rowHeight = 50;
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self));
        tableView.keyboardDismissMode = .onDrag
        
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count;
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") ?? UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        cell.selectionStyle = .none;
        cell.separatorInset = .zero;
        cell.layoutMargins = .zero;
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.textLabel?.textColor = indexP == indexPath ? UIColor.systemBlue : UIColor.gray;
        cell.accessoryType = indexP == indexPath ? .checkmark : .none;
        
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexP != indexPath  {
            let newCell = tableView.cellForRow(at: indexPath)
            newCell?.accessoryType = .checkmark
            newCell?.textLabel?.textColor = UIColor.systemBlue

            let oldCell = tableView.cellForRow(at: indexP)
            oldCell?.accessoryType = .none
            oldCell?.textLabel?.textColor = UIColor.gray;
            indexP = indexPath
        }
        delegate?.popover(tableView, didSelectRowAt: indexPath)
        block?(tableView, indexPath)
    }
    
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView();
    }
    
    public override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
    public override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView();
    }
    
}

