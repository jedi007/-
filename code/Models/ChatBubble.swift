//
//  ChatBubble.swift
//  jediChat
//
//  Created by 李杰 on 2020/4/11.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

class ChatBubbleView: UIView {
    
    public override init(frame: CGRect)
    {
        super.init(frame: frame)
        print("ChatBubbleView init with frame called")
    }

    public required init?(coder: NSCoder){
        super.init(coder: coder)
        print("ChatBubbleView init with coder called")
        
        let viewWidth = CGFloat(self.frame.width)
        let viewHeight = CGFloat(self.frame.height)

        let path = UIBezierPath()
        
        UIColor.lightGray.setStroke()
        path.lineWidth = 5
        path.stroke()
        
        path.move(to: CGPoint(x:6, y:14))
        path.addLine(to: CGPoint(x:0, y:20))
        path.addLine(to: CGPoint(x:6, y:26))
        path.addLine(to: CGPoint(x:6, y:viewHeight))
        path.addLine(to: CGPoint(x:viewWidth, y:viewHeight))
        path.addLine(to: CGPoint(x:viewWidth, y:0))
        path.addLine(to: CGPoint(x:6, y:0))
        path.close()  //闭合路径，把起始点和终点连接起来

        let layer = CAShapeLayer()
        layer.path = path.cgPath
        
        self.layer.mask = layer
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
}
