//
//  HomeViewController.swift
//  AddUsersToTeamsTestProj
//
//  Created by James Lea on 6/17/21.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    @IBOutlet weak var joinTeamTableView: UITableView!
    @IBOutlet weak var teamsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let user = TeamController.shared.user else {return}
        
        TeamController.shared.fetchTeamsForUser(teamIds: user.teams)
    }
    
    @IBAction func reloadTablesButton(_ sender: Any) {
        joinTeamTableView.reloadData()
        teamsTableView.reloadData()
        
        guard let user = TeamController.shared.user else {return}
        
        TeamController.shared.fetchTeamsForUser(teamIds: user.teams)
        print("hit")
        
    }
}
