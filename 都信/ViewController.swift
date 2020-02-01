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
    
    
    @IBAction func login(_ sender: UIButton) {
        print("点击了 登陆")
        
        httpManager.shared.login(telephone: "13568991512", password: "qqqqqqqq".md5,failed:{(errorCode:Int) in
            print("get failed info at out, errorCode: \(errorCode)")
            
            if errorCode == -1
            {
                DispatchQueue.main.async{
                    self.alertDialog(title: "登陆失败", message: "该账号已经注册", actionText: "知道了")
                }
            }
            else
            {
                DispatchQueue.main.async{
                    self.alertDialog(title: "登陆失败", message: "错误码： \(errorCode)", actionText: "知道了")
                }
            }
        } ){
            print("get success info at out")
            self.alertDialog(title: "登陆成功", message: "登陆成功", actionText: "OK", actionHandler: nil)
        }
        
        
    }
    
    

    @IBAction func register(_ sender: UIButton) {
        print("点击了 注册")
        
        let ndate = DateTools.shared.stringConvertDate(string: "2019-05-13 19:58:44")
        
        let strDate = DateTools.shared.dateConvertString(date: ndate, dateFormat: "yyyy-MM-dd HH:mm:ss")
        
        print("日期转换测试: "+strDate)

    }
    
    
    func alertDialog(title:String, message:String, actionText:String, actionHandler:((UIAlertAction) -> Void)? = nil ) ->Void {
        let alertController = UIAlertController(title: title, message: message,preferredStyle: .alert)
        let Action1 = UIAlertAction(title: actionText, style: .destructive, handler: actionHandler)
        //let Action2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(Action1)
        //alertController.addAction(Action2)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

