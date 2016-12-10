//
//  MDGraphNode.swift
//  MDDijkstra-swift
//
//  Created by mohamed mohamed El Dehairy on 12/10/16.
//  Copyright © 2016 mohamed El Dehairy. All rights reserved.
//

import Foundation

public protocol MDGraphNode {
    var adjacentNodesIndexes : [Int]{
        get
    }
    
    var adjacentNodesWeights : [Double]{
        get
    }
}
