//
//	NNPopoverButtonView.swift
//	MacTemplet
//
//	Created by shang on 2020/04/23 10:02
//	Copyright © 2020 shang. All rights reserved.
//

import UIKit

@objc public protocol NNPopoverButtonDelegate{
    @objc func popoverButton(_ popoverBtn: NNPopoverButton, tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}

@objcMembers public class NNPopoverButton: UIButton {

    public weak var delegate: NNPopoverButtonDelegate?
    public var block: ((NNPopoverButton, UITableView, IndexPath)->Void)?

    public var parentVC: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
    
    public var contentVC: UIViewController = NNPopoverTableController()
    public var contentSize: CGSize = .zero
    public var contentWidth: CGFloat = UIScreen.main.bounds.width*0.5

    public var isTapBackViewDismiss: Bool = true
    public var isShowTableContentVC: Bool = true
    public var list: [String] = []

    public var rowCount = NSInteger.max

    // MARK: -lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTarget(self, action: #selector(showPopoverAction(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -funtions
    @objc func showPopoverAction(_ sender: NNPopoverButton) {
        if isShowTableContentVC {
            presentPopover(contentVC, arrowDirection: .any, completion: nil)
        }
    }
    
    public func presentPopover(_ contentVC: UIViewController = NNPopoverTableController(),
                               arrowDirection: UIPopoverArrowDirection = .any,
                               completion: (() -> Void)? = nil){
        if contentVC.presentingViewController != nil {
            return
        }
        contentVC.modalPresentationStyle = .popover
        if __CGSizeEqualToSize(.zero, contentVC.preferredContentSize) == false {

        } else if __CGSizeEqualToSize(.zero, contentSize) == false {
            contentVC.preferredContentSize = contentSize
        }

        if let vc = contentVC as? NNPopoverTableController {
            if __CGSizeEqualToSize(.zero, contentVC.preferredContentSize) == false {
                
            } else {
                let heigth: CGFloat = vc.tableView.rowHeight * CGFloat(min(list.count, rowCount))
                vc.preferredContentSize = CGSize(width: contentWidth, height: heigth)
            }
            vc.delegate = self
            vc.list = list
        }

        guard let superview = superview, let rootViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        let rect = superview.convert(frame, to: rootViewController.view)

        guard let popoverPresentationVC = contentVC.popoverPresentationController else { return }
        popoverPresentationVC.permittedArrowDirections = arrowDirection
        popoverPresentationVC.sourceView = rootViewController.view
        popoverPresentationVC.sourceRect = rect
        popoverPresentationVC.delegate = self
        rootViewController.present(contentVC, animated: true, completion: completion)
    }
    
    public func dismiss(){
        if contentVC.presentingViewController == nil {
            return;
        }
        DispatchQueue.main.async {
            self.contentVC.dismiss(animated: false, completion: nil)
        }
    }
}

extension NNPopoverButton: UIPopoverPresentationControllerDelegate {

    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
     
    public func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
//        setAlphaOfBackgroundViews(0.7)
    }
    
    public func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return isTapBackViewDismiss
    }
    
    public func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
//        setAlphaOfBackgroundViews(1)
    }

    public func popoverPresentationController(_ popoverPresentationController: UIPopoverPresentationController, willRepositionPopoverTo rect: UnsafeMutablePointer<CGRect>, in view: AutoreleasingUnsafeMutablePointer<UIView>) {
        print(#function, rect, view)
    }

}

extension NNPopoverButton: NNPopoverTableDelegate {
    public func popover(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.popoverButton(self, tableView: tableView, didSelectRowAt: indexPath)
        block?(self, tableView, indexPath)
        dismiss()
    }
}


