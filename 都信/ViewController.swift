//
//  ViewController.swift
//  都信
//
//  Created by 李杰 on 2020/1/29.
//  Copyright © 2019 李杰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func register(_ sender: UIButton) {
        
        print("注册被电击了")
        
        let ndate = stringConvertDate(string: "2019-05-13 19:58:44")
        
        let strDate = dateConvertString(date: ndate, dateFormat: "yyyy-MM-dd HH:mm:ss")
        
        print(strDate)
        
        post(name: "lijie", telephone: "1356899002", password: "111111", sex: "男", birthday: "1988-05-13 18:18:18")

    }
    
    func post(name:String, telephone:String, password:String, sex:String, birthday:String) {
        let session = URLSession(configuration: .default)
        // 设置URL(该地址不可用，写你自己的服务器地址)
        let url = "http://192.168.31.113/believe/regist_account"
        var request = URLRequest(url: URL(string: url)!, timeoutInterval: 3)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        // 设置要post的内容，字典格式
        let postData = ["name":"\(name)", "telephone":"\(telephone)", "password":"\(password)", "sex":"\(sex)" ,"birthday":"\(birthday)"]
        let postString = postData.compactMap({ (key, value) -> String in
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
    
    func dateConvertString(date:Date, dateFormat:String="yyyy-MM-dd") -> String {
        //let timeZone = TimeZone.init(identifier: "UTC")
        let formatter = DateFormatter()
        //formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
        //return date.components(separatedBy: " ").first!
    }
    
    func stringConvertDate(string:String, dateFormat:String="yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: string)
        return date!
    }
    
}

