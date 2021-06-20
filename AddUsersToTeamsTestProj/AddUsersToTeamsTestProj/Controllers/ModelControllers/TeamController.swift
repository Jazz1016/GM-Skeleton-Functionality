//
//  TeamController.swift
//  AddUsersToTeamsTestProj
//
//  Created by James Lea on 6/17/21.
//

import Foundation
import FirebaseFirestore

class TeamController {
    static let shared = TeamController()
    
    var teams: [Team] = []
    var user: User?
    
    let db = Firestore.firestore()
    
    func fetchTeamsForUser(teamIds: [String]) {
        for i in teamIds {
            self.teams = []
            let fetchedTeam = db.collection("teams").whereField("teamId", isEqualTo: i)
            print(i)
            fetchedTeam.getDocuments { snap, err in
                
                if snap?.count == 1 {
                    guard let snap = snap else {return}
                    let teamData = snap.documents[0].data()
                    
                    let name = teamData["name"] as? String
                    let admins = teamData["admins"] as? Array<String>
                    let city = teamData["city"] as? String
                    let members = teamData["members"] as? Array<String>
                    let teamId = teamData["teamId"] as? String
                    
                    guard let admins1 = admins,
                          let members1 = members,
                          let name1 = name,
                          let city1 = city,
                          let teamId1 = teamId
                          else {return}
                    
                    let teamToAdd = Team(name: name1, admins: admins1, members: members1, city: city1, teamId: teamId1)
                    
                    
                    
                    self.teams.append(teamToAdd)
                }
            }
            
        }
    }
    
    func fetchUser(userId: String) {
        let fetchedUser = db.collection("users").whereField("uid", isEqualTo: userId)
        
        fetchedUser.getDocuments { snap, err in
            if snap?.count == 1 {
                guard let snap = snap else {return}
                let userData = snap.documents[0].data()
                
                let email = userData["email"] as? String
                let firstName = userData["firstName"] as? String
                let lastName = userData["lastName"] as? String
                let teams = userData["teams"] as? [String] ?? []
                let userId = userData["uid"] as? String
                
                let currentUser = User(email: email ?? "", firstName: firstName ?? "", lastName: lastName ?? "", teams: teams, userId: userId ?? "")
                
                self.user = currentUser
            } else {return}
        }
    }
    
    
    func createTeam(team: Team){
        let teamToAdd: Team = team
        
        let teamReference = db.collection("teams").document(teamToAdd.teamId)
        teamReference.setData(["name" : team.name,
                               "city" : team.city,
                               "admins" : team.admins,
                               "members" : team.members,
                               "teamId" : team.teamId
        ])
        teams.append(teamToAdd)
    }
    
    func addTeamToUser(userId: String, teamId: String){
        let query = db.collection("users").whereField("uid", isEqualTo: userId)
        query.getDocuments { snap, error in
            
            guard let snap = snap else {return}
            
            print("hit")
            if snap.count == 1 {
                let userData = snap.documents[0].data()
                
                let firstName = userData["firstName"] as? String
                let lastName = userData["lastName"] as? String
                var teams = userData["teams"] as? Array ?? []
                let userId = userData["uid"] as? String
                
                teams.append(teamId)
                
                print(teams)
                
                self.db.collection("users").document(userId!).setData([
                    "firstName" : firstName,
                    "lastName" : lastName,
                    "teams" : teams,
                    "uid" : userId
                ])
            } else {
                return
            }
        }
    }
    
    func inviteUserToTeam(){
        
    }
    
    
    
}//End of class
