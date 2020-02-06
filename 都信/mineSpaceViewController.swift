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
    @IBOutlet weak var photoButton: UIButton!
    
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var payView: UIView!
    @IBOutlet weak var collectionView: UIView!
    @IBOutlet weak var photoAlbumView: UIView!
    @IBOutlet weak var expressionView: UIView!
    @IBOutlet weak var settingView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoButton.setImage(UIImage(named: "camera")?.reSizeImage(reSize: CGSize(width: 32,height: 32))?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        
        let viewSingleTapGesture = UITapGestureRecognizer(target: self, action: #selector(goUserInfoVC))
        userInfoSVC.addGestureRecognizer(viewSingleTapGesture)
        userInfoSVC.isUserInteractionEnabled = true
        
        let headImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(goUserInfoVC))
        headImage.addGestureRecognizer(headImageTapGesture)
        headImage.isUserInteractionEnabled = true
        
        let views:[UIView] = [payView,collectionView,photoAlbumView,expressionView,settingView]
        for view in views {
            let guesture = UILongPressGestureRecognizer(target: self, action: #selector(viewLongPress))
            view.addGestureRecognizer(guesture)
            
            let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(viewClicked))
            view.addGestureRecognizer(tapGuesture)
            
            view.isUserInteractionEnabled = true
        }
        
        
    }
    
    @objc func goUserInfoVC(){
        print("go user info vc")
        
        AlertDialog.shared.alertDialog(title: "敬请期待", message: "功能暂未开放", actionText: "知道了")
    }
    
    @objc func viewLongPress(recognizer:UISwipeGestureRecognizer)
    {
        print("viewLongPress called")
        recognizer.view?.backgroundColor = UIColor.red
    }
    
    @objc func viewClicked(recognizer:UISwipeGestureRecognizer)
    {
        print("viewclicked called")
        print("view tag : \(String(describing: recognizer.view?.tag))")
    }
}
