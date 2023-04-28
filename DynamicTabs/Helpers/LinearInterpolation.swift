//
//  LinearInterpolation.swift
//  DynamicTabs
//
//  Created by Max Valek on 4/28/23.
//

import SwiftUI

// Class for helping with linear interp. for tab animation
class LinearInterpolation {
    private var length: Int
    private var inputRange: [CGFloat]
    private var outputRange: [CGFloat]
    
    init(inputRange: [CGFloat], outputRange: [CGFloat]) {
        // safety check
        assert(inputRange.count == outputRange.count)
        
        self.length = inputRange.count - 1
        self.inputRange = inputRange
        self.outputRange = outputRange
    }
    
    func calculate(for x: CGFloat) -> CGFloat {
        // if value less that its initial input range
        if x <= inputRange[0] { return outputRange[0] }
        
        // starting range is 1, because need previous value
        for index in 1...length {
            let x1 = inputRange[index - 1]
            let x2 = inputRange[index]
            
            let y1 = outputRange[index - 1]
            let y2 = outputRange[index]
            
            // Linear interpolation formula:
            // y = y1 + ((y2 - y1) / (x2 - x1)) * (x - x1)
            if x <= inputRange[index] {
                // apply formula to nearest input range value
                let y = y1 + ((y2 - y1) / (x2 - x1)) * (x - x1)
                return y
            }
        }
        
        // if value exceeds its maximum input range
        return outputRange[length]
    }
}
