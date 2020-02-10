//
//  jediPopMenu.swift
//  都信
//
//  Created by 李杰 on 2020/2/10.
//  Copyright © 2020 李杰. All rights reserved.
//
import UIKit

let NavigationMenuShared = jediPopMenu.shared

class jediPopMenu: NSObject {
    static let shared = jediPopMenu()
    private var menuView:jediPopMenuView?

    public func showPopMenuSelecteWithFrameWidth(width: CGFloat, height: CGFloat, point: CGPoint, items: [String], imgs: [UIImage], action: @escaping ((Int) -> Void)) {
        weak var weakSelf = self
        /// 每次重置保证显示效果
        if self.menuView != nil {
            weakSelf?.hideMenu()
        }
        let window = UIApplication.shared.windows.first
        self.menuView = jediPopMenuView(width: width, height: height, point: point, items: items, imgs: imgs, action: { (index) in
            ///点击回调
            action(index)
            weakSelf?.hideMenu()
        })
        menuView?.touchBlock = {
            weakSelf?.hideMenu()
        }
        self.menuView?.backgroundColor = UIColor.black.withAlphaComponent(0)
        window?.addSubview(self.menuView!)
    }
    
    public func hideMenu() {
        self.menuView?.removeFromSuperview()
        self.menuView = nil
    }
}
