//
//  searchedUserInfoShowVC.swift
//  都信
//
//  Created by 李杰 on 2020/2/16.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

class searchedUserInfoShowVC: UIViewController {
    
    var userInfo:UserInfo?
    
    @IBOutlet weak var setNoteView: UIView!
    @IBOutlet weak var addTheUserVButton: UIView!
    @IBOutlet weak var name: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let guesture1 = UILongPressGestureRecognizer(target: self, action: #selector(setNoteViewLongPress))
        setNoteView.addGestureRecognizer(guesture1)
        let tapGuesture1 = UITapGestureRecognizer(target: self, action: #selector(setNoteViewClicked))
        setNoteView.addGestureRecognizer(tapGuesture1)
        setNoteView.isUserInteractionEnabled = true
        
        let guesture2 = UILongPressGestureRecognizer(target: self, action: #selector(addTheUserVButtonLongPress))
        addTheUserVButton.addGestureRecognizer(guesture2)
        let tapGuesture2 = UITapGestureRecognizer(target: self, action: #selector(addTheUserVButtonClicked))
        addTheUserVButton.addGestureRecognizer(tapGuesture2)
        addTheUserVButton.isUserInteractionEnabled = true
        
        print("get userinfo : \(userInfo?.name)")
        name.text = userInfo?.name
    }
    
    
    @IBAction func gobackClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func moreClicked(_ sender: UIBarButtonItem) {
        
    }
    
    @objc func setNoteViewLongPress(recognizer:UISwipeGestureRecognizer){
        if recognizer.state == .changed {
            //按住不放并且手指滑动时会触发该状态
            return
        }
        
        if recognizer.state == .began {
            recognizer.view?.backgroundColor = UIColor.hexColor(hex: "#D6D6D6", alpha: 0.5)
        }
        else
        {
            recognizer.view?.backgroundColor = UIColor.systemBackground
            
            AlertDialog.shared.alertDialog(title: "敬请期待", message: "功能暂未开放", actionText: "知道了")
        }
    }
    
    @objc func setNoteViewClicked(recognizer:UISwipeGestureRecognizer){
        AlertDialog.shared.alertDialog(title: "敬请期待", message: "功能暂未开放", actionText: "知道了")
    }
    
    @objc func addTheUserVButtonLongPress(recognizer:UISwipeGestureRecognizer){
        if recognizer.state == .changed {
            //按住不放并且手指滑动时会触发该状态
            return
        }
        
        if recognizer.state == .began {
            recognizer.view?.backgroundColor = UIColor.hexColor(hex: "#D6D6D6", alpha: 0.5)
        }
        else
        {
            recognizer.view?.backgroundColor = UIColor.systemBackground
            
            AlertDialog.shared.alertDialog(title: "敬请期待2", message: "功能暂未开放", actionText: "知道了")
        }
    }
    
    @objc func addTheUserVButtonClicked(recognizer:UISwipeGestureRecognizer){
        AlertDialog.shared.alertDialog(title: "敬请期待2", message: "功能暂未开放", actionText: "知道了")
    }
}
