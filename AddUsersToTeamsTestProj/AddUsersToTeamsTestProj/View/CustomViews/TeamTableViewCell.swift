//
//  TeamTableViewCell.swift
//  AddUsersToTeamsTestProj
//
//  Created by James Lea on 6/18/21.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var teamNameLabel: UILabel!
    
    // MARK: - Properties
    var team: Team? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews(){
        guard let team = team else {return}
        teamNameLabel.text = team.name
    }

}
