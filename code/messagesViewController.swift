//
//  messagesViewController.swift
//  都信
//
//  Created by 李杰 on 2020/2/5.
//  Copyright © 2020 李杰. All rights reserved.
//
import UIKit

class messagesViewController: UIViewController {
    
    var messagesDics:Dictionary<String, Array<NSDictionary>> = [:]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("messagesViewController viewDidLoad")
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
        
        if let messageID = messageDic["messageID"] as? String {
            if (messagesDics.keys.contains(messageID)) {
                print("has key: \(messageID)")
                messagesDics[messageID]?.append(messageDic)
            } else {
                print("didn't has key: \(messageID)")
                messagesDics[messageID] = [messageDic]
            }
            
            tableView.reloadData()
        }
        
        
    }
}


extension messagesViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    //设置列表有多少行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesDics.count
    }
    //设置每行数据的数据载体Cell视图
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("indexPath.row:  \(indexPath.row)  indexPath.section: \(indexPath.section)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessagesCell", for: indexPath) as! MessagesCell
        
        let keys = messagesDics.keys.sorted()
        
        if let dic = messagesDics[keys[indexPath.row]]?.last {
            let fromTelephone = dic["messageFrom"] as! String
            
            for friendinfo in friendsList {
                if friendinfo.telephone == fromTelephone {
                    print("find the from friend")
                    cell.messageName.text = friendinfo.name
                    break
                }
            }
            
            if let mdata = dic["messageData"] as? Data {
                cell.abstract.text = String(data: mdata, encoding: .utf8)
            }
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
        if indexPath.section > 0 {
            let sb = UIStoryboard(name: "models", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "FriendInfoVCID") as! FriendInfoViewController
            vc.friendInfo = friendsList[indexPath.row]
            self.present(vc, animated: true, completion: nil)
            
        }
    }
}


