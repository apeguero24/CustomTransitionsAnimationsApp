//
//  ViewController.swift
//  CustomTransitionsAnimationsApp
//
//  Created by Andres Peguero on 6/7/18.
//  Copyright © 2018 Andres Peguero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var interactionController: SlideOutMenuPresentInteraction?
    
    var tapButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        interactionController = SlideOutMenuPresentInteraction(viewController: self)
        setupButton()
        navigationController?.delegate = self
    }

    func setupButton() {
        tapButton = UIButton(type: .custom)
        tapButton.setTitle("Go to second!", for: .normal)
        tapButton.backgroundColor = .red
        tapButton.addTarget(self, action: #selector(tapButtonPressed), for: .touchUpInside)
        view.addSubview(tapButton)
        
        tapButton.translatesAutoresizingMaskIntoConstraints = false
        tapButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func tapButtonPressed() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "second")  as? SecondViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            return SlideOutMenuPresentAnimation(originFrame: view.frame, interaction: interactionController)
        } else if operation == .pop {
            guard let currentVC = fromVC as? SecondViewController else { return nil }
            return SlideOutMenuDismissAnimation(originFrame: view.frame, interaction: currentVC.interaction)
        }
        
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

        guard let interaction = interactionController else { return nil }

        switch interaction.slideMenuState {
        case .present:
            guard let animator = animationController as? SlideOutMenuPresentAnimation,
                let interaction = animator.interaction,
                interaction.interactionInProgress else { return nil }

            return interaction

        case .dismiss:

            guard let animator = animationController as? SlideOutMenuDismissAnimation,
                let interaction = animator.interaction,
                interaction.interactionInProgress else { return nil }

            return interaction
        }
    }
}
