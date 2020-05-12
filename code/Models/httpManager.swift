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
    var baseUrl:String = "http://49.235.167.93:8001/believe"
    //var baseUrl:String = "http://192.168.31.113/believe"
    
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
    
    func downloadFile(fileName:String, failed:@escaping (_ errorCode:Int)->Void, success:@escaping ()->Void) -> Void {
        let session = URLSession(configuration: .default)
        
        //let url = "\(baseUrl)/downloadFile"
        let url = URL(string: "http://192.168.31.113/believe/downloadFile")!
        print("downloadfile url : \(url)")
        
        var request = URLRequest(url: url, timeoutInterval: 5)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let postData = ["filename":fileName]
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
            
            print("down data: \(data)")
            
            success()
        }
        task.resume()
    }
    
    func uploadFile( fileName:String, data:Data){
        //分隔线
        let boundary = "Boundary-\(UUID().uuidString)"
        
        //传递的参数
        let parameters = [
            "param1": "ABCD",
            "param2": "1234"
        ]
        
        //上传地址
        //let url = URL(string: "\(baseUrl)/uploadFile")!
        let url = URL(string: "http://192.168.31.113/believe/uploadFile")!
        var request = URLRequest(url: url)
        //请求类型为POST
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)",
            forHTTPHeaderField: "Content-Type")
        
        //创建表单body
        request.httpBody = try! createBodyWithData(with: parameters, data: data, filename: fileName,boundary: boundary)
         
        //创建一个表单上传任务
        let session = URLSession.shared
        let uploadTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            //上传完毕后
            if error != nil{
                print(error!)
            }else{
                let str = String(data: data!, encoding: String.Encoding.utf8)
                print("--- 上传完毕 ---\(str!)")
            }
        })
         
        //使用resume方法启动任务
        uploadTask.resume()
    }
    
    //创建表单body
    private func createBody(with parameters: [String: String]?,
                            files: [(name:String, path:String)],
                            boundary: String) throws -> Data {
//        //传递的文件
//        let files = [
//            (
//                name: "file1",
//                path:Bundle.main.path(forResource: "1", ofType: "jpg")!
//            ),
//            (
//                name: "file2",
//                path:Bundle.main.path(forResource: "2", ofType: "png")!
//            )
//        ]
        
        var body = Data()
         
        //添加普通参数数据
        if parameters != nil {
            for (key, value) in parameters! {
                // 数据之前要用 --分隔线 来隔开 ，否则后台会解析失败
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append("\(value)\r\n")
            }
        }
         
        //添加文件数据
        for file in files {
            let url = URL(fileURLWithPath: file.path)
            let filename = url.lastPathComponent
            let data = try Data(contentsOf: url)
            let mimetype = mimeType(pathExtension: url.pathExtension)
             
            // 数据之前要用 --分隔线 来隔开 ，否则后台会解析失败
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; "
                + "name=\"\(file.name)\"; filename=\"\(filename)\"\r\n")
            body.append("Content-Type: \(mimetype)\r\n\r\n") //文件类型
            body.append(data) //文件主体
            body.append("\r\n") //使用\r\n来表示这个这个值的结束符
        }
         
        // --分隔线-- 为整个表单的结束符
        body.append("--\(boundary)--\r\n")
        return body
    }
    
    //创建表单body
    private func createBodyWithData(with parameters: [String: String]?,
                                    data: Data,filename: String,
                            boundary: String) throws -> Data {
        var body = Data()
         
        //添加普通参数数据
        if parameters != nil {
            for (key, value) in parameters! {
                // 数据之前要用 --分隔线 来隔开 ，否则后台会解析失败
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append("\(value)\r\n")
            }
        }
         
        //添加文件数据
        let mimetype = "application/octet-stream"
         
        // 数据之前要用 --分隔线 来隔开 ，否则后台会解析失败
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; "
            + "name=\"file\"; filename=\"\(filename)\"\r\n")
        body.append("Content-Type: \(mimetype)\r\n\r\n") //文件类型
        body.append(data) //文件主体
        body.append("\r\n") //使用\r\n来表示这个这个值的结束符
         
        // --分隔线-- 为整个表单的结束符
        body.append("--\(boundary)--\r\n")
        return body
    }
     
    //根据后缀获取对应的Mime-Type
    func mimeType(pathExtension: String) -> String {
//        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
//                                                           pathExtension as NSString,
//                                                           nil)?.takeRetainedValue() {
//            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?
//                .takeRetainedValue() {
//                return mimetype as String
//            }
//        }
        //文件资源类型如果不知道，传万能类型application/octet-stream，服务器会自动解析文件类
        return "application/octet-stream"
    }
}

//扩展Data
extension Data {
    //增加直接添加String数据的方法
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}
