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
    
    @IBOutlet weak var headValue: headView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headValue.progress = 0.1
        headValue.progress = 0.2
        headValue.progress = 0.4
        headValue.progress = 0.8


    }
    



}

