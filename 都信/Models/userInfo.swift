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
        print("UserInfo init")
    }
}

class FriendInfo {
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
