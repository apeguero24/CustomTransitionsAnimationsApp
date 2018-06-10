//
//  SlideOutMenuDismissInteration.swift
//  CustomTransitionsAnimationsApp
//
//  Created by Andres Peguero on 6/9/18.
//  Copyright © 2018 Andres Peguero. All rights reserved.
//

import UIKit

class SlideOutMenuDismissInteration: UIPercentDrivenInteractiveTransition {
    
    var interactionInProgress = false
    
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    
    init(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
        prepareGestureRecognizer(in: viewController.view)
    }
    
    private func prepareGestureRecognizer(in view: UIView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))

        print("adding gesture recognizer")
        view.addGestureRecognizer(gesture)
    }
    
    @objc func handleGesture(_ gestureRecognizer : UIScreenEdgePanGestureRecognizer) {
        guard let superview = gestureRecognizer.view?.superview else { return }
        
        let translation = gestureRecognizer.translation(in: superview)
        var progress = abs(translation.x / viewController.view.frame.width)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        let velocity = gestureRecognizer.velocity(in: superview)
        
        switch gestureRecognizer.state {
            
        case .began:
            interactionInProgress = true
            if velocity.x < 0 {
                viewController.navigationController?.popViewController(animated: true)
            }
            
        case .changed:
            shouldCompleteTransition = progress > 0.5
            update(progress)
            
        case .cancelled:
            interactionInProgress = false
            cancel()
            
        case .ended:
            interactionInProgress = false
            if shouldCompleteTransition {
                finish()
            } else {
                cancel()
            }
        default:
            break
        }
    }
}
