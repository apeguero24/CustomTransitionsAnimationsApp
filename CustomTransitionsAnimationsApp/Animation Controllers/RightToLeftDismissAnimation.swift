//
//  RightToLeftDismissAnimation.swift
//  CustomTransitionsAnimationsApp
//
//  Created by Andres Peguero on 6/8/18.
//  Copyright © 2018 Andres Peguero. All rights reserved.
//

import UIKit

class RightToLeftDismissAnimation: NSObject, UIViewControllerAnimatedTransitioning{
    
    private let originFrame: CGRect
    let interactionController: SwipeRightToLeftInteraction?
    
    init(originFrame: CGRect, interactionController: SwipeRightToLeftInteraction?) {
        self.originFrame = originFrame
        self.interactionController = interactionController
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        toVC.view.frame.origin.x += -originFrame.width * (2/3)
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(fromVC.view)
        
        fromVC.view.layer.shadowColor = UIColor.black.cgColor
        fromVC.view.layer.shadowOpacity = 0.6
        fromVC.view.layer.shadowOffset = CGSize.zero
        fromVC.view.layer.shadowRadius = 5
        fromVC.view.layer.shouldRasterize = true
        fromVC.view.layer.rasterizationScale = UIScreen.main.scale
        
        toVC.view.alpha = 0.5
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            fromVC.view.frame.origin.x += self.originFrame.width
            toVC.view.frame = self.originFrame
            toVC.view.alpha = 1
        }) { _ in
            
            if transitionContext.transitionWasCancelled {
                toVC.view.frame = self.originFrame
                toVC.view.alpha = 0.5
                fromVC.view.frame = self.originFrame
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    

}
