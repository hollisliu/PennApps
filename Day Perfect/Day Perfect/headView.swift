//
//  headView.swift
//  Day Perfect
//
//  Created by Hanjie Liu on 9/5/15.
//  Copyright © 2015 Hanjie Liu. All rights reserved.
//

import UIKit

@IBDesignable
class headView: UIView {
    var progress = 0.0{didSet{animate()}}

    let goalLayer = CAShapeLayer()
    let drankLayer = CAShapeLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
        goalLayer.lineWidth = CGFloat(50.0)
        goalLayer.fillColor = UIColor.clearColor().CGColor
        goalLayer.strokeEnd = 1
        layer.addSublayer(goalLayer)
        
        // Setup fg
        drankLayer.lineWidth = CGFloat(50.0)
        drankLayer.fillColor = UIColor.clearColor().CGColor
        drankLayer.strokeEnd = 0.3
        layer.addSublayer(drankLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShapeLayer(drankLayer)
        setupShapeLayer(goalLayer)
    }
    
    func setupShapeLayer(shapeLayer: CAShapeLayer) {
        
        shapeLayer.frame = self.bounds
        
        let center = self.center
        let radius = CGFloat(CGRectGetWidth(self.bounds) * 0.25)
        let startAngle = 60.0 * CGFloat(M_PI) / 180.0
        let endAngle = 120.0 * CGFloat(M_PI) / 180.0
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        shapeLayer.path = path.CGPath
        
    }
    
    func animate(){
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.3
        animation.toValue = 0.8

        animation.duration = CFTimeInterval(2)

        drankLayer.removeAnimationForKey("stroke")
        drankLayer.addAnimation(animation, forKey: "stroke")
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        drankLayer.strokeEnd = 0.8
        CATransaction.commit()
    }
    
}
