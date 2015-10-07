//
//  FSExtensions+Array.swift
//  SwiftHelpers
//

import Foundation

extension Array {
    
    func objectAtIndexOrNil (index:Int) -> Element? {
        if (index < self.count && index >= 0) {
            return self[index]
        } else {
            return nil
        }
    }
    
    func shuffle () -> Array {
        var array:Array = self
        
        for (var i = 0; i < array.count; i++) {
            let remainingCount = array.count - i
            let exchangeIndex = i + Int(arc4random_uniform(UInt32(remainingCount)))
            
            swap(&array[i], &array[exchangeIndex])
        }
        
        return array
    }
}
