//
//  SlideOutMenuPresentInteraction.swift
//  CustomTransitionsAnimationsApp
//
//  Created by Andres Peguero on 6/9/18.
//  Copyright © 2018 Andres Peguero. All rights reserved.
//

import UIKit

enum SlideMenuState {
    case present
    case dismiss
}

class SlideOutMenuPresentInteraction: UIPercentDrivenInteractiveTransition {
    
    var interactionInProgress = false
    
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    
    var slideMenuState: SlideMenuState = .present
    
    init(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
        prepareGestureRecognizer(in: viewController.view)
    }
    
    private func prepareGestureRecognizer(in view: UIView) {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        gesture.edges = .left
        
        view.addGestureRecognizer(gesture)
    }
    
    @objc func handleGesture(_ gestureRecognizer : UIScreenEdgePanGestureRecognizer) {
        guard let superview = gestureRecognizer.view?.superview else { return }
        
        let translation = gestureRecognizer.translation(in: superview)
        var progress = abs(translation.x / viewController.view.frame.width)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        
        switch gestureRecognizer.state {
            
        case .began:
            interactionInProgress = true
            slideMenuState = .present
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "second")  as? SecondViewController else { return }
            viewController.navigationController?.pushViewController(vc, animated: true)
            
        case .changed:
            shouldCompleteTransition = progress > 0.5
            update(progress)
            
        case .cancelled:
            interactionInProgress = false
            cancel()
            
        case .ended:
            interactionInProgress = false
            slideMenuState = .dismiss
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
