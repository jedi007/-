//
//  discoverViewController.swift
//  都信
//
//  Created by 李杰 on 2020/2/8.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

class discoverViewController: UIViewController {
    
    @IBAction func addClicked(_ sender: UIBarButtonItem) {
        print("add button clciked")
        
        let items: [String] = ["发起群聊","添加朋友","扫一扫","收付款","帮助"]
        
        let img1 = UIImage(named: "发起群聊")?.withTintColor(UIColor.white)
        let img2 = UIImage(named: "新的朋友")?.withTintColor(UIColor.white)
        let img3 = UIImage(named: "扫一扫2")?.withTintColor(UIColor.white)
        let img4 = UIImage(named: "支付")?.withTintColor(UIColor.white)
        let img5 = UIImage(named: "帮助与反馈")?.withTintColor(UIColor.white)
        
        let imgSource: [UIImage] = [img1!, img2!, img3!, img4!, img5!]
        NavigationMenuShared.showPopMenuSelecteWithFrameWidth(width: itemWidth, height: 160, point: CGPoint(x: ScreenInfo.Width - 30, y: 12), items: items, imgs: imgSource) { (index) in
            ///点击回调
            switch index {
            case 0:
                print("点击测试1")
            case 1:
                print("点击测试2")
            case 2:
                print("点击测试3")
            case 3:
                print("点击测试4")
            case 4:
                print("点击测试5")
            default:
                break
            }
        }
        
    }
    
    
}
