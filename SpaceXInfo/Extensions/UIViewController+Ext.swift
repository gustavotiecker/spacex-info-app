//
//  UIViewController+Ext.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 09/12/20.
//

import UIKit

extension UIViewController {
    
    func presentAlertOnTheMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = SXAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
