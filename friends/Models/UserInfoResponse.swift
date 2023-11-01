//
//  UserInfoResponse.swift
//  friends
//
//  Created by 方奎元 on 2023/10/31.
//

import Foundation

struct UserInfoResponse: Codable {
    let response: [UserInfo]
}

struct UserInfo: Codable {
    let name: String
    let kokoid: String
}

extension UserInfo {
    
    static func  loadUser(URLString: String) -> Resource<UserInfoResponse> {
        guard let url = URL(string: URLString) else {
            fatalError("URL is incorrect.")
        }
        return Resource<UserInfoResponse>(url: url)
    }
}
