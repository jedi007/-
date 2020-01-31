//
//  registerViewController.swift
//  都信
//
//  Created by 李杰 on 2020/1/29.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

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
    }
        
    required init?(coder: NSCoder) {
        self.sureAgreement = false
        
        super.init(coder:coder)
        print("reisterViewController init is called")
        
        self.modalPresentationStyle = .fullScreen //= UIModalPresentationFullScreen
        //fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func backToLogin(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func registeCliked(_ sender: UIButton) {
        
        if sureAgreement {
            
            guard checkForm() else {
                print("资料有待完善")
                return
            }
            
            let registeInfoDic:[String:String] = ["name":"\(nameTextField.text!)", "telephone":"\(telephoneTextField.text!)", "password":"\(passwordTextField.text!)", "sex":"男" ,"birthday":"1988-05-13 18:18:18"]
            httpManager.shared.regist(registeInfoDic: registeInfoDic,failed:{(errorCode:Int) in
                print("get failed info at out, errorCode: \(errorCode)")
                print("do something after get errorcode")
            } ){
                print("get success info at out")
            }
        }
        else
        {
            let alertController = UIAlertController(title: "提示", message: "请同意软件许可协议",preferredStyle: .alert)
            let Action1 = UIAlertAction(title: "知道了", style: .destructive, handler: nil)
            //let Action2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alertController.addAction(Action1)
            //alertController.addAction(Action2)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    
    
    @objc func sureImageClick() -> Void {
        print("image is clicked")
        
        sureAgreement = !sureAgreement
        
        let imagename:String = sureAgreement ? "RadioButton-checked.jpg" : "RadioButton-unchecked.jpg"
        
        sureImage.image = UIImage(named: imagename )
    }
    
    func checkForm() -> Bool {
        guard let name = nameTextField.text, !name.isEmpty else {
            print("姓名不完善")
            return false
        }
        
        guard let telephone = telephoneTextField.text, !RegularTools.shared.RegularExpression(regex: "^1\\d{10}$", validateString: telephone).isEmpty else {
            print("手机号填写不正确")
            return false
        }
        
        guard let password = passwordTextField.text, !RegularTools.shared.RegularExpression(regex: "^[0-9a-zA-Z]{8,}$", validateString: password).isEmpty else {
            print("密码最少为8位数字和字符的组合")
            return false
        }
        
        return true
    }
}
