//
//  SecondViewController.swift
//  CustomTransitionsAnimationsApp
//
//  Created by Andres Peguero on 6/7/18.
//  Copyright © 2018 Andres Peguero. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var swipeRightToleftInteraction: SwipeRightToLeftInteraction?

    override func viewDidLoad() {
        super.viewDidLoad()
        swipeRightToleftInteraction = SwipeRightToLeftInteraction(viewController: self)
        view.backgroundColor = .blue
    }
}
