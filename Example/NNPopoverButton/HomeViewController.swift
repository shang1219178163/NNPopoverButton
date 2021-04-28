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
        let sender = NNPopoverButton(type: .custom)
        sender.setTitle("Left", for: .normal)
        sender.setTitleColor(UIColor.systemBlue, for: .normal)
        sender.sizeToFit()
        sender.list = ["0", "1", "2", "3", "4", "5", "6",]
        sender.contentWidth = 200

        sender.addTarget(self, action: #selector(showPopoverAction(_:)), for: .touchUpInside)
        return sender
    }()
    
    lazy var rightBtn: NNPopoverButton = {
        let sender = NNPopoverButton(type: .custom)
        sender.setTitle("Right", for: .normal)
        sender.setTitleColor(UIColor.systemBlue, for: .normal)
        sender.sizeToFit()
        sender.list = ["00", "11", "22", "33", "44", "55", "66",]
        sender.contentWidth = 100

        sender.addTarget(self, action: #selector(showPopoverAction(_:)), for: .touchUpInside)
        return sender
    }()
    
    lazy var topBtn: NNPopoverButton = {
        let sender = NNPopoverButton(type: .custom)
        sender.setTitle("UIButton 顶部", for: .normal)
        sender.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor = UIColor.systemBlue
        
        sender.sizeToFit()
        sender.list = ["0", "1", "2", "3", "4", "5", "6","7", "8", "9", "10", "11", "12","13", "14", "15", "16", "17", "18", "19", "20",]
        sender.block = { sender, tableView, indexP in
            print("\(#function)_\(sender.currentTitle ?? "")_\(indexP.row)")
        }
        sender.contentVC = popoverContentVC

//        sender.rowCount = 6
        sender.addTarget(self, action: #selector(showPopoverAction(_:)), for: .touchUpInside)
        return sender
    }()
    
    lazy var btn: NNPopoverButton = {
        let sender = NNPopoverButton(type: .custom)
        sender.setTitle("UIButton", for: .normal)
        sender.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor = UIColor.systemBlue
        
        sender.sizeToFit()
        sender.list = ["0", "1", "2", "3", "4", "5", "6","7", "8", "9", "10", "11", "12","13", "14", "15", "16", "17", "18", "19", "20",]
        sender.isTapBackViewDismiss = true
//        sender.contentVC = popoverContentVC
        
        sender.addTarget(self, action: #selector(showPopoverAction(_:)), for: .touchUpInside)
        return sender
    }()
    
    lazy var bomBtn: NNPopoverButton = {
        let sender = NNPopoverButton(type: .custom)
        sender.setTitle("UIButton 底部", for: .normal)
        sender.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor = UIColor.systemBlue
        
        sender.sizeToFit()
        sender.list = ["0", "1", "2", "3", "4", "5", "6","7", "8", "9", "10", "11", "12","13", "14", "15", "16", "17", "18", "19", "20",]
//        sender.rowCount = 6

        return sender
    }()
    
    
    public lazy var popoverContentVC: UIViewController = {
        let vc = GreenViewController()
        return vc
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

        topBtn.frame = CGRect(x: 0, y: 0, width: 120, height: 40)
        view.addSubview(topBtn)
        
        btn.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        view.addSubview(btn)
        
        bomBtn.frame = CGRect(x: 0, y: 0, width: 120, height: 40)
        view.addSubview(bomBtn)

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapAction))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topBtn.center = CGPoint(x: view.center.x, y: 120)
        btn.center = view.center
        bomBtn.center = CGPoint(x: view.center.x, y: btn.center.y + 300)
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
//        print("\(#function)_\(sender.currentTitle)")
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
    }
}

