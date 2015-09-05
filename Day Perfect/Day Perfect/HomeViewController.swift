//
//  ViewController.swift
//  Day Perfect
//
//  Created by Hanjie Liu on 9/5/15.
//  Copyright © 2015 Hanjie Liu. All rights reserved.
//

import UIKit
import QuartzCore

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        leftHandView = progressView(frame: CGRect(x: view.bounds.midX, y: 0, width: 30, height:100))
//        leftHandView.layer.cornerRadius = 15
//        
//        view.addSubview(leftHandView)


    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: CGFloat(0.6), initialSpringVelocity: CGFloat(0), options: UIViewAnimationOptions.CurveEaseOut, animations: {
//            self.leftHandView.frame.size.height = 200
//            }, completion: nil)
        
//        let grow = CABasicAnimation(keyPath: "size.height")
//        grow.fromValue = 100
//        grow.toValue = 200
//        grow.duration = 1.5
//        leftHandView.layer.addAnimation(grow, forKey: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

