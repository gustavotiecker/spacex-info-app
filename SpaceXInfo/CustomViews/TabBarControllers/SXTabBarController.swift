//
//  SXTabBarController.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 07/12/20.
//

import UIKit

class SXTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemRed
        viewControllers = [createUpcomingLaunchesVC(), createLatestLaunchesVC(), createRocketsVC()]
    }
    
    func createUpcomingLaunchesVC() -> UINavigationController {
        let upcomingLaunchesVC = UpcomingLaunchesVC()
        upcomingLaunchesVC.title = "Upcoming Launches"
        upcomingLaunchesVC.tabBarItem = UITabBarItem(title: "Upcoming", image: UIImage(systemName: "arrow.right.square"), tag: 0)
        
        return UINavigationController(rootViewController: upcomingLaunchesVC)
    }
    
    func createLatestLaunchesVC() -> UINavigationController {
        let latestLaunchesVC = LatestLaunchesVC()
        latestLaunchesVC.title = "Latest Launches"
        latestLaunchesVC.tabBarItem = UITabBarItem(title: "Latest", image: UIImage(systemName: "clock.arrow.circlepath"), tag: 1)
        
        return UINavigationController(rootViewController: latestLaunchesVC)
    }
    
    func createRocketsVC() -> UINavigationController{
        let rocketsVC = RocketsVC()
        rocketsVC.title = "Rockets"
        rocketsVC.tabBarItem = UITabBarItem(title: "Rockets", image: UIImage(named: "rocketIcon"), tag: 2)
        
        return UINavigationController(rootViewController: rocketsVC)
    }
}
