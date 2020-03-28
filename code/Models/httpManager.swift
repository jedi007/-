//
//  httpManager.swift
//  都信
//
//  Created by 李杰 on 2020/1/30.
//  Copyright © 2020 李杰. All rights reserved.
//

import Foundation

class httpManager {
    var serverIP:String = "49.235.167.93"
    var serverPort:UInt16 = 8009
    var baseUrl:String = "http://49.235.167.93:8001/believe"//"http://192.168.31.113/believe"
    
    static let shared = httpManager()
    
    private init() {
        print("httpManager inited")
    }
    
    
    func login( telephone:String, password:String,  publicIP:String, failed:@escaping (_ errorCode:Int)->Void, success:@escaping ()->Void )
    {
        print("in login publicIP: \(publicIP)")
        let session = URLSession(configuration: .default)
        // 设置URL(该地址不可用，写你自己的服务器地址)
        let url = "\(baseUrl)/login"
        var request = URLRequest(url: URL(string: url)!, timeoutInterval: 5)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        // 设置要post的内容，字典格式
        let postData = ["telephone":"\(telephone)", "password":"\(password)", "loginIP":"\(publicIP)"]
        let postString = postData.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&")
        request.httpBody = postString.data(using: .utf8)
        // 后面不解释了，和GET的注释一样
        let task = session.dataTask(with: request) {(data, response, error) in
            if error != nil
            {
                print("error : \(error!.localizedDescription)")
                failed(-201)
                return;
            }
            print(" in response ")
            print(response)
            do{
                //              将二进制数据转换为字典对象
                if let jsonObj:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? NSDictionary
                {
                    if let uInfoDic = jsonObj["user"] as? NSDictionary
                    {
                        mainUserInfo.telephone = uInfoDic["telephone"] as? String
                        mainUserInfo.name      = uInfoDic["name"] as? String
                        mainUserInfo.sex       = uInfoDic["sex"] as? String
                        mainUserInfo.birthday  = uInfoDic["birthday"] as? String
                    }
                    
                    if let friendsInfo = jsonObj["friends"] as? [Any]
                    {
                        friendsList.removeAll()
                        for friendInfo in friendsInfo {
                            if let fInfoDic = friendInfo as? NSDictionary
                            {
                                let fInfo:FriendInfo = FriendInfo()
                                fInfo.telephone = fInfoDic["friendTel"] as? String
                                fInfo.name = fInfoDic["name"] as? String
                                fInfo.sex = fInfoDic["sex"] as? String
                                fInfo.birthday = fInfoDic["birthday"] as? String
                                fInfo.addDate = fInfoDic["addDate"] as? String
                                fInfo.publicIP = fInfoDic["loginIP"] as? String
                                friendsList.append(fInfo)
                            }
                        }
                        print(friendsList[1].publicIP!)
                    }
                    
                    if let result_code = jsonObj["result"] as? Int{
                        print( type(of: result_code) )
                        
                        if result_code == 0 {
                            //主线程
                            DispatchQueue.main.async{
                                success()
                            }
                        }
                        else
                        {
                            failed(result_code)
                        }
                    }
                    else
                    {
                        failed(-202)
                    }
                }
            } catch{
                print("Error.")
                failed(-203)
                DispatchQueue.main.async{
                    
                }
                
            }
        }
        // 启动任务
        task.resume()
    }
    
    
    func regist( registeInfoDic:Dictionary<String,String>, failed:@escaping (_ errorCode:Int)->Void, success:@escaping ()->Void ) {
        let session = URLSession(configuration: .default)
        // 设置URL(该地址不可用，写你自己的服务器地址)
        let url = "\(baseUrl)/regist_account"
        var request = URLRequest(url: URL(string: url)!, timeoutInterval: 5)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        // 设置要post的内容，字典格式
        // let postData = ["name":"\(name)", "telephone":"\(telephone)", "password":"\(password)", "sex":"\(sex)" ,"birthday":"\(birthday)"]
        let postString = registeInfoDic.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&")
        request.httpBody = postString.data(using: .utf8)
        // 后面不解释了，和GET的注释一样
        let task = session.dataTask(with: request) {(data, response, error) in
            if error != nil
            {
                print("error : \(error!.localizedDescription)")
                failed(-201)
                return;
            }
            print(" in response ")
            do{
                //              将二进制数据转换为字典对象
                if let jsonObj:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? NSDictionary
                {
                    print(jsonObj)
                    if let result_code = jsonObj["result"] as? Int{
                        print( type(of: result_code) )
                        
                        if result_code == 0 {
                            //主线程
                            DispatchQueue.main.async{
                                success()
                            }
                        }
                        else
                        {
                            failed(result_code)
                        }
                    }
                    else
                    {
                        failed(-202)
                    }
                }
            } catch{
                print("Error.")
                failed(-203)
                DispatchQueue.main.async{
                    
                }
                
            }
        }
        // 启动任务
        task.resume()
    }

    func searchUser( telephone:String, failed:@escaping (_ errorCode:Int)->Void, success:@escaping (_ userInfo:UserInfo)->Void ) -> Void {
        let session = URLSession(configuration: .default)
        
        let url = "\(baseUrl)/searchUser"
        var request = URLRequest(url: URL(string: url)!, timeoutInterval: 5)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let postData = ["telephone":"\(telephone)"]
        let postString = postData.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&")
        request.httpBody = postString.data(using: .utf8)
        
        let task = session.dataTask(with: request) {(data, response, error) in
            if error != nil
            {
                print("error : \(error!.localizedDescription)")
                failed(-201)
                return;
            }
            
            do{
                if let jsonObj:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? NSDictionary
                {
                    if let result_code = jsonObj["result"] as? Int{
                        if result_code == 0 {
                            let userInfo:UserInfo = UserInfo()
                            let uInfoDic = jsonObj["user"] as? NSDictionary
                            userInfo.telephone = telephone
                            userInfo.name = uInfoDic!["name"] as? String
                            userInfo.sex = uInfoDic!["sex"] as? String
                            userInfo.birthday = uInfoDic!["birthday"] as? String
                            
                            DispatchQueue.main.async{
                                success(userInfo)
                            }
                        } else {
                            failed(result_code)
                        }
                    } else {
                        failed(-202)
                    }
                }
            } catch{
                failed(-203)
            }
        }
        task.resume()
    }
    
    func addFriend( InfoDic:Dictionary<String,String>, failed:@escaping (_ errorCode:Int)->Void, success:@escaping ()->Void ) {
        let session = URLSession(configuration: .default)
        
        let url = "\(baseUrl)/addFriend"
        var request = URLRequest(url: URL(string: url)!, timeoutInterval: 5)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let postString = InfoDic.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&")
        request.httpBody = postString.data(using: .utf8)
        
        let task = session.dataTask(with: request) {(data, response, error) in
            if error != nil
            {
                print("error : \(error!.localizedDescription)")
                failed(-201)
                return;
            }
            
            do{
                if let jsonObj:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? NSDictionary
                {
                    if let result_code = jsonObj["result"] as? Int{
                        if result_code == 0 {
                            DispatchQueue.main.async{
                                success()
                            }
                        } else {
                            failed(result_code)
                        }
                    } else {
                        failed(-202)
                    }
                }
            } catch{
                failed(-203)
            }
        }
        task.resume()
    }
}
