//
//  MDTestGraphNode.swift
//  MDDijkstra-swift
//
//  Created by mohamed mohamed El Dehairy on 12/16/16.
//  Copyright © 2016 mohamed El Dehairy. All rights reserved.
//

import UIKit
import MDDijkstraSwift

class MDTestGraphNode: NSObject,MDGraphNode {
    lazy var adjacentNodesIndexes: [Int] = [Int]()
    lazy var adjacentNodesWeights: [Double] = [Double]()
}
