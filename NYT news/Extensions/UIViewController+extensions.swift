//
//  UIViewController+extensions.swift
//  NYT news
//
//  Created by Ayman Ata on 8/12/20.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentNYAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = NYAlertVC(alertTitle: title, alertMessage: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
