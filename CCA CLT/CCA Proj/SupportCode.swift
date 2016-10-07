//
//  SupportCode.swift
//  CCA Proj
//
//  Created by CC on 10/7/16.
//  Copyright © 2016 CC. All rights reserved.
//

import Cocoa
import CoreGraphics

extension Array {
    
    var toData: Data {
        return Data(buffer: UnsafeBufferPointer(start: self, count: count))
    }
    
}
