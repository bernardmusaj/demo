//
//  User.swift
//  Demo
//
//  Created by Bernard Musaj on 11.4.21.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    
    //let address: UserAdress
    //let company: Company
}

extension User {
    init(managedUser: ManagedUser) {
        id = Int(managedUser.id)
        name = managedUser.name!
        username = managedUser.username!
        email = managedUser.email!
        phone = managedUser.phone!
        website = managedUser.website!
    }
}

//struct UserAdress: Codable {
//    let street: String
//    let suite: String
//    let city: String
//    let zipcode: String
//    let geo: Geo
//}
//
//struct Geo: Codable {
//    let lat: String
//    let lng: String
//}
//
//struct Company: Codable {
//    let name: String
//    let catchPhrase: String
//    let bs: String
//}
