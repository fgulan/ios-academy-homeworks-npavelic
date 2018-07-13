//
//  LoginViewController.swift
//  TVShows
//
//  Created by Neven Pavelić on 12/07/2018.
//  Copyright © 2018 Neven Pavelić. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var labelOutlet: UILabel!
    
    var clickCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateLabel()
    }
    
    @IBAction func onButtonClick(_ sender: UIButton) {
        clickCount += 1
        updateLabel()
    }
    
    func updateLabel() {
        labelOutlet.text = String(clickCount)
    }
}
