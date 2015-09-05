//
//  HealthManager.swift
//  Day Perfect
//
//  Created by Hanjie Liu on 9/5/15.
//  Copyright © 2015 Hanjie Liu. All rights reserved.
//

import Foundation
import HealthKit

class HealthManager {
    let healthKitStore:HKHealthStore = HKHealthStore()
    
    //code learned from Raywenderlich.com
    func authorizeHealthKit(completion: ((success:Bool, error:NSError!) -> Void)!)
    {
        let healthKitTypesToRead = Set([HKQuantityTypeIdentifierStepCount, HKWorkoutTypeIdentifier])
        
        let healthKitTypesToWrite = Set([HKQuantityTypeIdentifierDietaryWater])
        
        if !HKHealthStore.isHealthDataAvailable()
        {
            let error = NSError(domain: "xyz.hollisliu.healthkit", code: 2, userInfo: [NSLocalizedDescriptionKey:"HealthKit is not available in this Device"])
            if( completion != nil )
            {
                completion(success:false, error:error)
            }
            return;
        }
        
//        healthKitStore.requestAuthorizationToShareTypes(typesToShare: healthKitTypesToWrite, readTypes: healthKitTypesToRead) { (success, error) -> Void in
//            
//            if( completion != nil )
//            {
//                completion(success:success,error:error)
//            }
//        }
    }
}
