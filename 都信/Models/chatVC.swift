//
//  chatVC.swift
//  都信
//
//  Created by 李杰 on 2020/2/27.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UIBarButtonItem!
    
    var currentFriendsList:[FriendInfo] = []
    
    
    override func viewDidLoad() {
        nameLabel.title = currentFriendsList[0].name
        
        print("the friend IP is : \(currentFriendsList[0].publicIP!)")
    }
}
