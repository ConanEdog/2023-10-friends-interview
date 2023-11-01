//
//  ViewController.swift
//  friends
//
//  Created by 方奎元 on 2023/10/30.
//

import UIKit

class FriendsVC: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var idButton: UIButton!
    @IBOutlet weak var dotView: UIView!
    
    @IBOutlet weak var idView: UIView!
    @IBOutlet weak var switchView: UIView!
    @IBOutlet var btns: [UIButton]!
    @IBOutlet weak var underLineView: UIView!
    
    @IBOutlet weak var inviteTableView: InviteTableView!
    @IBOutlet weak var friendTableView: FriendsTableView!
    
    @IBOutlet weak var underLineViewCenterXConstriant: NSLayoutConstraint!
    @IBOutlet weak var underLineViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var switchViewTopConstraint: NSLayoutConstraint!
    
    var userVM : UserViewModel! {
        didSet {
            self.nameLabel.text = userVM.name
            self.idButton.setTitle("KO KO ID: \(userVM.kokoid)", for: .normal)
            self.dotView.isHidden = true
        }
    }
    
    var friendListVM = FriendListViewModel()
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.option()
        
    }
    
    private func setup() {
        self.dotView.layer.cornerRadius = 5
        self.underLineView.layer.cornerRadius = 2
        self.configRefreshControl()
    }
    
    @IBAction func changePage(_ sender: UIButton) {
        underLineViewTopConstraint.isActive = false
        underLineViewCenterXConstriant.isActive = false
        
        underLineViewCenterXConstriant = underLineView.centerXAnchor.constraint(equalTo: sender.centerXAnchor)
        underLineViewTopConstraint = underLineView.topAnchor.constraint(equalTo: sender.bottomAnchor, constant: 6)
        
        underLineViewCenterXConstriant.isActive = true
        underLineViewTopConstraint.isActive = true
        UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut) {
            self.view.layoutIfNeeded()
        }.startAnimation()
    }
    
    private func setupUser() {
        Task {
            await UserViewModel.loadUser { info in
                self.userVM = UserViewModel(userInfo: info)
            }
        }
    }
    
    private func option() {
        self.displayOptions { [weak self] action in
            switch action.title {
                
            case Constants.OptionType.empty.rawValue:
                FriendListViewModel.mode = Constants.OptionType.empty
   
            case Constants.OptionType.friend.rawValue:
                FriendListViewModel.mode = Constants.OptionType.friend
                
            case Constants.OptionType.both.rawValue:
                FriendListViewModel.mode = Constants.OptionType.both
                
            default:
                break
            }
            
            self?.updateData()
        }
        self.setupUser()
    }
    
    private func updateData() {
        
        Task {
            await self.friendListVM.loadFriends(condition: FriendListViewModel.mode)
            
            self.friendListVM.separate()
            if self.friendListVM.friendsVM.isEmpty {
                self.friendTableView.setEmptyFriendView()
                self.friendTableView.tableHeaderView = nil
            } else {
                self.friendTableView.setupHeader()
                self.friendTableView.searchBar.delegate = self
            }
            if !self.friendListVM.sentsVM.isEmpty {
                self.showInviteTableView()
            } else {
                self.hideInviteTableView()
            }
            self.inviteTableView.inviteData = friendListVM.sentsVM
            self.friendTableView.friendsData = friendListVM.friendsVM
            self.refreshControl.endRefreshing()
        }
        
    }
    
    private func configRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.friendTableView.refreshControl = refreshControl
    }
    
    @objc private func refresh() {
        
        self.updateData()
        
    }
    
    func showInviteTableView() {
        self.inviteTableView.isHidden = false
        self.switchViewTopConstraint.isActive = false
        self.switchViewTopConstraint = self.switchView.topAnchor.constraint(equalTo: self.inviteTableView.bottomAnchor, constant: 5)
        self.switchViewTopConstraint.isActive = true
        UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut) {
            self.view.layoutIfNeeded()
        }.startAnimation()
    }
    
    func hideInviteTableView() {
        self.inviteTableView.isHidden = true
        self.switchViewTopConstraint.isActive = false
        self.switchViewTopConstraint = self.switchView.topAnchor.constraint(equalTo: self.idView.bottomAnchor, constant: 5)
        self.switchViewTopConstraint.isActive = true
        UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut) {
            self.view.layoutIfNeeded()
        }.startAnimation()
    }

}


extension FriendsVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.friendTableView.friendsData = self.friendListVM.fixFriendVM
            
        } else {
            self.friendTableView.friendsData = self.friendListVM.fixFriendVM.filter { $0.name.contains(searchText)}
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        self.hideInviteTableView()
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if !self.friendListVM.sentsVM.isEmpty {
            self.showInviteTableView()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.friendTableView.friendsData = self.friendListVM.fixFriendVM
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}
