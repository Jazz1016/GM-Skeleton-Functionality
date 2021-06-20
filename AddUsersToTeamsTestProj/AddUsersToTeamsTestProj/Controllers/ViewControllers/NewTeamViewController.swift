//
//  NewTeamViewController.swift
//  AddUsersToTeamsTestProj
//
//  Created by James Lea on 6/17/21.
//

import UIKit
import FirebaseAuth

class NewTeamViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var teamNameTextField: UITextField!
    @IBOutlet weak var cityNameTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Auth.auth().currentUser?.uid)
    }
    
    @IBAction func createTeamTapped(_ sender: Any) {
        guard let teamName = teamNameTextField.text,
              let cityName = cityNameTextField.text,
              let userId =  Auth.auth().currentUser?.uid
              else {return}
        
        let defaultAdmins = [userId]
        
        let newTeam = Team(name: teamName, admins: defaultAdmins, members: [], city: cityName)
        
        TeamController.shared.createTeam(team: newTeam)
        TeamController.shared.addTeamToUser(userId: userId, teamId: newTeam.teamId)
        
    }
}
