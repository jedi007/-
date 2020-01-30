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
        print("注册被点击了")
        
        let ndate = DateTools.stringConvertDate(string: "2019-05-13 19:58:44")
        
        let strDate = DateTools.dateConvertString(date: ndate, dateFormat: "yyyy-MM-dd HH:mm:ss")
        
        print("日期转换测试: "+strDate)

    }
    
}

