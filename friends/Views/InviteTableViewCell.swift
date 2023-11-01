//
//  InviteTableViewCell.swift
//  friends
//
//  Created by 方奎元 on 2023/11/1.
//

import UIKit

class InviteTableViewCell: UITableViewCell {

    @IBOutlet weak var foldView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var agreeBtn: UIButton!
    @IBOutlet weak var denyBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func agreePressed(_ sender: UIButton) {
        print("agree")
    }
    private func setup() {
        self.selectionStyle = .none
        self.backgroundColor = .white
        self.cellView.backgroundColor = .white
        self.cellView.layer.cornerRadius = 6
        self.cellView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.cellView.layer.shadowColor = UIColor.darkGray.cgColor
        self.cellView.layer.shadowOpacity = 0.3
        self.cellView.layer.opacity = 1.0
        
        self.foldView.backgroundColor = .white
        self.foldView.layer.cornerRadius = 6
        self.foldView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.foldView.layer.shadowColor = UIColor.darkGray.cgColor
        self.foldView.layer.shadowOpacity = 0.3
        self.foldView.layer.opacity = 1.0
    }
    
    func configure(vm: FriendViewModel) {
        self.nameLabel.text = vm.name
        self.profileImageView.image = UIImage(named: "female")
    }
    
    func hideFoldView() {
        self.foldView.isHidden = true
    }
    
    func showFoldView() {
        self.foldView.isHidden = false
    }

}
