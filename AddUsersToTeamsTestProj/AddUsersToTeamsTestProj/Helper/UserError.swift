//
//  UserError.swift
//  AddUsersToTeamsTestProj
//
//  Created by James Lea on 6/18/21.
//

import Foundation

enum UserError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -> \(error)"
        case .invalidURL:
            return "Unable to reach the server."
        case .noData:
            return "The server responded with no data."
        case .unableToDecode:
            return "The server responded with bad data."
        }
    }
}

