//
//  httpManager.swift
//  都信
//
//  Created by 李杰 on 2020/1/30.
//  Copyright © 2020 李杰. All rights reserved.
//

import Foundation

class httpManager {
    var baseUrl:String = "http://192.168.31.113/believe"
    
    static let shared = httpManager()
    
    private init() {
        print("httpManager inited")
    }
    
    
    func login( telephone:String, password:String,  failed:@escaping (_ errorCode:Int)->Void, success:@escaping ()->Void )
    {
        let session = URLSession(configuration: .default)
        // 设置URL(该地址不可用，写你自己的服务器地址)
        let url = "\(baseUrl)/login"
        var request = URLRequest(url: URL(string: url)!, timeoutInterval: 5)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        // 设置要post的内容，字典格式
        let postData = ["telephone":"\(telephone)", "password":"\(password)"]
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
            do{
                //              将二进制数据转换为字典对象
                if let jsonObj:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? NSDictionary
                {
                    print(jsonObj)
                    print(type(of: jsonObj["user"]))
//                    let test = 
//                    print( jsonObj["user"] )
//                    if let jsonObj_user:NSDictionary = try JSONSerialization.jsonObject(with: jsonObj["user"], options: JSONSerialization.ReadingOptions()) as? NSDictionary
//                    {
//                        print("jsonObj_user: \(jsonObj_user)")
//                    }
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
}
