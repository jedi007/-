//
//  addFriendsViewController.swift
//  都信
//
//  Created by 李杰 on 2020/2/16.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

class addFriendsViewController: UIViewController,UISearchBarDelegate {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myQrcode: UIButton!
    
    
    deinit {
        print("addFriendsViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //searchBar.subviews.first?.backgroundColor = UIColor.red
        searchBar.searchTextField.backgroundColor = UIColor.systemBackground
        searchBar.backgroundColor = UIColor.systemBackground
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 14.0, weight: .light)
        
        searchBar.delegate = self
        
        //navigationBar.backgroundColor = UIColor.lightGray
        navigationBar.barTintColor = UIColor.hexColor(hex: "EAEAEA",alpha: 0.9) //背景色，导航条背景色
        //navigationBar.isTranslucent = true // 导航条背景是否透明
        
        self.view.backgroundColor = UIColor.hexColor(hex: "EAEAEA")
    }
    
    @IBAction func gobackClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let _ = searchBar.text else { return }
        httpManager.shared.searchUser(telephone: searchBar.text!, failed: {(errorCode:Int) in
            print("searchUser failed with errorCode : \(errorCode)")
        }, success: { (userInfo:UserInfo) in
            print("searchUser successed")
            print(userInfo.name)
            
            let sb = UIStoryboard(name: "models", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "UserInfoShowVCID") as! searchedUserInfoShowVC
            vc.userInfo = userInfo
            
            
            self.present(vc, animated: true, completion: nil)
        })
    }
    
}
