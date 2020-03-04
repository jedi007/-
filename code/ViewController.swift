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
        
        
    }
    
    

    @IBAction func register(_ sender: UIButton) {
        print("点击了 注册")
        
        let ndate = DateTools.shared.stringConvertDate(string: "2019-05-13 19:58:44")
        
        let strDate = DateTools.shared.dateConvertString(date: ndate, dateFormat: "yyyy-MM-dd HH:mm:ss")
        
        print("日期转换测试: "+strDate)

    }
    
}

