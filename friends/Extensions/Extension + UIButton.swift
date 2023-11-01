//
//  Extension + UIButton.swift
//  friends
//
//  Created by 方奎元 on 2023/10/31.
//

import UIKit

extension UIButton {
    
    func rightImage(title: String, imageName: String) {
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        var btnConfig = UIButton.Configuration.plain()
        btnConfig.imagePlacement = .trailing
        
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        btnConfig.attributedTitle = AttributedString(title, attributes: container)
        btnConfig.image = UIImage(named: imageName, in: nil, with: config)
        btnConfig.imagePadding = 45
        self.configuration = btnConfig
        self.tintColor = .white
        self.layer.cornerRadius = 20
        self.contentHorizontalAlignment = .right
    }
    
    func onlyImage(imageName: String, imageSize: CGFloat, imageWeight: UIImage.SymbolWeight, tintColor: UIColor?) {
        let config = UIImage.SymbolConfiguration(pointSize: imageSize, weight: imageWeight)
        var btnConfig = UIButton.Configuration.plain()
        btnConfig.image = UIImage(named: imageName, in: nil, with: config)
        btnConfig.attributedTitle = AttributedString("")
        self.configuration = btnConfig
        self.tintColor = tintColor
        
        
    }
    
    func setborder(title: String, fontSize: CGFloat, fontWeight: UIFont.Weight, borderWith: CGFloat, borderColor: CGColor?, btnTintColor: UIColor?, conerRadius: CGFloat) {
        var btnConfig = UIButton.Configuration.plain()
        btnConfig.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 9, bottom: 2, trailing: 9)
        
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        container.foregroundColor = btnTintColor
        btnConfig.attributedTitle = AttributedString(title, attributes: container)
        self.configuration = btnConfig
       
        self.layer.cornerRadius = conerRadius
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWith
        
    }
}
