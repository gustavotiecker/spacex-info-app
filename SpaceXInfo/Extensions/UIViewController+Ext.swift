//
//  UIViewController+Ext.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 09/12/20.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentAlertOnTheMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = SPXAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemIndigo
        present(safariVC, animated: true)
    }
}
