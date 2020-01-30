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
        
    }
    
    func regist( registeInfoDic:Dictionary<String,String> ) {
        let session = URLSession(configuration: .default)
        // 设置URL(该地址不可用，写你自己的服务器地址)
        let url = "\(baseUrl)/regist_account"
        var request = URLRequest(url: URL(string: url)!, timeoutInterval: 3)
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
                return;
            }
            print(" in response ")
            do{
                //              将二进制数据转换为字典对象
                if let jsonObj:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? NSDictionary
                {
                    print(jsonObj)
                    //主线程
                    DispatchQueue.main.async{
                        
                    }
                }
            } catch{
                print("Error.")
                DispatchQueue.main.async{
                    
                }
                
            }
        }
        // 启动任务
        task.resume()
    }
}
