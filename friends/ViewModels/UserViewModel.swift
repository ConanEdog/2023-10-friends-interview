//
//  UserViewModel.swift
//  friends
//
//  Created by 方奎元 on 2023/10/31.
//

import Foundation

class UserViewModel {
    let user: UserInfo
    var name: String
    var kokoid: String
    
    init(userInfo: UserInfo) {
        self.user = userInfo
        self.name = userInfo.name
        self.kokoid = userInfo.kokoid
    }
    
    static func loadUser(completion: ((UserInfo) -> Void)?) async {
        try? await Webservice().load(resource: UserInfo.loadUser(URLString: Constants.Urls.userInfoURLString), completion: { result in
            
            switch result {
            case .success(let response):
                guard let user = response.response.first else {return}
                completion?(user)
            case.failure(let error):
                print(error)
            }
        })
    }
}
