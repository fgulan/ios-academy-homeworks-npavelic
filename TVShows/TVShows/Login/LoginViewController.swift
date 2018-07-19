//
//  LoginViewController.swift
//  TVShows
//
//  Created by Neven Pavelić on 19/07/2018.
//  Copyright © 2018 Neven Pavelić. All rights reserved.
//

import UIKit
import Alamofire
import CodableAlamofire
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var rememberMeButton: UIButton!
    
    private var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func launchHomeScreen() {
        let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "HomeViewController")
        navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    private func register(email: String, password: String) {
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        Alamofire
            .request("https://api.infinum.academy/api/users",
                     method: .post,
                     parameters: parameters,
                     encoding: JSONEncoding.default)
            .validate()
            .responseDecodableObject(keyPath: "data", decoder: JSONDecoder()) {
                (response: DataResponse<User>) in
                switch response.result {
                case .success(let user):
                    SVProgressHUD.dismiss()
                    self.user = user
                    self.launchHomeScreen()
                case .failure(let error):
                    print("API failure: \(error)")
                }
        }
    }
    
    @IBAction func onRememberMeClick(_ sender: UIButton) {
        rememberMeButton.isSelected = !rememberMeButton.isSelected
    }
    
    @IBAction func onLoginClick(_ sender: UIButton) {
        launchHomeScreen()
    }
    
    @IBAction func onCreateAccountClick(_ sender: UIButton) {
        SVProgressHUD.show()
        
        guard let email = emailTextField.text, !email.isEmpty else {
            SVProgressHUD.dismiss()
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            SVProgressHUD.dismiss()
            return
        }
        
        register(email: email, password: password)
    }
}
