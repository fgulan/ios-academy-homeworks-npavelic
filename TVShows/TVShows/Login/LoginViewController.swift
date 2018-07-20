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
    
    private var loginData: LoginData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func launchHomeScreen() {
        let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "HomeViewController")
        navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    private func login(email: String, password: String) {
        SVProgressHUD.show()

        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        Alamofire
            .request("https://api.infinum.academy/api/users/sessions",
                     method: .post,
                     parameters: parameters,
                     encoding: JSONEncoding.default)
            .validate()
            .responseDecodableObject(keyPath: "data", decoder: JSONDecoder()) {
                (response: DataResponse<LoginData>) in
                switch response.result {
                case .success(let loginData):
                    SVProgressHUD.dismiss()
                    self.loginData = loginData
                    self.launchHomeScreen()
                case .failure(let error):
                    SVProgressHUD.dismiss()
                    print("API failure: \(error)")
                }
        }
    }
    
    private func register(email: String, password: String) {
        SVProgressHUD.show()

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
                    self.login(email: email, password: password)
                case .failure(let error):
                    SVProgressHUD.dismiss()
                    print("API failure: \(error)")
                }
        }
    }
    
    @IBAction func onRememberMeClick(_ sender: UIButton) {
        rememberMeButton.isSelected = !rememberMeButton.isSelected
    }
    
    @IBAction func onLoginClick(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        
        login(email: email, password: password)
    }
    
    @IBAction func onCreateAccountClick(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        
        register(email: email, password: password)
    }
}
