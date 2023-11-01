//
//  MyTabBarVC.swift
//  friends
//
//  Created by 方奎元 on 2023/10/30.
//

import UIKit

class MyTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupTabbar()
        
    }

    private func setupTabbar() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let friendVC = storyboard.instantiateViewController(withIdentifier: "friendVC")
        let friendNav = self.createNav(with: nil, and: UIImage(named: "friendBar"), vc: friendVC)
        let productNav = self.createNav(with: nil, and: UIImage(named: "productBar"), vc: ProductsVC())
        let homeNav = self.createNav(with: nil, and: UIImage(named: "homeBar"), vc: HomeOffVC())
        let manageNav = self.createNav(with: nil, and: UIImage(named: "manageBar"), vc: ManageVC())
        let settingNav = self.createNav(with: nil, and: UIImage(named: "settingBar"), vc: SettingVC())
        self.viewControllers = [productNav, friendNav, homeNav, manageNav, settingNav]
        self.selectedIndex = 1
        self.tabBar.backgroundColor = .white
        
        let selectedColor = UIColor(named: "pink")
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
        self.tabBar.standardAppearance = appearance
    }
    
    private func createNav(with title: String?, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.image = image
        vc.view.backgroundColor = .white
        
        let scanBtn = UIBarButtonItem(image: UIImage(named: "scan"), style: .plain, target: nil, action: nil)
        let withdrawBtn = UIBarButtonItem(image: UIImage(named: "withdraw"), style: .plain, target: nil, action: nil)
        let transferBtn = UIBarButtonItem(image: UIImage(named: "transfer"), style: .plain, target: nil, action: nil)
        nav.viewControllers.first?.navigationItem.rightBarButtonItem = scanBtn
        nav.viewControllers.first?.navigationItem.leftBarButtonItems = [withdrawBtn, transferBtn]

        return nav
    }
    

}
