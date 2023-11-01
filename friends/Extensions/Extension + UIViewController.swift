//
//  Extension + UIViewController.swift
//  friends
//
//  Created by 方奎元 on 2023/10/31.
//

import UIKit

extension UIViewController {
    
    
    
    func displayOptions( completion: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: "請選擇情境", message: "情境條件為下列三項", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.OptionType.empty.rawValue, style:  .default, handler: completion))
        alert.addAction(UIAlertAction(title: Constants.OptionType.friend.rawValue, style: .default, handler: completion))
        alert.addAction(UIAlertAction(title: Constants.OptionType.both.rawValue, style: .default, handler: completion))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        present(alert, animated: true)
    }
}
