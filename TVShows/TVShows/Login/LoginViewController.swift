//
//  LoginViewController.swift
//  TVShows
//
//  Created by Neven Pavelić on 19/07/2018.
//  Copyright © 2018 Neven Pavelić. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var rememberMeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onRememberMeClick(_ sender: UIButton) {
        rememberMeButton.isSelected = !rememberMeButton.isSelected
    }
    
}
