//
//  TeamViewController.swift
//  AddUsersToTeamsTestProj
//
//  Created by James Lea on 6/21/21.
//

import UIKit
import FirebaseAuth

class TeamViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var inviteEmailTextField: UITextField!
    

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Properties
    var team: Team? {
        didSet {
            updateViews()
        }
    }
    
    @IBAction func sendInviteToUser(_ sender: Any) {
        guard let email = inviteEmailTextField.text,
              let userId = TeamController.shared.user?.userId
              else {return}
        TeamController.shared.inviteUserToTeam(userEmail: email, teamId: userId)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func updateViews(){
        
    }

}
