//
//  ColorClickTests.swift
//  ColorClickTests
//
//  Created by John Leibowitz on 5/29/17.
//  Copyright © 2017 John Leibowitz. All rights reserved.
//

import XCTest
@testable import ColorPuppers

class ColorPuppersTests: XCTestCase {
    
//    override func setUp() {
//        super.setUp()
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
//    
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//    
    
    //Test that GameColors.getRandomGameColor is working
    func testRandomColor() {
        let testGameColors = GameColorsAndObjects()
        let testGameColor = testGameColors.getRandomGameColor(butNot: [GameColor.green])
        XCTAssert(GameColor.green.name != testGameColor.name, "green was not supposed to be chosen")
        print(testGameColor.name)
    }

    //Test random distributed int is working
    func testRandomInt() {
        
        var tempInt: Int
        let testMax = 10
        
        for distIndex in 0...GamePlayParameters.StageGeneration.maxNumOfDistributions {
            print("Distribution Index: \(distIndex)")
            var total = 0
            for _ in 0...testMax {
                tempInt = Utilities.getDistributedRandomIndex(upperBoundInclusive: testMax, distributionIndex: distIndex)
                print(tempInt)
                XCTAssert(tempInt >= 0 && tempInt <= testMax)
                total += tempInt
            }
            print("average: \(total/testMax)")
        }
        
        
    }
    
    
    
}
