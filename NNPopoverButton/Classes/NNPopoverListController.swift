//
//  NNPopoverListController.swift
//  NNPopoverButton
//
//  Created by Bin Shang on 2020/4/23.
//

import UIKit

@objc protocol NNPopoverListDelegate{
    @objc func popoverList(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)

}
    
@objcMembers class NNPopoverListController: UIViewController {

    weak var delegate: NNPopoverListDelegate?

    var list: [String] = []{
        willSet{
            tableView.reloadData()
        }
    }
    
    var indexP: IndexPath = IndexPath(row: 0, section: 0)

    lazy var tableView: UITableView = {
        let view: UITableView = UITableView(frame: self.view.bounds, style: .plain)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.separatorStyle = .singleLine;
        view.separatorInset = .zero;
        view.rowHeight = 50;
        view.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self));
        view.keyboardDismissMode = .onDrag
        view.backgroundColor = UIColor.white;
        
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: -life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
    }

}

extension NNPopoverListController: UITableViewDataSource, UITableViewDelegate {
    //    MARK: - tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        }
        cell!.selectionStyle = .none;
        cell!.separatorInset = .zero;
        cell!.layoutMargins = .zero;
        
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell!.textLabel?.textColor = indexP == indexPath ? UIColor.systemBlue : UIColor.gray;
        cell!.accessoryType = indexP == indexPath ? .checkmark : .none;
        
        cell!.textLabel?.text = list[indexPath.row]
        
//        cell.getViewLayer()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexP != indexPath  {
            let newCell = tableView.cellForRow(at: indexPath)
            newCell?.accessoryType = .checkmark
            newCell?.textLabel?.textColor = UIColor.systemBlue

            let oldCell = tableView.cellForRow(at: indexP)
            oldCell?.accessoryType = .none
            oldCell?.textLabel?.textColor = UIColor.gray;
            indexP = indexPath
        }
        delegate?.popoverList(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return UIView();
//    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let label = UILabel(frame: .zero);
//        //        label.backgroundColor = .green;
//        //        label.text = "header\(section)";
//        return label;
//    }
    
}

