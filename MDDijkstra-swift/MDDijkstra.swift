//
//  MDDijkstra.swift
//  MDDijkstra-swift
//
//  Created by mohamed mohamed El Dehairy on 12/10/16.
//  Copyright © 2016 mohamed El Dehairy. All rights reserved.
//

import UIKit

public class MDDijkstra: NSObject {
    private let graph : [MDGraphNode]
    
    init(graph : [MDGraphNode]) {
        self.graph = graph
        super.init()
    }
    
    public func findFastestPathBetween(startIndex : Int,endIndex : Int)->MDRouteNode?{
        
        // Validate the statIndex
        if startIndex <= 0 || startIndex >= graph.count{
            return nil
        }
        
        // Validate the endIndex
        if endIndex <= 0 || endIndex >= graph.count{
            return nil
        }
        
        // Declare the priority queue
        let queue = MDPriorityQueue<MDRouteNode>(comparatorBlock: {(node1 : MDRouteNode,node2 : MDRouteNode)->ComparisonResult in
            if node1.weight > node2.weight {
                return .orderedAscending
            }else if node1.weight < node2.weight{
                return .orderedDescending
            }else{
                return .orderedSame
            }
        })
        
        // Add the start node to the queue
        let startRouteNode = MDRouteNode(graphNodeIndex: startIndex, weight: 0.0)
        queue.addObject(obj: startRouteNode)
        
        // The result route node
        var resultRouteNode : MDRouteNode?
        
        while queue.count() != 0 {
            
            // Get the minimum weight route node
            let routeNode = queue.removeMinObject()!
            
            
            // Make sure not to go in loops
            if routeNode.visited {
                continue
            }
            
            // Check if we are already at our destination
            if routeNode.graphNodeIndex == endIndex{
                resultRouteNode = routeNode
                break
            }
            
            // Set the node as visited to prevent going in loops
            routeNode.visited = true
            
            // Unwrap the graph node
            let graphNode = graph[routeNode.graphNodeIndex]
            
            // wrap the current graph node adjacent nodes inside MDRouteNodes and add them to the priority queue
            for i in 0..<graphNode.adjacentNodesIndexes.count{
                let adjacentGraphNodeIndex = graphNode.adjacentNodesIndexes[i]
                let weight = graphNode.adjacentNodesWeights[i]
                
                let adjacentRouteNode = MDRouteNode(graphNodeIndex: adjacentGraphNodeIndex, weight: routeNode.weight+weight)
                adjacentRouteNode.nextNode! = routeNode as! MDGraphNode
                queue.addObject(obj: adjacentRouteNode)
            }
        }
        
        return resultRouteNode
    }
}
