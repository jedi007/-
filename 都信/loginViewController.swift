//
//  loginViewController.swift
//  都信
//
//  Created by 李杰 on 2020/2/2.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {

    required init?(coder: NSCoder) {
        super.init(coder:coder)
        print("loginViewController init is called")
        
        self.modalPresentationStyle = .fullScreen
        //fatalError("init(coder:) has not been implemented")
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
    }
}
