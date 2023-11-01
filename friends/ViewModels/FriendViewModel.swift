//
//  FriendLsitViewModel.swift
//  friends
//
//  Created by 方奎元 on 2023/10/31.
//

import Foundation

class FriendListViewModel {
    
    static var mode: Constants.OptionType?
    private var allVM = [FriendViewModel]()
    var friendsVM: [FriendViewModel]
    var sentsVM: [FriendViewModel]
    var fixFriendVM: [FriendViewModel]
    
    init() {
        self.friendsVM = [FriendViewModel]()
        self.sentsVM = [FriendViewModel]()
        self.fixFriendVM = [FriendViewModel]()
    }
    
    func friendVM(at index: Int, array: [FriendViewModel]) -> FriendViewModel {
        return array[index]
    }
    
    func numberOfRows(_ section: Int, array: [FriendViewModel]) -> Int {
        return array.count
    }
    
    func search(with text: String) {
        let results = self.friendsVM.filter { vm in
            return vm.name.contains(text)
        }
        self.fixFriendVM = results
    }
    
    func loadFriends(condition: Constants.OptionType?) async {
        
        self.allVM.removeAll()
        guard let condition = condition else {return}
        var resources = [Resource<FriendResponse>]()
        switch condition {
        case .empty:
            resources.append(Friend.loadFriends(URLstring: Constants.Urls.friend4URLString))
        case .friend:
            resources.append(Friend.loadFriends(URLstring: Constants.Urls.friend1URLString))
            resources.append(Friend.loadFriends(URLstring: Constants.Urls.friend2URLString))
        case .both:
            resources.append(Friend.loadFriends(URLstring: Constants.Urls.friend3URLString))
        }
        
        for resource in resources {
            try? await Webservice().load(resource: resource, completion: { result in
                
                switch result {
                case .success(let response):
                    let friends = response.response
                    
                    for friend in friends {
                        let friendVM = FriendViewModel(friend: friend)
                        self.appendFriendVM(friendVM: friendVM)
                    }
                    
                case .failure(let error):
                    print(error)
                }
            })

        }
        
    }
    
    private func appendFriendVM(friendVM: FriendViewModel) {
        if let index = self.allVM.firstIndex(where: { $0.fid == friendVM.fid }) {
            let vm = self.allVM[index]
            
            if Int(vm.updateDate)! < Int(friendVM.updateDate)! {
                self.allVM.remove(at: index)
                self.allVM.append(friendVM)
                
            }
            return
        }
        
        self.allVM.append(friendVM)
        
       
    }
    
    func separate() {
        self.sentsVM = self.allVM.filter { $0.status.rawValue == 0 }
        self.friendsVM = self.allVM.filter { $0.status.rawValue != 0 }
        self.fixFriendVM = self.friendsVM
        print("Sent:\(sentsVM)")
        print("friend:\(friendsVM)")
    }
    
}

class FriendViewModel {
    
    let friend : Friend
    var status: Status
    var name: String
    var isTop: IsTop
    var fid: String
    var updateDate: String
    
    init(friend: Friend) {
        self.friend = friend
        self.status = friend.status
        self.name = friend.name
        self.isTop = friend.isTop
        self.fid = friend.fid
        self.updateDate = friend.updateDate.replacingOccurrences(of: "/", with: "")
    }
    
}

