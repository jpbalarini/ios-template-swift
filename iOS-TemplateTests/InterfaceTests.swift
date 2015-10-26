//
//  InterfaceTests.swift
//  iOS-Template
//

import UIKit
import XCTest

class InterfaceTests: KIFTestCase {
    
    override func beforeAll() {
        super.beforeAll()
    }
    
    override func afterAll() {
        super.afterAll()
    }
    
    override func beforeEach() {
        super.beforeEach()
    }
    
    override func afterEach() {
        super.afterEach()
    }
    
    func testExample() {
        tester().waitForViewWithAccessibilityLabel("Hello Worsssld!")
        tester().tapViewWithAccessibilityLabel("Tap to show alert")
        tester().tapViewWithAccessibilityLabel("OK")
        //tester().waitForTimeInterval(1)
    }
    
}
