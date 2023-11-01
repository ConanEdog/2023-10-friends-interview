//
//  FriendsTableView.swift
//  friends
//
//  Created by 方奎元 on 2023/10/31.
//

import UIKit

class FriendsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    var friendsData = [FriendViewModel] () {
        didSet{
            self.reloadData()
        }
    }
    
    var addBtn: UIButton!
    var searchBar: UISearchBar!
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.prepare()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.prepare()
    }
    
    private func prepare() {
        self.backgroundColor = .white
        self.delegate = self
        self.dataSource = self
    }
    
    
    func setEmptyFriendView() {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "emptyFriend")
        imageView.sizeToFit()
        
        let titleLabel = UILabel()
        titleLabel.text = "就從加好友開始吧：）"
        titleLabel.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        titleLabel.textColor = UIColor(named: "title")
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        
        let subTitle = UILabel()
        subTitle.text = "與好友們一起用 KOKO 聊起來！\n 還能互相收付款、發紅包喔：)"
        subTitle.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        subTitle.textColor = UIColor(named: "subtitle")
        subTitle.textAlignment = .center
        subTitle.numberOfLines = 2
        subTitle.sizeToFit()
        
        let addFriendBtn = UIButton()
        addFriendBtn.rightImage(title: "加好友", imageName: "addFriendWhite")
        addFriendBtn.backgroundColor = UIColor(named: "green")
        
        
        let btmLabel = UILabel()
        btmLabel.text = "幫助好友更快找到你？"
        btmLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        btmLabel.textColor = UIColor(named: "subtitle")
        btmLabel.sizeToFit()
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 13, weight: .regular),
            .foregroundColor: UIColor(named: "pink")!,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSMutableAttributedString(string: "設定 KOKO ID", attributes: attributes)
        
        let settingBtn = UIButton()
        settingBtn.setAttributedTitle(attributeString, for: .normal)
        
        let mainView = UIView()
        mainView.backgroundColor = .white
        mainView.addSubview(imageView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(subTitle)
        mainView.addSubview(addFriendBtn)
        mainView.addSubview(btmLabel)
        mainView.addSubview(settingBtn)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        addFriendBtn.translatesAutoresizingMaskIntoConstraints = false
        btmLabel.translatesAutoresizingMaskIntoConstraints = false
        settingBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 15),
            imageView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 2/3),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 35),
            titleLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            subTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitle.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            subTitle.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 3/4),
            
            addFriendBtn.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 25),
            addFriendBtn.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            addFriendBtn.widthAnchor.constraint(equalTo: subTitle.widthAnchor, multiplier: 1),
            addFriendBtn.heightAnchor.constraint(equalToConstant: 40),
            
            btmLabel.topAnchor.constraint(equalTo: addFriendBtn.bottomAnchor, constant: 30),
            btmLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor, constant: -40),
            settingBtn.topAnchor.constraint(equalTo: addFriendBtn.bottomAnchor, constant: 24),
            settingBtn.leadingAnchor.constraint(equalTo: btmLabel.trailingAnchor)
            
            
        ])
        
        self.backgroundView = mainView
    }
    
    func restoreBackgroundView() {
        let view = UIView()
        view.backgroundColor = .white
        self.backgroundView = view
    }
    
    func setupHeader() {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 44))
        
        addBtn = UIButton()
        addBtn.onlyImage(imageName: "addFriendBtn", imageSize: 24, imageWeight: .regular, tintColor: UIColor(named: "pink"))
        
        searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideUISearchBar?.textColor = .black
        textFieldInsideUISearchBar?.leftView?.tintColor = UIColor(named: "placeholder")
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "placeholder")!]
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "想轉一筆給誰呢？", attributes: attributes)
       
        searchBar.sizeToFit()
        
        view.addSubview(addBtn)
        view.addSubview(searchBar)
        
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: view.bounds.height),
            searchBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 5/6),
            addBtn.leftAnchor.constraint(equalTo: searchBar.rightAnchor, constant: 5),
            addBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        self.tableHeaderView = view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.restoreBackgroundView()
        
        let vm = self.friendsData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendTableViewCell
        cell.configure(vm: vm)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
    
}
