//
//  MainViewController.swift
//  ZatWal
//
//  Created by Muhammad Noor on 02/04/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import UIKit


class MainViewController: UITabBarController{
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.backgroundColor = #colorLiteral(red: 0.1891457805, green: 0.1891457805, blue: 0.1891457805, alpha: 1)
        self.view.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
        self.tabBar.tintColor = #colorLiteral(red: 0.968627451, green: 0.8901960784, blue: 0.1058823529, alpha: 1)
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.968627451, green: 0.8901960784, blue: 0.1058823529, alpha: 1)
        self.delegate = self
        self.viewControllers = self.setupViews()
        
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupNavigationBar() {
        
    }
    
    private func setupViews() -> [UIViewController] {
        let home = HomeViewController()
        home.tabBarItem = UITabBarItem(title: "Jadwal Sholat", image: #imageLiteral(resourceName: "ic_home").withRenderingMode(.alwaysTemplate), selectedImage: #imageLiteral(resourceName: "ic_home").withRenderingMode(.alwaysOriginal))
        home.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.968627451, green: 0.8901960784, blue: 0.1058823529, alpha: 1)], for: UIControl.State.selected)
        home.tabBarItem.tag = 1
        
        let myAccount = ProfileViewController()
        myAccount.tabBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "ic_location").withRenderingMode(.alwaysTemplate), selectedImage: #imageLiteral(resourceName: "ic_location").withRenderingMode(.alwaysOriginal))
        myAccount.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.968627451, green: 0.8901960784, blue: 0.1058823529, alpha: 1)], for: UIControl.State.selected)
        myAccount.tabBarItem.tag = 2
        
        let views = [home, myAccount].map { UINavigationController(rootViewController: $0) }
        return views
    }
}

extension MainViewController: UITabBarControllerDelegate {
    public override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {}
    
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
