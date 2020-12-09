//
//  UpcomingLaunchesVC.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 07/12/20.
//

import UIKit

class UpcomingLaunchesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        NetworkManager.shared.getUpcomingLaunches { [weak self] result in
            guard let self = self else { return }
            
            switch(result) {
            case .success(let launches):
                print(launches)
            case .failure(let error):
                self.presentAlertOnTheMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}
