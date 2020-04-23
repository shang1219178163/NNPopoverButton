//
//  HomeViewController.swift
//  NNPopoverButton
//
//  Created by shang1219178163 on 04/23/2020.
//  Copyright (c) 2020 shang1219178163. All rights reserved.
//

import UIKit
import NNPopoverButton

class HomeViewController: UIViewController {

    lazy var leftBtn: NNPopoverButton = {
        let button = NNPopoverButton(type: .custom)
        button.setTitle("Left", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.sizeToFit()
        button.parentVC = self
        button.contentWidth = 200
        button.list = ["0", "1", "2", "3", "4", "5", "6",]
                
        button.addTarget(self, action: #selector(showPopoverAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var rightBtn: NNPopoverButton = {
        let button = NNPopoverButton(type: .custom)
        button.setTitle("Right", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.sizeToFit()
        button.parentVC = self
        button.list = ["00", "11", "22", "33", "44", "55", "66",]

        button.addTarget(self, action: #selector(showPopoverAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var btn: NNPopoverButton = {
        let button = NNPopoverButton(type: .custom)
        button.setTitle("UIButton", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        
        button.sizeToFit()
        button.parentVC = self
        button.list = ["0", "1", "2", "3", "4", "5", "6","7", "8", "9", "10", "11", "12","13", "14", "15", "16", "17", "18", "19", "20",]
        button.tapDimmingViewDismiss = false
        
        button.addTarget(self, action: #selector(showPopoverAction(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        title = "主界面"
//        title = NSLocalizedString("主界面", comment: "")
        title = Bundle.localizedString(forKey: "主界面")
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)

        btn.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        btn.center = view.center
        view.addSubview(btn)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapAction))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -funtions
    @objc func showPopoverAction(_ sender: NNPopoverButton) {
        sender.presentPopover()
        
    }
    
    @objc func handleTapAction() {
        print("\(#function)")
        let controller = ListViewController()
        navigationController?.pushViewController(controller, animated: true)
    }

}

extension HomeViewController: NNPopoverButtonDelegate {
    public func popoverButton(_ popoverBtn: NNPopoverButton, tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(#function):\(indexPath.row)")
        
//        popoverBtn.dismiss()
    }
}
