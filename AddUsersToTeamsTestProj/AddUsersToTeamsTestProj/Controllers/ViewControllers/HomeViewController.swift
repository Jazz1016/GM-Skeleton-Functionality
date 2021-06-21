//
//  HomeViewController.swift
//  AddUsersToTeamsTestProj
//
//  Created by James Lea on 6/17/21.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var joinTeamTableView: UITableView!
    @IBOutlet weak var teamsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TeamController.shared.fetchUser()
        
        do {
            try Auth.auth().signOut()
        } catch {
         print("error")
        }
        
        if Auth.auth().currentUser == nil {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let VC = storyboard.instantiateViewController(identifier: "loginVC")
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: true, completion: nil)
        }
        
        self.joinTeamTableView.delegate = self
        self.joinTeamTableView.dataSource = self
        
        self.teamsTableView.delegate = self
        self.teamsTableView.dataSource = self
        
        guard let user = TeamController.shared.user else {return}
        TeamController.shared.fetchTeamsForUser(teamIds: user.teams)
    }
    
    
    
    @IBAction func reloadTablesButton(_ sender: Any) {
        self.joinTeamTableView.reloadData()
        self.teamsTableView.reloadData()
        
        print(TeamController.shared.teams)
    }
    
    @IBAction func fetchTeamData(_ sender: Any) {
        
        guard let user = TeamController.shared.user else {return}
        
        TeamController.shared.fetchTeamsForUser(teamIds: user.teams)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberOfRows = 1
        switch tableView {
        case joinTeamTableView:
            numberOfRows = 1
        case teamsTableView:
            numberOfRows = TeamController.shared.teams.count
        default:
            numberOfRows = 1
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case teamsTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as? TeamTableViewCell
            
            let team = TeamController.shared.teams[indexPath.row]
            
            cell?.team = team
            
            return cell ?? UITableViewCell()
        case joinTeamTableView:
        let cell = tableView.dequeueReusableCell(withIdentifier: "inviteCell", for: indexPath) as? InvitesTableViewCell
        
        return cell ?? UITableViewCell()
        default:
           return UITableViewCell()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toTeamDetailVC" {
            guard let destination = segue.destination as? TeamViewController,
                  let indexPath = teamsTableView.indexPathForSelectedRow else {return}
            
            destination.team = TeamController.shared.teams[indexPath.row]
        }
    }
    
}//End of class



