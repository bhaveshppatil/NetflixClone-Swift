//
//  ViewController.swift
//  NetflixClone-Swift
//
//  Created by Perennial Macbook on 21/02/22.
//

import UIKit

class MainScreenViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tab1 = UINavigationController(rootViewController: HomeViewController())
        let tab2 = UINavigationController(rootViewController: UpcomingViewController())
        let tab3 = UINavigationController(rootViewController: SearchViewController())
        let tab4 = UINavigationController(rootViewController: DownloadViewController())
        
        tab1.tabBarItem.image = UIImage(systemName: "house")
        tab2.tabBarItem.image = UIImage(systemName: "play.circle")
        tab3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        tab4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        tab1.title = "Home"
        tab2.title = "Upcoming"
        tab3.title = "Top Search"
        tab4.title = "Downloads"
        tabBar.tintColor = .label

        setViewControllers([tab1, tab2, tab3, tab4], animated: true)

    }
}

