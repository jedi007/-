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
    var showlabel:UILabel?
    
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
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        print("ChatBubbleView draw is called")
        viewWidth = CGFloat(self.frame.width)
        viewHeight = CGFloat(self.frame.height)

        let path = UIBezierPath()
        
        let radius:CGFloat = 5
        
        //画圆角,clockwise: true 顺时针方向
        path.addArc(withCenter: CGPoint(x: 11, y: radius), radius: radius, startAngle: CGFloat(Double.pi)*1.5, endAngle: CGFloat(Double.pi), clockwise: false)
        
        //画气泡尖
        path.addLine(to: CGPoint(x:6, y:14))
        path.addLine(to: CGPoint(x:0, y:20))
        path.addLine(to: CGPoint(x:6, y:26))
        
        path.addLine(to: CGPoint(x:6, y:viewHeight!-radius))
        path.addArc(withCenter: CGPoint(x: 6+radius, y: viewHeight!-radius), radius: radius, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi)*0.5, clockwise: false)

        path.addLine(to: CGPoint(x:viewWidth!-radius, y:viewHeight!))
        path.addArc(withCenter: CGPoint(x: viewWidth!-radius, y: viewHeight!-radius), radius: radius, startAngle: CGFloat(Double.pi)*0.5, endAngle: 0, clockwise: false)

        path.addLine(to: CGPoint(x:viewWidth!, y:radius))
        path.addArc(withCenter: CGPoint(x: viewWidth!-radius, y: radius), radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi)*1.5, clockwise: false)

        path.addLine(to: CGPoint(x:6+radius, y:0))
        
//        UIColor.red.setFill()
//        UIColor.black.setStroke()
//
//        path.fill()
//        path.stroke()
        
        //path.close()  //闭合路径，把起始点和终点连接起来
        

        let layer = CAShapeLayer()
        layer.path = path.cgPath
        
        self.layer.mask = layer
        
        if showlabel != nil {
            showlabel!.removeFromSuperview()
        }
        showlabel = UILabel(frame: CGRect(x: 6+radius, y: radius, width: viewWidth!-16, height: viewHeight!-10))
        showlabel!.text = messageStr
        
        //两行代码实现label自动换行
        showlabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        showlabel!.numberOfLines = 0
        
        self.addSubview(showlabel!)
    }
    
}
