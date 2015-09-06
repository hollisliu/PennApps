//
//  ViewController.swift
//  Day Perfect
//
//  Created by Hanjie Liu on 9/5/15.
//  Copyright © 2015 Hanjie Liu. All rights reserved.
//

import UIKit
import QuartzCore
import HealthKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var headValue: headView!
    @IBOutlet weak var leftHand: handView!
    @IBOutlet weak var rightHand: RightHandView!
    @IBOutlet weak var leftLeg: LegView!
    @IBOutlet weak var rightLeg: RightLegView!
    
    let HManager = HealthManager()
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidLoad()
        
        HManager.authorizeHealthKit { (authorized,  error) -> Void in
            if authorized {
                print("HealthKit authorization received.")
            }
            else
            {
                print("HealthKit authorization denied!")
                if error != nil {
                    print("\(error)")
                }
            }
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.showAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let views = [headValue, leftHand, rightHand, leftLeg, rightLeg]
        
        views.map { (view: UIView) in
            view.layer.shadowRadius = 4
            view.layer.shadowOpacity = 0.5
            view.layer.shadowOffset = CGSize.zero
        }



    }
    
    func showAnimation(){
        
        headValue.progress = 0.5
        leftHand.progress = 0.4
        rightHand.progress = 0.6
        leftLeg.progress = 0.1
        rightLeg.progress = 0.8
    }
    
    
}

