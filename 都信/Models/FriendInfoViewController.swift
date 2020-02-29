//
//  FriendInfoViewController.swift
//  都信
//
//  Created by 李杰 on 2020/2/20.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

class FriendInfoViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var telephoneLabel: UILabel!
    
    @IBOutlet weak var setnoteView: UIView!
    @IBOutlet weak var friendCircleView: UIView!
    @IBOutlet weak var moreInfoView: UIView!
    @IBOutlet weak var sendMessageButtonView: UIView!
    @IBOutlet weak var sendVideoButtonView: UIView!
    
    var friendInfo:FriendInfo?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        print("init FriendVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let info = friendInfo {
            nameLabel!.text = info.name
            telephoneLabel!.text = info.telephone
        }
        
        let views:[UIView] = [setnoteView,friendCircleView,moreInfoView,sendMessageButtonView,sendVideoButtonView]
        for view in views {
            let guesture = UILongPressGestureRecognizer(target: self, action: #selector(viewLongPress))
            view.addGestureRecognizer(guesture)
            
            let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(viewClicked))
            view.addGestureRecognizer(tapGuesture)
            
            view.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func gobackClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func viewLongPress(recognizer:UISwipeGestureRecognizer)
    {
        print("viewLongPress called")
        
        print(recognizer.state.rawValue)
        
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
            actionTag(tag: recognizer.view?.tag)
        }
    }
    
    @objc func viewClicked(recognizer:UISwipeGestureRecognizer)
    {
        actionTag(tag: recognizer.view?.tag)
    }
    
    func actionTag(tag:Int?)
    {
        if tag == 4 {
            print("发送消息")
            let sb = UIStoryboard(name: "models", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "ChatVCID") as! ChatViewController
            vc.currentFriendsList.append(friendInfo!)
            
            
            present(vc, animated: true, completion: nil)
            
        }else if tag == 5 {
            print("发起视屏")
        } else {
            AlertDialog.shared.alertDialog(title: "敬请期待", message: "功能暂未开放", actionText: "知道了")
        }
    }
}
