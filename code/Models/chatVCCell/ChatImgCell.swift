//
//  ChatImgCell.swift
//  jediChat
//
//  Created by 李杰 on 2020/5/7.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

class ChatImgCell: UITableViewCell {
    
    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        print("ChatImgCell init called")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //fatalError("init(coder:) has not been implemented")
        //print("ChatVCCell init called with coder")
        
    }
    
    //实现系统设置了首选字体后自动更新字体大小， 还需在storyBoard中也做相应设置
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //print("messagesCell awakeFromNib")
        
        //nameLabel.adjustsFontForContentSizeCategory = true
    }
    
}
