//
//  FriendResponse.swift
//  friends
//
//  Created by 方奎元 on 2023/10/31.
//

import Foundation

enum Status: Int, Codable {
    case sent
    case done
    case invited
}

enum IsTop: String, Codable {
    case top = "1"
    case nonTop = "0"
}

struct FriendResponse: Codable {
    let response: [Friend]
}

struct Friend: Codable {
    let name: String
    let status: Status
    let isTop: IsTop
    let fid: String
    let updateDate: String
}

extension Friend {
    
    static func loadFriends(URLstring: String) -> Resource<FriendResponse> {
        guard let url = URL(string: URLstring) else {
            fatalError("URL is incorrect.")
        }
        return Resource<FriendResponse>(url: url)
    }
}
