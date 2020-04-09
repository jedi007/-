//
//  userInfo.swift
//  都信
//
//  Created by 李杰 on 2020/2/16.
//  Copyright © 2020 李杰. All rights reserved.
//

import Foundation

class UserInfo {
    var telephone:String?
    var password:String?
    var name:String?
    var sex:String?
    var birthday:String?
    var publicIP:String = "0.0.0.0"
    
    init() {
        NetworkManager.getPublicIP(backBlock: {
            str in
            print("UserInfo init : \(str)")
            self.publicIP = str
        })
    }
}

class FriendInfo:NSObject, NSCoding {
    func encode(with coder: NSCoder) {
        coder.encode(telephone,forKey:"telephone")
        coder.encode(name,forKey:"name")
        coder.encode(sex,forKey:"sex")
        coder.encode(birthday,forKey:"birthday")
        coder.encode(addDate,forKey:"addDate")
        coder.encode(publicIP,forKey:"publicIP")
        coder.encode(loginDate,forKey:"loginDate")
    }
    
    required init?(coder: NSCoder) {
        telephone = coder.decodeObject(forKey: "telephone") as? String
        name = coder.decodeObject(forKey:"name") as? String
        sex = coder.decodeObject(forKey:"sex") as? String
        birthday = coder.decodeObject(forKey:"birthday") as? String
        addDate = coder.decodeObject(forKey:"addDate") as? String
        publicIP = coder.decodeObject(forKey:"publicIP") as? String
        loginDate = coder.decodeObject(forKey:"loginDate") as? String
    }
    
    override init() {
        super.init()
    }
    
    var telephone:String?
    var name:String?
    var sex:String?
    var birthday:String?
    var addDate:String?
    var publicIP:String?
    var loginDate:String?
}

let mainUserInfo:UserInfo = UserInfo()
var friendsList:[FriendInfo] = []
