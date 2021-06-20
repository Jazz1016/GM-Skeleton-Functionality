//
//  LoginViewController.swift
//  AddUsersToTeamsTestProj
//
//  Created by James Lea on 6/17/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
        
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        //TODO: Validate Text Fields
        
        //Create cleaned version of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) {  (result, error) in
            
            if error != nil {
                
                self.errorLabel.text = error!.localizedDescription
                
                self.errorLabel.alpha = 1
                
            } else {
                
                guard let userId = result?.user.uid else {return}
                TeamController.shared.fetchUser(userId: userId)
//
                
                
                
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as?
                HomeViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
}
