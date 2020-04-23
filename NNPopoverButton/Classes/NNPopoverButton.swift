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

    public var parentVC: UIViewController?
    
    lazy var popoverContentVC: NNPopoverListController = {
        let controller = NNPopoverListController()
        controller.modalPresentationStyle = .popover

        return controller
    }()
    
    public var contentSize: CGSize = .zero
    public var contentWidth: CGFloat = 0.0

    public var list: [String] = []

    // MARK: -lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NNPopoverButton: UIPopoverPresentationControllerDelegate {

    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
     
    public func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
    public func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
//        setAlphaOfBackgroundViews(1)
    }

    public func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
//        setAlphaOfBackgroundViews(0.7)
    }
}

extension NNPopoverButton: NNPopoverListDelegate {
    public func popoverList(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.popoverButton(self, tableView: tableView, didSelectRowAt: indexPath)
    }
}


public extension NNPopoverButton {
    
    @objc func presentPopover(_ arrowDirection: UIPopoverArrowDirection = .up, completion: (() -> Void)? = nil){
        assert(list.count != 0, "list 不能为空")
        guard let parentVC = parentVC else {
            print("\(#function): parentVC 不能为空")
            return
        }
        
        if parentVC.conforms(to: NNPopoverButtonDelegate.self) {
            delegate = parentVC as? NNPopoverButtonDelegate;
        }

        popoverContentVC.modalPresentationStyle = .popover
        if __CGSizeEqualToSize(.zero, contentSize) == false {
            popoverContentVC.preferredContentSize = contentSize
        } else {
            let heigth: CGFloat = popoverContentVC.tableView.rowHeight * CGFloat(list.count)
            let width: CGFloat = contentWidth > 0 ? contentWidth : frame.width*2
            popoverContentVC.preferredContentSize = CGSize(width: width, height: heigth)
        }
        
        popoverContentVC.delegate = self
        popoverContentVC.list = list

        guard let superview = superview else { return }
        var rect = frame
        if superview.isKind(of: UINavigationBar.classForCoder()) {
            rect = superview.convert(frame, to: parentVC.view)
        }

        guard let popoverPresentationVC = popoverContentVC.popoverPresentationController else { return }
        popoverPresentationVC.permittedArrowDirections = arrowDirection
        popoverPresentationVC.sourceView = parentVC.view
        popoverPresentationVC.sourceRect = rect
        popoverPresentationVC.delegate = self
        parentVC.present(popoverContentVC, animated: true, completion: completion)
    }
    
}