//
//  Constants.swift
//  friends
//
//  Created by 方奎元 on 2023/10/31.
//

import Foundation

struct Constants {
    
    struct Urls {
        static let userInfoURLString = "https://dimanyen.github.io/man.json"
        static let friend1URLString = "https://dimanyen.github.io/friend1.json"
        static let friend2URLString = "https://dimanyen.github.io/friend2.json"
        static let friend3URLString = "https://dimanyen.github.io/friend3.json"
        static let friend4URLString = "https://dimanyen.github.io/friend4.json"
    }
    
    enum OptionType: String {
        case empty = "無好友"
        case friend = "好友列表"
        case both = "邀請+好友列表"
    }
}
