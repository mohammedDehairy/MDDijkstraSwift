//
//  MDRouteNode.swift
//  MDDijkstra-swift
//
//  Created by mohamed mohamed El Dehairy on 12/10/16.
//  Copyright © 2016 mohamed El Dehairy. All rights reserved.
//

import UIKit

public class MDRouteNode: NSObject {
    public let graphNodeIndex : Int
    public let weight : Double
    public var nextNode : MDRouteNode?
    internal var visited = false
    
    init(graphNodeIndex : Int,weight : Double) {
        self.graphNodeIndex = graphNodeIndex
        self.weight = weight
        super.init()
    }
}

extension MDRouteNode : Comparable{
    public static func <(lhs : MDRouteNode, rhs : MDRouteNode)->Bool{
        return lhs.weight < rhs.weight
    }
    
    public static func ==(lhs : MDRouteNode, rhs : MDRouteNode)->Bool{
        return lhs.weight == rhs.weight
    }
}
