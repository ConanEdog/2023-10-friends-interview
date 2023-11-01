//
//  FriendTableViewCell.swift
//  friends
//
//  Created by 方奎元 on 2023/10/31.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var friendImageView: UIImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var transferBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .white
        self.transferBtn.setborder(title: "轉帳", fontSize: 14, fontWeight: .medium, borderWith: 1.2, borderColor: UIColor(named: "pink")?.cgColor, btnTintColor: UIColor(named: "pink"), conerRadius: 2)
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(vm: FriendViewModel) {
        print(vm.updateDate)
        self.friendImageView.image = UIImage(named: "female")
        self.friendNameLabel.text = vm.name
        
        switch vm.isTop {
            
        case .top:
            self.starImageView.isHidden = false
            
        case .nonTop:
            self.starImageView.isHidden = true
        }
        
        switch vm.status {
            
        case .done:
            
            self.moreBtn.onlyImage(imageName: "more", imageSize: 14, imageWeight: .regular, tintColor: nil)
            self.moreBtn.layer.borderWidth = 0
            
            
        case .invited:
            self.moreBtn.isEnabled = false
            self.moreBtn.setborder(title: "邀請中", fontSize: 14, fontWeight: .medium, borderWith: 1.2, borderColor: UIColor(named: "border")?.cgColor, btnTintColor: UIColor(named: "subtitle"), conerRadius: 2)
            
            
        case .sent:
            break
        }
    }

}
