//
//  InviteTableView.swift
//  friends
//
//  Created by 方奎元 on 2023/11/1.
//

import UIKit

class InviteTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    private var isOpen = true
    var inviteData = [FriendViewModel] () {
        didSet {
            self.reloadData()
        }
    }
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isOpen ? self.inviteData.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "inviteCell", for: indexPath) as! InviteTableViewCell
        
        if isOpen {
            let vm = self.inviteData[indexPath.row]
            cell.configure(vm: vm)
            cell.hideFoldView()
            return cell
            
        } else {
            let vm = self.inviteData[0]
            cell.configure(vm: vm)
            cell.showFoldView()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            if isOpen {
                isOpen = false
                self.reloadSections(IndexSet(integer: indexPath.section), with: .none)
            } else {
                isOpen = true
                self.reloadSections(IndexSet(integer: indexPath.section), with: .none)
            }
        }
    }
    
    
}
