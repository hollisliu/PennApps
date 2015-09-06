//
//  Day.swift
//  Day Perfect
//
//  Created by Hanjie Liu on 9/5/15.
//  Copyright © 2015 Hanjie Liu. All rights reserved.
//

import Foundation

class Day {
    let date: NSDate
    
    var waterIntake = 0.0
    var sleep = 0.0
    var enrironment = 0.0
    var step = 0
    var workout = 0
    
    init(date: NSDate){
        self.date = date
    }
}