//
//  hand.swift
//  Day Perfect
//
//  Created by Hanjie Liu on 9/5/15.
//  Copyright © 2015 Hanjie Liu. All rights reserved.
//

import UIKit

@IBDesignable
class handView: UIView {
    
    var oldValue = 0.0
    var progress = 0.0{
        didSet{
            animate()
            self.oldValue = progress
        }}
    
    let goalLayer = CAShapeLayer()
    let drankLayer = CAShapeLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clearColor()
        setHead()
        goalLayer.strokeColor = UIColor.greenColor().CGColor
        drankLayer.strokeColor = UIColor.blueColor().CGColor
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setHead()
        goalLayer.strokeColor = UIColor.greenColor().CGColor
        drankLayer.strokeColor = UIColor.blueColor().CGColor
    }
    
    func setHead(){
        // Setup bg
        goalLayer.lineWidth = CGFloat(15.0)
        goalLayer.fillColor = UIColor.clearColor().CGColor
        goalLayer.strokeEnd = 1
        layer.addSublayer(goalLayer)
        
        // Setup fg
        drankLayer.lineWidth = CGFloat(15.0)
        drankLayer.fillColor = UIColor.clearColor().CGColor
        drankLayer.strokeEnd = CGFloat(progress)
        layer.addSublayer(drankLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShapeLayer(drankLayer)
        setupShapeLayer(goalLayer)
    }
    
    func setupShapeLayer(shapeLayer: CAShapeLayer) {
        
        shapeLayer.frame = self.bounds
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: self.layer.bounds.maxX, y: self.layer.bounds.maxY))
        path.addLineToPoint(self.layer.bounds.origin)
        shapeLayer.path = path.CGPath
        
    }
    
    func animate(){
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = oldValue
        animation.toValue = progress
        
        animation.duration = CFTimeInterval(2)
        
        drankLayer.removeAnimationForKey("stroke")
        drankLayer.addAnimation(animation, forKey: "stroke")
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        drankLayer.strokeEnd = CGFloat(progress)
        CATransaction.commit()
    }


}
