//
//  MDDijkstraTests.swift
//  MDDijkstra-swift
//
//  Created by mohamed mohamed El Dehairy on 12/12/16.
//  Copyright © 2016 mohamed El Dehairy. All rights reserved.
//

import XCTest
import MDDijkstraSwift

class MDDijkstraTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFindFastestPath() {
        let node0 = MDTestGraphNode()
        let node1 = MDTestGraphNode()
        let node2 = MDTestGraphNode()
        let node3 = MDTestGraphNode()
        
        let graph = [node0,node1,node2,node3]
        
        node0.adjacentNodesIndexes = [1,3]
        node0.adjacentNodesWeights = [10,5]
        
        node1.adjacentNodesIndexes = [2]
        node1.adjacentNodesWeights = [5]
        
        node2.adjacentNodesIndexes = [3]
        node2.adjacentNodesWeights = [10]
        
        node3.adjacentNodesIndexes = [1]
        node3.adjacentNodesWeights = [0.0]
        
        let dijkstra = MDDijkstra(graph : graph)
        
        let routeHead = dijkstra.findFastestPathBetween(startIndex: 0, endIndex: 3)
        
        XCTAssertTrue(routeHead?.graphNodeIndex == 0)
        XCTAssertTrue(routeHead?.nextNode?.graphNodeIndex == 3)
        XCTAssertTrue(routeHead?.nextNode?.weight == 5)
        
    }
    
    func testNoRoute(){
        let node0 = MDTestGraphNode()
        let node1 = MDTestGraphNode()
        let node2 = MDTestGraphNode()
        let node3 = MDTestGraphNode()
        
        let graph = [node0,node1,node2,node3]
        
        node0.adjacentNodesIndexes = [1]
        node0.adjacentNodesWeights = [10]
        
        node1.adjacentNodesIndexes = [2]
        node1.adjacentNodesWeights = [5]
        
        let dijkstra = MDDijkstra(graph : graph)
        
        let routeHead = dijkstra.findFastestPathBetween(startIndex: 0, endIndex: 3)
        
        XCTAssertNil(routeHead)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
