//
//  mineSpaceViewController.swift
//  都信
//
//  Created by 李杰 on 2020/2/6.
//  Copyright © 2020 李杰. All rights reserved.
//
import UIKit

class mineSspaceViewController: UIViewController {
    @IBOutlet weak var userInfoSVC: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewSingleTapGesture = UITapGestureRecognizer(target: self, action: #selector(goUserInfoVC))
        userInfoSVC.addGestureRecognizer(viewSingleTapGesture)
        userInfoSVC.isUserInteractionEnabled = true
    }
    
    @objc func goUserInfoVC(){
        print("go user info vc")
    }
}
