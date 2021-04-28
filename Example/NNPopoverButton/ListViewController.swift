//
//  ListViewController.swift
//  NNPopoverButton_Example
//
//  Created by Bin Shang on 2020/4/23.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import NNPopoverButton

/// 列表
@objcMembers class ListViewController: UIViewController{

    // MARK: - lazy
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
        
    lazy var rightBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Show", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.sizeToFit()

        button.addTarget(self, action: #selector(handleAction(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func handleAction(_ sender: UIButton) {
        
    }
    
    lazy var popoverBtn: NNPopoverButton = {
        let sender = NNPopoverButton(type: .custom)
        sender.setTitle("Right", for: .normal)
        sender.setTitleColor(UIColor.systemBlue, for: .normal)
        sender.sizeToFit()
        sender.list = ["00", "11", "22", "33", "44", "55", "66",]

        sender.addTarget(self, action: #selector(showPopoverAction(_:)), for: .touchUpInside)
        return sender
    }()
    
    @objc func showPopoverAction(_ sender: NNPopoverButton) {
        sender.presentPopover()
    }
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
                
//        self.preferredContentSize = CGSize(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.height*0.5)
//        print(#function, #line, ":preferredContentSize", preferredContentSize)
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - funtions
    func setupUI() {
        title = "List"
        view.backgroundColor = UIColor.red

//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        view.addSubview(tableView);
    }

}

extension ListViewController: UITableViewDataSource, UITableViewDelegate{
    //    MARK: - tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") ?? UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        cell.selectionStyle = .none;
        cell.separatorInset = .zero;
        cell.layoutMargins = .zero;
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.textLabel?.textColor = UIColor.systemBlue
        cell.textLabel?.text = "row_\(indexPath.row)"

        var popoverBtn: NNPopoverButton {
            let sender = NNPopoverButton(type: .custom)
            sender.setTitle("Show", for: .normal)
            sender.setTitleColor(UIColor.systemBlue, for: .normal)
            sender.sizeToFit()
            
//            sender.list = ["00", "11", "22", "33", "44", "55", "66",]
            sender.list = ["row_\(indexPath.row)",]
//            sender.contentWidth = 150

            sender.arrowDirection = UIPopoverArrowDirection(rawValue: 0)
            sender.offset = UIOffset(horizontal: -120, vertical: 10)
            
            sender.addTarget(self, action: #selector(showPopoverAction(_:)), for: .touchUpInside)
            return sender
        }
        
        cell.accessoryView = popoverBtn
        cell.accessoryView?.layer.borderWidth = 1
        cell.accessoryView?.layer.borderColor = UIColor.blue.cgColor

//        cell.getViewLayer()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UILabel();
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UILabel();
    }
}
