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
        let viewController = HomeViewController()
        viewController.title = "Home"
        viewController.tabBarItem = UITabBarItem(title: "Home", image: SFSymbols.home, tag: 0)
        
        return UINavigationController(rootViewController: viewController)
    }
    
    func createUpcomingLaunchesVC() -> UINavigationController {
        let viewController = UpcomingLaunchesViewController()
        viewController.title = "Upcoming Launches"
        viewController.tabBarItem = UITabBarItem(title: "Upcoming", image: SFSymbols.upcoming, tag: 1)
        
        return UINavigationController(rootViewController: viewController)
    }
    
    func createRocketsVC() -> UINavigationController{
        let viewModel = RocketsViewModel()
        let viewController = RocketsViewController(viewModel: viewModel)
        viewModel.viewDelegate = viewController
        viewController.title = "Rockets"
        viewController.tabBarItem = UITabBarItem(title: "Rockets", image: SFSymbols.rocket, tag: 2)
        
        return UINavigationController(rootViewController: viewController)
    }
}
