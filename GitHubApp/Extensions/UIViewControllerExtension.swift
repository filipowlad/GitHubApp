//
//  UIViewControllerExtension.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 26.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import UIKit

extension UIViewController {
    class var reuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    static var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
    
    func displaySpinner() {
        let spinnerView = UIView(frame: view.bounds)
        spinnerView.backgroundColor = .purple
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        spinnerView.tag = 100500
        spinnerView.addSubview(activityIndicator)
        view.addSubview(spinnerView)
        let alpha: CGFloat = 0.8
        spinnerView.alpha = 0.0
        UIView.animate(withDuration: 1.0) {
            spinnerView.alpha = alpha
        }
    }
    
    func removeSpinner() {
        guard let spinner = self.view.viewWithTag(100500) else { return }
        spinner.removeFromSuperview()
        self.view.layoutIfNeeded()
    }
}
