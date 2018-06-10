//
//  SecondViewController.swift
//  CustomTransitionsAnimationsApp
//
//  Created by Andres Peguero on 6/7/18.
//  Copyright © 2018 Andres Peguero. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var interaction: SlideOutMenuDismissInteration?
    
    var alreadyBeenHere = false

    override func viewDidLoad() {
        super.viewDidLoad()
        interaction = SlideOutMenuDismissInteration(viewController: self)
        view.backgroundColor = .blue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        alreadyBeenHere = true
    }

    override func viewDidLayoutSubviews() {
        if alreadyBeenHere {
            let menuWidth = view.frame.width - (view.frame.width / 7)
            let menuFrame = CGRect(x: 0, y: 0, width: menuWidth, height: view.frame.height)
            view.frame = menuFrame
        }
    }
    
    @IBAction func pressMeButtonPressed(_ sender: Any) {
        print("pressing me")
    }
}
