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
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var originFrame:CGRect?
    
    var messagesArr:Array<NSDictionary> = []{
        didSet
        {
            print("已经改变的时候");
            print(messagesArr)
            
            for dic in messagesArr {
                if let friendList = dic["friendList"] as? [FriendInfo]{
                    print(friendList)
                    currentFriendsList = friendList
                }
            }
            
        }
    }
    
    var currentFriendsList:[FriendInfo] = []
    var messageID:String!
    var messageName:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentFriendsList.count < 3
        {
            for fInfo in currentFriendsList {
                if fInfo.telephone != mainUserInfo.telephone {
                    nameLabel.title = fInfo.name
                    messageName = fInfo.telephone
                }
            }
        } else {
            var title:String = ""
            for fInfo in currentFriendsList {
                if fInfo.telephone == mainUserInfo.telephone {
                    continue
                }
                title = title + "," + (fInfo.name ?? "")
            }
            nameLabel.title = title
            messageName = title
        }
        
        if currentFriendsList.count == 1 {
            let meInfo = FriendInfo()
            meInfo.telephone = mainUserInfo.telephone
            meInfo.name = mainUserInfo.name
            meInfo.sex = mainUserInfo.sex
            meInfo.publicIP = mainUserInfo.publicIP
            currentFriendsList.append(meInfo)
        }
        
        let randomNumber = arc4random() % 100000
        messageID = DateTools.shared.dateConvertString(date: Date(), dateFormat: "yyyy-MM-dd HH:mm:ss")+"+\(randomNumber)"
        print("messageID: \(messageID)")
        
        print("the friend IP is : \(currentFriendsList[0].publicIP!)")
        
        
        let viewSingleTapGesture = UITapGestureRecognizer(target: self, action: #selector(backViewClick))
        self.view.addGestureRecognizer(viewSingleTapGesture)
        self.view.isUserInteractionEnabled = true
        
        originFrame = self.view.frame
        
        tableView.delegate = self
        tableView.dataSource = self
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
                messageDic["friendList"] = currentFriendsList as AnyObject?
                
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


extension ChatViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    //设置列表有多少行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArr.count
    }
    //设置每行数据的数据载体Cell视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("indexPath.row:  \(indexPath.row)  indexPath.section: \(indexPath.section)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatViewCellID", for: indexPath) as! ChatVCCell
        
        let dic = messagesArr[indexPath.row]
        if let messagedata = dic["messageData"] as? Data,
            let messagestr = String(data: messagedata, encoding: .utf8){
            cell.showlabel.text = messagestr
        }
        
        return cell
    }
    
    //设置列表的分区数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //设置索引栏标题
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return nil
    }
    //设置分区头部标题
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    //这个方法将索引栏上的文字与具体的分区进行绑定
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath.row:  \(indexPath.row)  indexPath.section: \(indexPath.section)")
    }
}
