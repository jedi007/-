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
    
    var originFrame:CGRect?
    
    var currentFriendsList:[FriendInfo] = []
    var messageID:String!
    var messageName:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.title = currentFriendsList[0].name
        
        messageName = "deafult messageName"
        let randomNumber = arc4random() % 100000
        messageID = DateTools.shared.dateConvertString(date: Date(), dateFormat: "yyyy-MM-dd HH:mm:ss")+"+\(randomNumber)"
        print("messageID: \(messageID)")
        
        print("the friend IP is : \(currentFriendsList[0].publicIP!)")
        
        
        let viewSingleTapGesture = UITapGestureRecognizer(target: self, action: #selector(backViewClick))
        self.view.addGestureRecognizer(viewSingleTapGesture)
        self.view.isUserInteractionEnabled = true
        
        originFrame = self.view.frame
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    @objc func backViewClick(){
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame = (info[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
        
        view.frame.origin.y = -(keyboardFrame?.size.height)!
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        view.frame = originFrame!
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        
        if let messageData = messageTV.text.data(using: .utf8) {
            
            for finfo in currentFriendsList {
                
                var optionDic : [String: AnyObject] = [:]
                optionDic["telephone"] = mainUserInfo.telephone as AnyObject?
                optionDic["targetTelephone"] = finfo.telephone as AnyObject?
                optionDic["action"] = 1 as AnyObject?
                let convertStr:String =  JSONTools.shared.convertDictionaryToString(dict: optionDic)
                
                var messageDic : [String: AnyObject] = [:]
                messageDic["messageType"] = "friendsMessage" as AnyObject?
                messageDic["messageFrom"] = mainUserInfo.telephone as AnyObject?
                messageDic["messageID"] = messageID as AnyObject?
                messageDic["messageName"] = messageName as AnyObject?
                messageDic["messageDataType"] = "String" as AnyObject?
                messageDic["messageData"] = messageData as AnyObject?
                
                print("messageDic: \(messageDic)")
                
                //let messageDicData = try! JSONSerialization.data(withJSONObject: messageDic, options: .prettyPrinted)
                let messageDicData = NSKeyedArchiver.archivedData(withRootObject:messageDic as NSDictionary)
                //let messageDicData = NSKeyedArchiver.archivedData(withRootObject: <#T##Any#>, requiringSecureCoding: <#T##Bool#>)
                print("messageDicData: \(messageDicData)")
                
                //let dic = NSKeyedUnarchiver.unarchiveObject(with: messageDicData) as! NSDictionary
                //print("unarchiveObject messageDic: \(dic)")
                
                let sendData = "\(convertStr)####DATA####".data(using: .utf8)! + messageDicData
                
                UdpManager.shared.sendData(data: sendData, toHost: httpManager.shared.serverIP, port: httpManager.shared.serverPort)
                
                print("send messageDicData")
            }
            
        }
        
    }
    
}
