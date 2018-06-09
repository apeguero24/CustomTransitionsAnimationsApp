//
//  ViewController.swift
//  CustomTransitionsAnimationsApp
//
//  Created by Andres Peguero on 6/7/18.
//  Copyright © 2018 Andres Peguero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tapButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
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
            return SlideOutMenuPresentAnimation(originFrame: view.frame)
        } else if operation == .pop {
            guard let currentVC = fromVC as? SecondViewController else { return nil }
            return SlideOutMenuDismissAnimation(originFrame: view.frame)
        }
        
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let animator = animationController as? RightToLeftDismissAnimation,
        let interaction = animator.interactionController,
        interaction.interactionInProgress else { return nil }
        
        return interaction
        
    }
}
