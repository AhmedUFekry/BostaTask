//
//  DataModels.swift
//  PhotosApp
//
//  Created by Ahmed Fekry on 09/09/2023.
//

import Foundation

class User: Decodable {
    let id: Int?
    let name: String?
    let address: Address?
}

struct Address: Decodable{
    let street: String
    let suite: String
    let city: String
    let zipcode: String
}

class Albums: Decodable {
    let userId: Int?
    let id: Int?
    let title: String?
}

class AlbumsResponse : Decodable {
    let albums: [Albums]?
}

class Photos: Decodable {
    let id: Int?
    let albumId: Int?
    let title: String?
    let url: String?
}
