//
//  FractionalHeightPresentationController.swift
//  Miscellany
//
//  Created by Theodore Gallao on 9/19/19.
//  Copyright © 2019 Theodore Gallao. All rights reserved.
//

import Foundation
import UIKit

/// Presents the `UIViewController` modally with a given fractional height between 0.0 and 1.0
class FractionalHeightPresentationController: UIPresentationController {
    var fractionalHeight: CGFloat = 0.5
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    private(set) lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTapView(_:)))
        
        return tapGesture
    }()
    
    private(set) lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanPresentedView(_:)))
        
        return panGestureRecognizer
    }()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        self.view.addGestureRecognizer(self.tapGestureRecognizer)
        self.presentedView?.addGestureRecognizer(self.panGestureRecognizer)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect{
        let containerViewHeight = self.containerView?.frame.height ?? 0
        let width = self.containerView?.frame.width ?? 0
        let yOrigin = containerViewHeight * (1 - self.fractionalHeight)
        let presentedViewHeight = containerViewHeight * self.fractionalHeight
        
        return CGRect(
            origin: CGPoint(
                x: 0,
                y: yOrigin),
            size: CGSize(
                width: width,
                height: presentedViewHeight))
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        self.containerView?.addSubview(self.view)
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        self.presentedView?.layer.masksToBounds = true
        self.presentedView?.layer.cornerRadius = 10
        self.presentedView?.layer.maskedCorners = [
            .layerMinXMinYCorner, .
            layerMaxXMinYCorner]
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        self.presentedView?.frame = self.frameOfPresentedViewInContainerView
        self.view.frame = self.containerView!.bounds
    }
}

// MARK: Selectors
extension FractionalHeightPresentationController {
    @objc private func handleTapView(_ sender: UITapGestureRecognizer){
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    @objc private func handlePanPresentedView(_ sender: UIPanGestureRecognizer) {
        let yTranslation = max(0, sender.translation(in: sender.view).y)
        let containerViewHeight = containerView?.frame.height ?? 0
        let presentedViewHeight = self.fractionalHeight * containerViewHeight
        let dismissThreshold = (self.fractionalHeight * presentedViewHeight) / 2
        let yOrigin = containerViewHeight * (1 - self.fractionalHeight)
        
        if sender.state == .ended {
            if yTranslation > dismissThreshold {
                self.presentedViewController.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 1 / 3) {
                    self.presentedView?.frame.origin.y = containerViewHeight * (1 - self.fractionalHeight)
                    self.presentedView?.layoutIfNeeded()
                }
            }
        } else if sender.state == .changed {
            UIView.animate(withDuration: 0) {
                self.presentedView?.frame.origin.y = yOrigin + yTranslation
                self.presentedView?.layoutIfNeeded()
            }
        }
    }
}
