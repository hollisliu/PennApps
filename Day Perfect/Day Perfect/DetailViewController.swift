//
//  DetailViewController.swift
//  Day Perfect
//
//  Created by Hanjie Liu on 9/6/15.
//  Copyright © 2015 Hanjie Liu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var type: Int?
    var steps = 0
    
    @IBOutlet weak var titleName: UILabel!

    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var comments: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch type!{
        case 1:
            titleName.text = "Sleep Duratoin"
            titleName.textColor = UIColor(red: 0.33, green: 0.24, blue: 0.75, alpha: 1)
            score.text = "6/9 hr"
            comments.text = "Adults are generally recommended to have at least 7 hours of sleep every night. (This reading is hard coded due to hardware failure)"
        case 2:
            titleName.text = "Environment Composite"
            titleName.textColor = UIColor.greenColor()
            score.text = "76/100"
            comments.text = "You should avoid sitting in dusty room for health concerns. This number is composed of dust and gas level. (This reading is hard coded due to hardware failure)"
        case 3:
            titleName.text = "Steps"
            titleName.textColor = UIColor.orangeColor()
            score.text = "\(steps)/10000 steps."
            comments.text = "Walking is a globally recommended exercise. Eat less and move more! (This reading is retrieved from HealthKit in iPhone and Apple Watch.)"
        case 4:
            titleName.text = "Noise Level"
            titleName.textColor = UIColor(red: 1, green: 0.34, blue: 0.56, alpha: 1)
            score.text = "40/100"
            comments.text = "Noise is bad for both your mental and physcial heath. (This reading is hard coded due to hardware failure)"

        default: break
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
