//
//  MoyaNetworkService.swift
//  PhotosApp
//
//  Created by Ahmed Fekry on 09/09/2023.
//

import Foundation
import Moya


enum UserService {
    case readUser
    case readalbum(userId: Int)
    case readpicture(albumId: Int)
}


extension UserService : TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
            case .readUser : return "/users"
            case .readalbum(_):return "/albums"
            case .readpicture(_): return "/photos"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
            case .readUser : return .requestPlain
            case .readalbum(let userId) : return .requestParameters(parameters: ["userId": userId], encoding: URLEncoding.default)
            case .readpicture(let albumId) : return .requestParameters(parameters: ["albumId" : albumId], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    
    
    
    
}
