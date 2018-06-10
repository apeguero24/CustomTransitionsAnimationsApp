//
//  SlideOutMenuDismissAnimation.swift
//  CustomTransitionsAnimationsApp
//
//  Created by Andres Peguero on 6/9/18.
//  Copyright © 2018 Andres Peguero. All rights reserved.
//

import UIKit

class SlideOutMenuDismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let originFrame: CGRect
    var interaction: SlideOutMenuDismissInteration?
    
    init(originFrame: CGRect, interaction: SlideOutMenuDismissInteration?) {
        self.originFrame = originFrame
        self.interaction = interaction
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let snapshop = transitionContext.containerView.viewWithTag(320)
            else { return }
        
        let containerView = transitionContext.containerView
        let menuWidth = originFrame.width - (originFrame.width / 7)
        let menuFrame = CGRect(x: originFrame.origin.x, y: originFrame.origin.y, width: menuWidth, height: originFrame.height)
        let rightOffset = originFrame.width / 3
        let snapshotFrame = snapshop.frame
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(fromVC.view)
        
        fromVC.view.layer.shadowColor = UIColor.black.cgColor
        fromVC.view.layer.shadowOpacity = 0.6
        fromVC.view.layer.shadowOffset = CGSize.zero
        fromVC.view.layer.shadowRadius = 5
        fromVC.view.layer.shouldRasterize = true
        fromVC.view.layer.rasterizationScale = UIScreen.main.scale

        toVC.view.frame = self.originFrame
        toVC.view.alpha = 0
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            fromVC.view.frame.origin.x -= self.originFrame.width
            snapshop.frame = self.originFrame
            snapshop.alpha = 1
        }) { _ in
            
            if transitionContext.transitionWasCancelled {
                snapshop.frame = snapshotFrame
                snapshop.alpha = 0.5
                fromVC.view.frame = menuFrame
            }
            
            if !transitionContext.transitionWasCancelled {
                toVC.view.alpha = 1
                snapshop.removeFromSuperview()
            }
    
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
