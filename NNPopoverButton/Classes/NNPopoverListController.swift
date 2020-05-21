//
//  NNPopoverListController.swift
//  NNPopoverButton
//
//  Created by Bin Shang on 2020/4/23.
//

import UIKit

@objc public protocol NNPopoverListDelegate{
    @objc func popoverList(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)

}
    
@objcMembers public class NNPopoverListController: UIViewController {

    public weak var delegate: NNPopoverListDelegate?

    public var list: [String] = []{
        willSet{
            tableView.reloadData()
        }
    }
    
    var indexP: IndexPath = IndexPath(row: 0, section: 0)

    public lazy var tableView: UITableView = {
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
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(tableView)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
    }

}

extension NNPopoverListController: UITableViewDataSource, UITableViewDelegate {
    //    MARK: - tableView
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count;
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        }
        cell!.selectionStyle = .none;
        cell!.separatorInset = .zero;
        cell!.layoutMargins = .zero;
        
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell!.textLabel?.textColor = indexP == indexPath ? .systemBlue : .gray;
        cell!.accessoryType = indexP == indexPath ? .checkmark : .none;
        
        cell!.textLabel?.text = list[indexPath.row]
        
//        cell.getViewLayer()
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexP != indexPath  {
            let newCell = tableView.cellForRow(at: indexPath)
            newCell?.accessoryType = .checkmark
            newCell?.textLabel?.textColor = UIColor.systemBlue

            let oldCell = tableView.cellForRow(at: indexP)
            oldCell?.accessoryType = .none
            oldCell?.textLabel?.textColor = .gray;
            indexP = indexPath
        }
        delegate?.popoverList(tableView, didSelectRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return UIView();
//    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let label = UILabel(frame: .zero);
//        //        label.backgroundColor = .green;
//        //        label.text = "header\(section)";
//        return label;
//    }
    
}

