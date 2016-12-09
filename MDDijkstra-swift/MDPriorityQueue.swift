//
//  MDPriorityQueue.swift
//  MDDijkstra-swift
//
//  Created by mohamed mohamed El Dehairy on 12/8/16.
//  Copyright © 2016 mohamed El Dehairy. All rights reserved.
//

import UIKit

class MDPriorityQueue<T : AnyObject>: NSObject {
    lazy var array : [AnyObject] = [AnyObject]()
    
    let comparatorBlock : (_ obj1 : T,_ obj2 : T)->(ComparisonResult)
    
    init(comparatorBlock : @escaping (_ obj1 : T,_ obj2 : T)->(ComparisonResult)) {
        self.comparatorBlock = comparatorBlock
        super.init()
        array.append(NSNull())
        
    }
    
    public func addObject(obj : T) -> Void {
        array.append(obj)
        self.floatObject(atIndex: array.count-1)
    }
    
    public func count()->Int{
        return array.count-1
    }
    
    public func peakMinObject()->T?{
        if(self.count() == 0){
            return nil
        }
        return array[1] as? T
    }
    
    public func removeMinObject()->T?{
        if self.count() == 0{
            return nil
        }
        
        var iArray = self.array
        
        // Swap min object at index 1 with last object
        swap(&iArray[1], &iArray[array.count-1])
        
        // remove last object (min object)
        let minObject = self.array.removeLast()
        
        // sink object at index 1, to put it in the right place in the heap
        sinkObject(atIndex: 1)
        
        return minObject as? T
    }
    
    private func floatObject(atIndex : Int) -> Void {
        
        if(atIndex <= 1){
            return
        }
        
        if(atIndex >= array.count){
            return
        }
        
        // Parent and child indexes
        let parentIndex = atIndex/2
        let childIndex = atIndex
        
        // Parent item
        let parent = array[parentIndex] as! T
        
        // Child item
        let child = array[childIndex] as! T
        
        // Compare child and parent
        let comparison = self.comparatorBlock(parent,child)
        
        
        // If parent is greater than child, then swap them, And recurse
        if(comparison == ComparisonResult.orderedDescending){
            var iArray = array
            swap(&iArray[parentIndex], &iArray[childIndex])
            self.floatObject(atIndex: parentIndex)
        }
    }
    
    private func sinkObject(atIndex : Int) -> Void{
        if(atIndex >= array.count-1){
            return
        }
        
        if(atIndex <= 0){
            return
        }
        
        // Parent item
        let parent = array[atIndex] as? T
        
        // Left and Right children
        let leftChildIndex = atIndex * 2
        let rightChildIndex = atIndex * 2 + 1
        
        // Children array, and children indexes array
        var children : [T] = [T]()
        var childrenIndexes : [Int] = [Int]()
        
        // Add the left child/index to the children/indexes array if any
        if leftChildIndex <= array.count-1{
            children.append(array[leftChildIndex] as! T)
            childrenIndexes.append(leftChildIndex)
        }
        
        // Add the right child/index to children/indexes array if any
        if rightChildIndex <= array.count-1{
            children.append(array[rightChildIndex] as! T)
            childrenIndexes.append(rightChildIndex)
        }
        
        // If no children found, then the current item can't sink any more, then return
        if children.count == 0 {
            return
        }

        // Sort children array, according to the self.comparatorBlock closure
        children = children.sorted(by: { (obj1 :AnyObject,obj2 : AnyObject)->Bool in
        
            return comparatorBlock(obj1 as! T,obj2 as! T) == .orderedDescending
        })
        
        // Sort children indexes array, according to the self.comparatorBlock closure
        childrenIndexes = childrenIndexes.sorted(by: { (i1 :Int,i2 : Int)->Bool in
            let obj1 = array[i1]
            let obj2 = array[i2]
            return comparatorBlock(obj1 as! T,obj2 as! T) == .orderedDescending
        })
        
        
        // Compare parent to the minimum child
        if comparatorBlock(parent!,children[0]) == .orderedDescending{
            // If parent is greater than the minimum child, then swap and recurse
            var iArray = array
            swap(&iArray[atIndex], &iArray[childrenIndexes[0]])
            sinkObject(atIndex: childrenIndexes[0])
        }else if children.count == 2{
            // If parent is less than the minimum child, but greater than the max child, then swap with the max child and recurse 
            if comparatorBlock(parent!,children[1]) == .orderedDescending{
                var iArray = array
                swap(&iArray[atIndex], &iArray[childrenIndexes[1]])
                sinkObject(atIndex: childrenIndexes[1])
            }
        }
        
    }
    
}
