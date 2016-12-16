//
//  MDDijkstra.swift
//  MDDijkstra-swift
//
//  Created by mohamed mohamed El Dehairy on 12/10/16.
//  Copyright © 2016 mohamed El Dehairy. All rights reserved.
//

import UIKit

/**
   Swift implementation of Dijkstra shortest path algorithm
 */
public class MDDijkstra: NSObject {
    private let graph : [MDGraphNode]
    
    /**
       The Designated initializer
     
       - Parameter graph : Array of objects of any type that conforms to MDGraphNode protocol
    */
    public init(graph : [MDGraphNode]) {
        self.graph = graph
        super.init()
    }
    
    /**
        Finds the fastest path between two graph nodes in the graph passed on initialization, the start and end graph nodes are referred to by index in the graph array
        
        - Parameter startIndex : the index of the start node
        - Parameter endIndex   : the index of the end node
        - returns : MDRouteNode object that wraps the start graph node, and links all the way to the end MDRouteNode (wraping the end graph node), in a linked list fashion
    */
    public func findFastestPathBetween(startIndex : Int,endIndex : Int)->MDRouteNode?{
        
        // Validate the statIndex
        if startIndex < 0 || startIndex >= graph.count{
            return nil
        }
        
        // Validate the endIndex
        if endIndex < 0 || endIndex >= graph.count{
            return nil
        }
        
        // Declare the priority queue
        let queue = MDPriorityQueue<MDRouteNode>(comparatorBlock: {(node1 : MDRouteNode,node2 : MDRouteNode)->ComparisonResult in
            if node1.weight > node2.weight {
                return .orderedDescending
            }else if node1.weight < node2.weight{
                return .orderedAscending
            }else{
                return .orderedSame
            }
        })
        
        // Add the start node to the queue
        let startRouteNode = MDRouteNode(graphNodeIndex: startIndex, weight: 0.0)
        queue.addItem(item: startRouteNode)
        
        // The result route node
        var resultRouteNode : MDRouteNode?
        
        while queue.count() != 0 {
            
            // Get the minimum weight route node
            let routeNode = queue.removeMinItem()!
            
            
            // Make sure not to go in loops
            if routeNode.visited {
                continue
            }
            
            // Set the node as visited to prevent going in loops
            routeNode.visited = true
            
            // Check if we are already at our destination
            if routeNode.graphNodeIndex == endIndex{
                resultRouteNode = routeNode
                break
            }
            
            // Unwrap the graph node
            let graphNode = graph[routeNode.graphNodeIndex]
            
            // wrap the current graph node adjacent nodes inside MDRouteNodes and add them to the priority queue
            for i in 0..<graphNode.adjacentNodesIndexes.count{
                let adjacentGraphNodeIndex = graphNode.adjacentNodesIndexes[i]
                let weight = graphNode.adjacentNodesWeights[i]
                
                let adjacentRouteNode = MDRouteNode(graphNodeIndex: adjacentGraphNodeIndex, weight: routeNode.weight+weight)
                adjacentRouteNode.nextNode = routeNode
                queue.addItem(item: adjacentRouteNode)
            }
        }
        
        return self.reverseRoute(routeNode: resultRouteNode)
    }
    
    private func reverseRoute(routeNode : MDRouteNode?)->MDRouteNode?{
        var head = routeNode?.nextNode
        var preNode = routeNode
        preNode?.nextNode = nil
        while(head != nil){
            let next = head?.nextNode
            head?.nextNode = preNode
            preNode = head
            head = next
        }
        return preNode
    }
}
