//
//  mainTabBarController.swift
//  都信
//
//  Created by 李杰 on 2020/2/5.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

class mainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items: [UITabBarItem] = self.tabBar.items!
        
        items[0].selectedImage = UIImage(named: "都信")?.reSizeImage(reSize: CGSize(width: 32,height: 32))?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        items[0].image = UIImage(named: "都信")?.reSizeImage(reSize: CGSize(width: 32,height: 32))?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)

        items[1].selectedImage = UIImage(named: "通讯录")?.reSizeImage(reSize: CGSize(width: 28,height: 28))?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        items[1].image = UIImage(named: "通讯录")?.reSizeImage(reSize: CGSize(width: 28,height: 28))?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        items[2].selectedImage = UIImage(named: "发现")?.reSizeImage(reSize: CGSize(width: 32,height: 32))?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        items[2].image = UIImage(named: "发现")?.reSizeImage(reSize: CGSize(width: 32,height: 32))?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        items[3].selectedImage = UIImage(named: "头像")?.reSizeImage(reSize: CGSize(width: 32,height: 32))?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        items[3].image = UIImage(named: "头像")?.reSizeImage(reSize: CGSize(width: 32,height: 32))?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        
        UdpManager.shared.receiveHandle = {(data: Data,host: String,port: UInt16) -> Void in
            print("in receiveHandle")
            let receiveData = String(data: data, encoding: String.Encoding.utf8)
            
            
            let dateNow = DateTools.shared.dateConvertString(date: Date(), dateFormat: "yyyy-MM-dd HH:mm:ss")
            print("dateNow: \(dateNow)")
            
            
            if let dic = NSKeyedUnarchiver.unarchiveObject(with: data) as? NSDictionary
            {
                print("NSMutableDictionary success")
                if let messageType = dic["messageType"] as? String
                {
                    switch messageType {
                        case "friendsMessage":
                            if let vc = UIViewController.currentViewController() as? ChatViewController{
                                vc.appendMessage(dic: dic)
                            } else {
                                let messagesNVC = self.viewControllers?[0] as! UINavigationController
                                let messagesVC = messagesNVC.viewControllers[0] as! messagesViewController
                                messagesVC.onReceiveMessage(messageDic: dic)
                            }
                        default:
                            print("default")
                    }
                }
            }
        }
    
        if let bytes = MyFileManager.readBytesFromFile() {
            messagesDics = NSKeyedUnarchiver.unarchiveObject(with: bytes) as? NSDictionary as! Dictionary<String, Array<NSDictionary>>
        }
    }
    
}
