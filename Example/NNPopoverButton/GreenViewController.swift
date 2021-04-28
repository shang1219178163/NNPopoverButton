//
//  GreenViewController.swift
//  NNPopoverButton_Example
//
//  Created by Bin Shang on 2021/4/28.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class GreenViewController: UIViewController {

    lazy var btn: UIButton = {
        let sender = UIButton(type: .custom)
        sender.setTitle("UIButton", for: .normal)
        sender.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor = UIColor.systemBlue
        
        sender.sizeToFit()
        sender.addTarget(self, action: #selector(handleAction(_:)), for: .touchUpInside)
        return sender
    }()
    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGreen
        
        btn.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        view.addSubview(btn)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        btn.center = view.center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
                
//        self.preferredContentSize = CGSize(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.height*0.5)
//        print(#function, #line, ":preferredContentSize", preferredContentSize)
    }
    
    // MARK: -funtions
    @objc func handleAction(_ sender: UIButton) {
//        print("\(#function)_\(sender.currentTitle)")
        self.dismiss(animated: true, completion: nil)
    }
}
