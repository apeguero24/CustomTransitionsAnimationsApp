//
//  LeftToRightDismissAnimation.swift
//  CustomTransitionsAnimationsApp
//
//  Created by Andres Peguero on 6/7/18.
//  Copyright © 2018 Andres Peguero. All rights reserved.
//

import UIKit

class LeftToRightDismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let originFrame: CGRect
    
    init(originFrame: CGRect) {
        self.originFrame = originFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        toVC.view.frame.origin.x += originFrame.width * (2/3)
        let leftOffset = -originFrame.width
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(fromVC.view)
        
        fromVC.view.layer.shadowColor = UIColor.black.cgColor
        fromVC.view.layer.shadowOpacity = 0.6
        fromVC.view.layer.shadowOffset = CGSize.zero
        fromVC.view.layer.shadowRadius = 5
        fromVC.view.layer.shouldRasterize = true
        
        toVC.view.alpha = 0.5
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            fromVC.view.frame.origin.x += leftOffset
            toVC.view.frame = self.originFrame
            toVC.view.alpha = 1
        }) { _ in
            
            if transitionContext.transitionWasCancelled {
                toVC.view.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
