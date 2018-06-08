//
//  LeftToRightAnimation.swift
//  CustomTransitionsAnimationsApp
//
//  Created by Andres Peguero on 6/7/18.
//  Copyright © 2018 Andres Peguero. All rights reserved.
//

import UIKit

class LeftToRightPresentAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let originFrame: CGRect
    
    init(originFrame: CGRect) {
        self.originFrame = originFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from) else { return }
        
        let contrainerView = transitionContext.containerView
        
        toVC.view.frame.origin.x = -originFrame.width
        let rightOffset = originFrame.width / 3
        
        contrainerView.addSubview(fromVC.view)
        contrainerView.addSubview(toVC.view)
        
        toVC.view.layer.shadowColor = UIColor.black.cgColor
        toVC.view.layer.shadowOpacity = 0.6
        toVC.view.layer.shadowOffset = CGSize.zero
        toVC.view.layer.shadowRadius = 5
        toVC.view.layer.shouldRasterize = true
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            toVC.view.frame = self.originFrame
            fromVC.view.frame.origin.x += rightOffset
            fromVC.view.alpha = 0.5
            
        }) { _ in
            fromVC.view.frame = self.originFrame
            fromVC.view.alpha = 1.0
            toVC.view.layer.shadowOpacity = 0
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }

}
