//
//  chatVC.swift
//  都信
//
//  Created by 李杰 on 2020/2/27.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UIBarButtonItem!
    
    @IBOutlet weak var messageTV: UITextView!
    
    
    var currentFriendsList:[FriendInfo] = []
    
    
    override func viewDidLoad() {
        nameLabel.title = currentFriendsList[0].name
        
        print("the friend IP is : \(currentFriendsList[0].publicIP!)")
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        
        if let messageData = messageTV.text.data(using: .utf8) {
            
            for finfo in currentFriendsList {
                
                var dic : [String: AnyObject] = [:]
                dic["telephone"] = mainUserInfo.telephone as AnyObject?
                dic["targetTelephone"] = finfo.telephone as AnyObject?
                dic["action"] = 1 as AnyObject?
                let convertStr:String =  JSONTools.shared.convertDictionaryToString(dict: dic)
                let sendData = "\(convertStr)####DATA####".data(using: .utf8)! + messageData
                
                UdpManager.shared.sendData(data: sendData, toHost: httpManager.shared.serverIP, port: httpManager.shared.serverPort)
            }
            
        }
        
    }
    
}
