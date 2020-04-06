//
//  messagesViewController.swift
//  都信
//
//  Created by 李杰 on 2020/2/5.
//  Copyright © 2020 李杰. All rights reserved.
//
import UIKit

class messagesViewController: UIViewController {
    
    override func viewDidLoad() {
        print("messagesViewController viewDidLoad")
        
//        self.tabBarItem.image = UIImage(named: "都信")?.reSizeImage(reSize: CGSize(width: 32,height: 32))?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
//        self.tabBarItem.selectedImage = UIImage(named: "都信")?.reSizeImage(reSize: CGSize(width: 32,height: 32))?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
    }
    
    func onReceiveMessage(messageDic:NSDictionary) -> Void {
        print("messagesViewController receive messageDic: \(messageDic)")
        print("messagesViewController receive messageDic: \(messageDic["messageType"] as? String)")
        print("messagesViewController receive messageDic: \(messageDic["messageID"] as? String)")
        print("messagesViewController receive messageDic: \(messageDic["messageName"] as? String)")
        print("messagesViewController receive messageDic: \(messageDic["messageFrom"] as? String)")
        
        
        if let messageData = messageDic["messageData"] as? Data
        {
            print("receive messageDic: \(messageData.toHexString())")
            print("receive messageDic: \(String(data: messageData, encoding: .utf8))")
        }
        
    }
}
