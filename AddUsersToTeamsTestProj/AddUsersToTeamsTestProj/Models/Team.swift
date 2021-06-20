//
//  Team.swift
//  AddUsersToTeamsTestProj
//
//  Created by James Lea on 6/17/21.
//

import UIKit

class Team {
    let name: String
    let admins: [String]
    let members: [String]
    let city: String
    let teamId: String
    
    init(name: String, admins: [String], members: [String], city: String, teamId: String = UUID().uuidString){
        self.name = name
        self.admins = admins
        self.members = members
        self.city = city
        self.teamId = teamId
    }
}
