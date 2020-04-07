//
//  loginViewController.swift
//  都信
//
//  Created by 李杰 on 2020/2/2.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {
    
    @IBOutlet weak var telephoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    required init?(coder: NSCoder) {
        super.init(coder:coder)
        print("loginViewController init is called")
        
        self.modalPresentationStyle = .fullScreen
        //fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("loginViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let backImage = UIImage(named: "返回")
//        let leftButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: nil)
        
        let leftButton = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(back))
        leftButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = leftButton
        
        let viewSingleTapGesture = UITapGestureRecognizer(target: self, action: #selector(backViewClick))
        self.view.addGestureRecognizer(viewSingleTapGesture)
        self.view.isUserInteractionEnabled = true
        
        UdpManager.shared//激活、初始化
        
        let dic = SaveInfo.readInfo()
        if dic.keys.contains("telephone") {
            login(failedAlert: false, telephone: dic["telephone"] as! String, password: dic["password"] as! String)
        }
    }
    
    @objc func backViewClick(){
        self.view.endEditing(true)
    }
    
    @objc func back()->Void
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func login(_ sender: UIButton) {
        print("login clicked")
        
//        guard checkForm() else {
//            return
//        }
        
        login(failedAlert: true,telephone: telephoneTextField.text!,password: passwordTextField.text!.md5)
    }
    
    func login(failedAlert:Bool,telephone:String,password:String) -> Void {
        httpManager.shared.login(telephone: telephone, password: password, publicIP: mainUserInfo.publicIP, failed:{(errorCode:Int) in
        //httpManager.shared.login(telephone: "13568991512", password: "qqqqqqqq".md5, publicIP: mainUserInfo.publicIP, failed:{(errorCode:Int) in
            print("get failed info at out, errorCode: \(errorCode)")
            
            if failedAlert {
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
            }
        } ){
            print("login success")
            
            var dic = SaveInfo.readInfo()
            dic["telephone"] = telephone as AnyObject
            dic["password"]  = password as AnyObject
            SaveInfo.writeInfo(infoDic: dic)
            
            DispatchQueue.main.async{
                var dic : [String: AnyObject] = [:]
                dic["telephone"] = mainUserInfo.telephone! as AnyObject?
                dic["action"] = 0 as AnyObject?
                let convertStr:String = JSONTools.shared.convertDictionaryToString(dict: dic)
                let senddata = convertStr.data(using: .utf8)!
                UdpManager.shared.sendData(data: senddata, toHost: httpManager.shared.serverIP, port: httpManager.shared.serverPort)
                
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let main_vc = sb.instantiateViewController(withIdentifier: "mainTabBarController")
                
                //self.navigationController?.popToRootViewController(animated: false)
                self.dismiss(animated: false, completion: {
                    if let vc = UIViewController.currentViewController() {
                        main_vc.modalPresentationStyle = .fullScreen
                        vc.present(main_vc, animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    func alertDialog(title:String, message:String, actionText:String, actionHandler:((UIAlertAction) -> Void)? = nil ) ->Void {
        let alertController = UIAlertController(title: title, message: message,preferredStyle: .alert)
        let Action1 = UIAlertAction(title: actionText, style: .destructive, handler: actionHandler)
        //let Action2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(Action1)
        //alertController.addAction(Action2)
        //self.present(alertController, animated: true, completion: nil)
        
        if let vc = UIViewController.currentViewController() {
            vc.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func checkForm() -> Bool {
        
        guard let telephone = telephoneTextField.text, !RegularTools.shared.RegularExpression(regex: "^1\\d{10}$", validateString: telephone).isEmpty else {
            alertDialog(title: "提示", message: "手机号码填写不正确", actionText: "知道了")
            return false
        }
        
        guard let password = passwordTextField.text, !RegularTools.shared.RegularExpression(regex: "^[0-9a-zA-Z]{8,}$", validateString: password).isEmpty else {
            alertDialog(title: "提示", message: "密码最少为8位数字和字符的组合", actionText: "知道了")
            return false
        }
        
        return true
    }
    
}
