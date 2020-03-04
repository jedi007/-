//
//  extensionViewController.swift
//  都信
//
//  Created by 李杰 on 2020/2/2.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

extension UIViewController
{
    // 获取当前显示的 ViewController
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?
    {
        if let nav = base as? UINavigationController
        {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController
        {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController
        {
            return currentViewController(base: presented)
        }
        return base
    }
}
