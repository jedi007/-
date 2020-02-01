//
//  registerViewController.swift
//  都信
//
//  Created by 李杰 on 2020/1/29.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

extension UIViewController
{
    // 获取当前显示的 ViewController
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?
    {
        if let nav = base as? UINavigationController
        {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController
        {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController
        {
            return currentViewController(base: presented)
        }
        return base
    }
}


class reisterViewController: UIViewController {

    @IBOutlet weak var sureImage: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var telephoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var sureAgreement:Bool
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(sureImageClick))
        sureImage.addGestureRecognizer(singleTapGesture)
        //sureImage.isUserInteractionEnabled = true
        
        let viewSingleTapGesture = UITapGestureRecognizer(target: self, action: #selector(backViewClick))
        self.view.addGestureRecognizer(viewSingleTapGesture)
        self.view.isUserInteractionEnabled = true
        
        
        nameTextField.returnKeyType = UIReturnKeyType.done
    }
        
    required init?(coder: NSCoder) {
        self.sureAgreement = false
        
        super.init(coder:coder)
        print("reisterViewController init is called")
        
        self.modalPresentationStyle = .fullScreen //= UIModalPresentationFullScreen
        //fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func backToLogin(_ sender: UIButton) {
        self.view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func registeCliked(_ sender: UIButton) {
        
        if sureAgreement {
            guard checkForm() else {
                print("资料有待完善")
                return
            }
            
            let password_md5 = passwordTextField.text!.md5
            
            let registeInfoDic:[String:String] = ["name":"\(nameTextField.text!)", "telephone":"\(telephoneTextField.text!)", "password":"\(password_md5)", "sex":"男" ,"birthday":"1988-05-13 18:18:18"]
            httpManager.shared.regist(registeInfoDic: registeInfoDic,failed:{(errorCode:Int) in
                print("get failed info at out, errorCode: \(errorCode)")
                
                if errorCode == -1
                {
                    DispatchQueue.main.async{
                        self.alertDialog(title: "注册失败", message: "该账号已经注册", actionText: "知道了")
                    }
                }
            } ){
                print("get success info at out")
                self.alertDialog(title: "注册成功", message: "注册成功", actionText: "OK", actionHandler: {(action:UIAlertAction) in
                    self.view.endEditing(true)
                    self.dismiss(animated: true, completion: nil)
                })
            }
        }
        else
        {
            alertDialog(title: "提示", message: "请同意软件许可协议", actionText: "知道了")
        }
    }
    
    
    @objc func sureImageClick() -> Void {
        print("image is clicked")
        
        sureAgreement = !sureAgreement
        
        let imagename:String = sureAgreement ? "RadioButton-checked.jpg" : "RadioButton-unchecked.jpg"
        
        sureImage.image = UIImage(named: imagename )
    }
    
    
    @objc func backViewClick()->Void {
        print("backViewClicked")
        self.view.endEditing(true)
    }
    
    
    func checkForm() -> Bool {
        guard let name = nameTextField.text, !name.isEmpty else {
            alertDialog(title: "提示", message: "姓名填写不完善", actionText: "知道了")
            return false
        }
        
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
    
    
    func alertDialog(title:String, message:String, actionText:String, actionHandler:((UIAlertAction) -> Void)? = nil ) ->Void {
        let alertController = UIAlertController(title: title, message: message,preferredStyle: .alert)
        let Action1 = UIAlertAction(title: actionText, style: .destructive, handler: actionHandler)
        //let Action2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(Action1)
        //alertController.addAction(Action2)
        self.present(alertController, animated: true, completion: nil)
    }
}
