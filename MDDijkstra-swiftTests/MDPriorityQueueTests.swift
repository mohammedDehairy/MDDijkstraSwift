//
//  MDPriorityQueueTests.swift
//  MDDijkstra-swift
//
//  Created by mohamed mohamed El Dehairy on 12/10/16.
//  Copyright © 2016 mohamed El Dehairy. All rights reserved.
//

import XCTest
@testable import MDDijkstraSwift

class MDPriorityQueueTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddObject() {
        let queue = MDPriorityQueue<NSNumber>(comparatorBlock: {(num1 : NSNumber, num2 : NSNumber)->ComparisonResult in
            num1.compare(num2)
        })
        
        let array = generateRandomlyShuffledArray()
        
        for i in array{
            queue.addObject(obj: i)
        }
        
        
        for i in 0..<600{
            let min = queue.removeMinObject()
            XCTAssertTrue((min?.isEqual(to: NSNumber(value: i)))!)
        }
    }
    
    func generateRandomlyShuffledArray()->[NSNumber]{
        var array = [NSNumber]()
        for i in 0 ..< 600{
            let num = NSNumber(value: i)
            array.append(num)
        }
        
        return shuffle(array: array) as! [NSNumber]
    }
    
    func shuffle( array : [AnyObject])->[AnyObject]{
        var array = array
        for i in 0..<array.count{
            let remaining = array.count-i
            let index = Int(arc4random_uniform(UInt32(remaining)))
            if i != index{
                swap(&array[i], &array[index])
            }
        }
        return array
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
