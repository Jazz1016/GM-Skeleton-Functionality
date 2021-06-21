//
//  SignUpViewController.swift
//  AddUsersToTeamsTestProj
//
//  Created by James Lea on 6/17/21.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide the error label
        errorLabel.alpha = 0
        
        //Style the elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    }
    
    
    // MARK: - Functions
    //Check the fields and validate that the data iis correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        //check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            
            return "Please fill in all fields"
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
//        if Utilities.isPasswordValid(cleanedPassword) == false {
//
//
//            return "Please make sure your password is at least 8 characters, ccontains a special character and a number"
//        }
        return nil
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        let error = validateFields()
        
        if error != nil {
            
            self.showError("Error creating user")
        } else {
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                 print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                } else {
                    let db = Firestore.firestore()
                    db.collection("users").document(result!.user.uid).setData(["bob":"jimmy"])
                }
            }
        }
    }
    
    func createUser(){
        let db = Firestore.firestore()
        db.collection("users").document("jadasfasdfsdfsa").setData(["bob":"jimmy"])
    }
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController)
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
