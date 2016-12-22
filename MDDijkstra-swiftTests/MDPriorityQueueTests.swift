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
    
    
    func testMaxHeap(){
        let queue = MDPriorityQueue<Int>()
        queue.customComparator = {(i1 : Int,i2 : Int)->ComparisonResult in
            if i1 > i2 {
                return .orderedAscending
            }else if i2 > i1 {
                return .orderedDescending
            }else {
                return .orderedSame
            }
        }
        
        let array = generateRandomlyShuffledArray()
        
        for i in array{
            queue.addItem(item: i)
        }
        
        var i = 599
        for max in queue{
            XCTAssertTrue(max == i)
            i-=1
        }
    }
    
    func testAddObject() {
        let queue = MDPriorityQueue<Int>()
        
        let array = generateRandomlyShuffledArray()
        
        for i in array{
            queue.addItem(item: i)
        }
        
        var i = 0
        for min in queue{
            XCTAssertTrue(min == i)
            i+=1
        }
    }
    
    func generateRandomlyShuffledArray()->[Int]{
        var array = [Int]()
        for i in 0 ..< 600{
            array.append(i)
        }
        
        return shuffle(array: array) as! [Int]
    }
    
    func shuffle( array : [Any])->[Any]{
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
