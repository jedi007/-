//
//  registerViewController.swift
//  都信
//
//  Created by 李杰 on 2020/1/29.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

class reisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        print("init is called")
        
        self.modalPresentationStyle = .fullScreen //= UIModalPresentationFullScreen
        //fatalError("init(coder:) has not been implemented")
    }
}
