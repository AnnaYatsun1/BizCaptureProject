//
//  UINavigationController.swift
//  Core
//
//  Created by Анна Яцун on 22.10.2024.
//

import Foundation
import UIKit

public extension UINavigationController {
    func configureTabBarItem(title: String, image: String, tag: Int) -> Self {
        if #available(iOS 13.0, *) {
            tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: image), tag: tag)
        } else {
            // Fallback on earlier versions
        }
        return self
    }
}
