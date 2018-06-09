//
//  SlideOutMenuPresentAnimation.swift
//  CustomTransitionsAnimationsApp
//
//  Created by Andres Peguero on 6/9/18.
//  Copyright © 2018 Andres Peguero. All rights reserved.
//

import UIKit

class SlideOutMenuPresentAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let originFrame: CGRect
    
    init(originFrame: CGRect) {
        self.originFrame = originFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from),
            let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
            else { return }
        
        let contrainerView = transitionContext.containerView
        snapshot.tag = 320
        
        toVC.view.frame.origin.x = -originFrame.width
        let menuWidth = originFrame.width - (originFrame.width / 7)
        let menuFrame = CGRect(x: originFrame.origin.x, y: originFrame.origin.y, width: menuWidth, height: originFrame.height)
        let rightOffset = originFrame.width / 3
        
        contrainerView.addSubview(fromVC.view)
        contrainerView.addSubview(snapshot)
        contrainerView.addSubview(toVC.view)
        
        fromVC.view.alpha = 0
        
        toVC.view.layer.shadowColor = UIColor.black.cgColor
        toVC.view.layer.shadowOpacity = 0.6
        toVC.view.layer.shadowOffset = CGSize.zero
        toVC.view.layer.shadowRadius = 5
        toVC.view.layer.shouldRasterize = true
        toVC.view.layer.rasterizationScale = UIScreen.main.scale
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            toVC.view.frame = menuFrame
            snapshot.frame.origin.x += rightOffset
            snapshot.alpha = 0.5
            
        }) { _ in
            fromVC.view.frame = self.originFrame
            fromVC.view.alpha = 1.0
            //toVC.view.layer.shadowOpacity = 0
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
}
