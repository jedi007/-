//
//  mineChatBubble.swift
//  jediChat
//
//  Created by 李杰 on 2020/4/12.
//  Copyright © 2020 李杰. All rights reserved.
//

import UIKit

class MineChatBubbleView: UIView {
    
    var viewWidth:CGFloat?
    var viewHeight:CGFloat?
    var messageStr:String?
    var showlabel:UILabel?
    
    public override init(frame: CGRect)
    {
        super.init(frame: frame)
        print("MineChatBubbleView init with frame called")
    }

    public required init?(coder: NSCoder){
        super.init(coder: coder)
        print("MineChatBubbleView init with coder called")
        
    }
    
    func setMessageStr(message:String) -> Void {
        messageStr = message
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        print("MineChatBubbleView draw is called")
        viewWidth = CGFloat(self.frame.width)
        viewHeight = CGFloat(self.frame.height)
        
        print("viewHeight: \(viewHeight)")

        let path = UIBezierPath()
        
        let radius:CGFloat = 5
        
        //画圆角,clockwise: true 顺时针方向
        path.addArc(withCenter: CGPoint(x: viewWidth!-6-radius, y: radius), radius: radius, startAngle: CGFloat(Double.pi)*1.5, endAngle: 0, clockwise: true)
        
        //画气泡尖
        path.addLine(to: CGPoint(x:viewWidth!-6, y:14))
        path.addLine(to: CGPoint(x:viewWidth!, y:20))
        path.addLine(to: CGPoint(x:viewWidth!-6, y:26))
        
        path.addLine(to: CGPoint(x:viewWidth!-6, y:viewHeight!-radius))
        path.addArc(withCenter: CGPoint(x: viewWidth!-6-radius, y: viewHeight!-radius), radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi)*0.5, clockwise: true)

        path.addLine(to: CGPoint(x:radius, y:viewHeight!))
        path.addArc(withCenter: CGPoint(x: radius, y: viewHeight!-radius), radius: radius, startAngle: CGFloat(Double.pi)*0.5, endAngle: CGFloat(Double.pi), clockwise: true)

        path.addLine(to: CGPoint(x:0, y:radius))
        path.addArc(withCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi)*1.5, clockwise: true)

        path.addLine(to: CGPoint(x:viewWidth!-6-radius, y:0))
        
//        UIColor.red.setFill()
//        UIColor.black.setStroke()
//
//        path.fill()
//        path.stroke()
        

        let layer = CAShapeLayer()
        layer.path = path.cgPath
        
        self.layer.mask = layer
        
        if showlabel != nil {
            showlabel!.removeFromSuperview()
        }
        showlabel = UILabel(frame: CGRect(x: radius, y: radius, width: viewWidth!-6-radius*2, height: viewHeight!-radius*2))
        showlabel!.text = messageStr
        
        //两行代码实现label自动换行
        showlabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        showlabel!.numberOfLines = 0
        
        self.addSubview(showlabel!)
    }
    
}
