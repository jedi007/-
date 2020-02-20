//
//  addressBookCell.swift
//  都信
//
//  Created by 李杰 on 2020/2/20.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

class AddressBookCell: UITableViewCell {
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var telephone:String?
    
    
    
    //实现系统设置了首选字体后自动更新字体大小， 还需在storyBoard中也做相应设置
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //nameLabel.adjustsFontForContentSizeCategory = true
    }
    
}
