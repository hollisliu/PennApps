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
    
    var progress = 0.0
    
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
        path.moveToPoint(self.bounds.origin)
        path.addLineToPoint(CGPoint(x: self.bounds.maxX, y: self.bounds.maxY))
        shapeLayer.path = path.CGPath
        
    }


}
