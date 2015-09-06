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
        goalLayer.strokeColor = UIColor(red: 0, green: 0.3, blue: 0.59, alpha: 1).CGColor
        drankLayer.strokeColor = UIColor(red: 0.04, green: 0.950, blue: 0.91, alpha: 1).CGColor
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        setHead()
        goalLayer.strokeColor = UIColor(red: 0.1, green: 0.64, blue: 0.89, alpha: 1).CGColor
        drankLayer.strokeColor = UIColor(red: 0.04, green: 0.950, blue: 0.91, alpha: 1).CGColor
    }

    func setHead(){
        // Setup bg
        goalLayer.lineWidth = CGFloat(20.0)
        goalLayer.fillColor = UIColor.clearColor().CGColor
        goalLayer.strokeEnd = 1
        layer.addSublayer(goalLayer)
        
        // Setup fg
        drankLayer.lineWidth = CGFloat(20.0)
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
        
        let center = CGPoint(x: drankLayer.bounds.midX, y: drankLayer.bounds.midY)
        let radius = CGFloat(CGRectGetWidth(self.bounds) * 0.5)
        let startAngle = 60.0 * CGFloat(M_PI) / 180.0
        let endAngle = 120.0 * CGFloat(M_PI) / 180.0
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        shapeLayer.path = path.CGPath
        
    }
    
    func animate(){
        let animation = CASpringAnimation(keyPath: "strokeEnd")
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
