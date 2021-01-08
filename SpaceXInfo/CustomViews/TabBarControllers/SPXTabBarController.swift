//
//  SPXTabBarController.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 07/12/20.
//

import UIKit

class SPXTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemIndigo
        viewControllers = [createHomeVC(), createUpcomingLaunchesVC(), createRocketsVC()]
    }
    
    func createHomeVC() -> UINavigationController {
        let homeVC = HomeViewController()
        homeVC.title = "Home"
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: SFSymbols.home, tag: 0)
        
        return UINavigationController(rootViewController: homeVC)
    }
    
    func createUpcomingLaunchesVC() -> UINavigationController {
        let upcomingLaunchesVC = UpcomingLaunchesViewController()
        upcomingLaunchesVC.title = "Upcoming Launches"
        upcomingLaunchesVC.tabBarItem = UITabBarItem(title: "Upcoming", image: SFSymbols.upcoming, tag: 1)
        
        return UINavigationController(rootViewController: upcomingLaunchesVC)
    }
    
    func createRocketsVC() -> UINavigationController{
        let rocketsVC = RocketsViewController()
        rocketsVC.title = "Rockets"
        rocketsVC.tabBarItem = UITabBarItem(title: "Rockets", image: SFSymbols.rocket, tag: 2)
        
        return UINavigationController(rootViewController: rocketsVC)
    }
}
