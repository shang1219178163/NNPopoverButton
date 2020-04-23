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
        let button = NNPopoverButton(type: .custom)
        button.setTitle("Right", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.sizeToFit()
        button.parentVC = self
        button.list = ["00", "11", "22", "33", "44", "55", "66",]

        button.addTarget(self, action: #selector(showPopoverAction(_:)), for: .touchUpInside)
        return button
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
        var cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        }
        cell!.selectionStyle = .none;
        cell!.separatorInset = .zero;
        cell!.layoutMargins = .zero;
        
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell!.textLabel?.textColor = UIColor.systemBlue
        cell!.textLabel?.text = "row_\(indexPath.row)"

        var popoverBtn: NNPopoverButton {
            let button = NNPopoverButton(type: .custom)
            button.setTitle("Show", for: .normal)
            button.setTitleColor(UIColor.systemBlue, for: .normal)
            button.sizeToFit()
            button.parentVC = self
            button.list = ["00", "11", "22", "33", "44", "55", "66",]

            button.addTarget(self, action: #selector(showPopoverAction(_:)), for: .touchUpInside)
            return button
        }
        
        cell!.accessoryView = popoverBtn

//        cell.getViewLayer()
        return cell!
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
