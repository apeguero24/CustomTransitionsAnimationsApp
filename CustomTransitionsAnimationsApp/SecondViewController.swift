//
//  SecondViewController.swift
//  CustomTransitionsAnimationsApp
//
//  Created by Andres Peguero on 6/7/18.
//  Copyright © 2018 Andres Peguero. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var swipeLeftToRightInteraction: SwipeLeftToRightInteraction?

    override func viewDidLoad() {
        super.viewDidLoad()
        swipeLeftToRightInteraction = SwipeLeftToRightInteraction(viewController: self)
        view.backgroundColor = .blue
    }
}
