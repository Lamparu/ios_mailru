//
//  TabBarController.swift
//  BFY
//
//  Created by Влада Приходченко on 09.12.2021.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        let profileVC = ProfileViewController()
        let bookVC = MainBookViewController()
        let libraryVC = LibraryViewController()
        
        let profileSize = 45.0
        let profile_icon = UITabBarItem(title: "Профиль",
                                        image: UIImage(named: "profile")?.resized(to: CGSize(width: profileSize, height: profileSize)),
                                        selectedImage: UIImage(named: "profile")?.resized(to: CGSize(width: profileSize, height: profileSize)))
        profileVC.tabBarItem = profile_icon
        
        let libSize = 35.0
        let lib_icon = UITabBarItem(title: "Библиотека",
                                     image: UIImage(named: "lib")?.resized(to: CGSize(width: libSize, height: libSize)),
                                     selectedImage: UIImage(named: "lib")?.resized(to: CGSize(width: libSize, height: libSize)))
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x6A7F60)], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        libraryVC.tabBarItem = lib_icon
        
        let bookSize = 40.0
        let book_icon = UITabBarItem(title: "Читаю",
                                     image: UIImage(named: "box_empty")?.resized(to: CGSize(width: bookSize, height: bookSize)),
                                     selectedImage: UIImage(named: "box_filled")?.resized(to: CGSize(width: bookSize, height: bookSize)))
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x6A7F60)], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
       
        bookVC.tabBarItem = book_icon
        let controllers = [profileVC, libraryVC, bookVC]  //array of the root view controllers displayed by the tab bar interface
        self.viewControllers = controllers
        self.selectedViewController = bookVC
        
        self.tabBar.tintColor = UIColor(rgb: 0x6A7F60)
        
        navigationItem.hidesBackButton = true
    }

    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true;
    }
}
