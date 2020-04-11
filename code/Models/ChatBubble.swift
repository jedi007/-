//
//  ChatBubble.swift
//  jediChat
//
//  Created by 李杰 on 2020/4/11.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

class ChatBubbleView: UIView {
    
    var viewWidth:CGFloat?
    var viewHeight:CGFloat?
    var messageStr:String?
    
    public override init(frame: CGRect)
    {
        super.init(frame: frame)
        print("ChatBubbleView init with frame called")
    }

    public required init?(coder: NSCoder){
        super.init(coder: coder)
        print("ChatBubbleView init with coder called")
        
    }
    
    func setMessageStr(message:String) -> Void {
        messageStr = message
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        print("ChatBubbleView draw is called")
        viewWidth = CGFloat(self.frame.width)
        viewHeight = CGFloat(self.frame.height)

        let path = UIBezierPath()
        
        UIColor.lightGray.setStroke()
        path.lineWidth = 5
        path.stroke()
        
        path.move(to: CGPoint(x:6, y:14))
        path.addLine(to: CGPoint(x:0, y:20))
        path.addLine(to: CGPoint(x:6, y:26))
        path.addLine(to: CGPoint(x:6, y:viewHeight!))
        path.addLine(to: CGPoint(x:viewWidth!, y:viewHeight!))
        path.addLine(to: CGPoint(x:viewWidth!, y:0))
        path.addLine(to: CGPoint(x:6, y:0))
        path.close()  //闭合路径，把起始点和终点连接起来

        let layer = CAShapeLayer()
        layer.path = path.cgPath
        
        self.layer.mask = layer
        
        let showlabel = UILabel(frame: CGRect(x: 11, y: 5, width: viewWidth!-16, height: viewHeight!-10))
        showlabel.text = messageStr
        
        //两行代码实现label自动换行
        showlabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        showlabel.numberOfLines = 0
        
        self.addSubview(showlabel)
    }
    
}
