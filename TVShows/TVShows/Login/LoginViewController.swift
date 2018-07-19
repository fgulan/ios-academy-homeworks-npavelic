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
    
    private func launchHomeScreen() {
        let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "HomeViewController")
        navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    @IBAction func onRememberMeClick(_ sender: UIButton) {
        rememberMeButton.isSelected = !rememberMeButton.isSelected
    }
    
    @IBAction func onLoginClick(_ sender: UIButton) {
        launchHomeScreen()
    }
    
    @IBAction func onCreateAccountClick(_ sender: UIButton) {
        launchHomeScreen()
    }
}
