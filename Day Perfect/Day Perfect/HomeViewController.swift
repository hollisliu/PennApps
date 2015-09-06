//
//  ViewController.swift
//  Day Perfect
//
//  Created by Hanjie Liu on 9/5/15.
//  Copyright © 2015 Hanjie Liu. All rights reserved.
//

import UIKit
import HealthKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var headValue: headView!
    @IBOutlet weak var leftHand: handView!
    @IBOutlet weak var rightHand: RightHandView!
    @IBOutlet weak var leftLeg: LegView!
    @IBOutlet weak var rightLeg: RightLegView!
    
    var waterValue:Double = 0
    
    var selectedBtn: Int?
    
    var stepsInLast100Reads = 0{didSet{showAnimation()}}
    
    let HManager = HealthManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getStepFromHealth()
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor(red: 0.02, green: 0.47, blue: 0.08, alpha: 1)]
        self.navigationController!.navigationBar.titleTextAttributes = titleDict as! [String : AnyObject]

        let views = [headValue, leftHand, rightHand, leftLeg, rightLeg]
        
        views.map { (view: UIView) in
            view.layer.shadowRadius = 4
            view.layer.shadowOpacity = 0.5
            view.layer.shadowOffset = CGSize.zero
        }
        
        showAnimation()


    }
    
    func showAnimation(){
        
        headValue.progress = waterValue
        leftHand.progress = 2/3
        rightHand.progress = 0.6
        leftLeg.progress = Double(stepsInLast100Reads) / Double(10000)
        rightLeg.progress = 0.8
    }
    
    //buttons
    @IBAction func headIncrese(sender: UIButton) {
        waterValue += 0.1
        showAnimation()
    }
    @IBAction func getDetail(sender: UIButton) {
        selectedBtn = sender.tag
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let next = segue.destinationViewController as! DetailViewController
        next.type = self.selectedBtn
        next.steps = self.stepsInLast100Reads
    }
    
    func getStepFromHealth(){
        HManager.authorizeHealthKit { (authorized,  error) -> Void in
            if authorized {
                print("HealthKit authorization received.")
                
                let healthStore: HKHealthStore? = {
                    if HKHealthStore.isHealthDataAvailable() {
                        return HKHealthStore()
                    } else {
                        return nil
                    }
                    }()
                
                let stepsCount = HKQuantityType.quantityTypeForIdentifier(
                    HKQuantityTypeIdentifierStepCount)
                let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
                
                let stepsSampleQuery = HKSampleQuery(sampleType: stepsCount!,
                    predicate: nil,
                    limit: 100,
                    sortDescriptors: [sortDescriptor])
                    { [unowned self] (query, results, error) in
                        if let results = results as? [HKQuantitySample] {
                            var sum:Double = 0
                            for i in 0...99{
                                sum += results[i].quantity.doubleValueForUnit(HKUnit.countUnit())
                            }
                            self.stepsInLast100Reads = Int(sum)
                            self.leftLeg.progress = sum / Double(10000)
                        }
                }
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
                    healthStore?.executeQuery(stepsSampleQuery)
                    dispatch_async(dispatch_get_main_queue()){
                        self.showAnimation()
                    }
                }

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
    
}

