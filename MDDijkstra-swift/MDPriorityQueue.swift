//
//  MDPriorityQueue.swift
//  MDDijkstra-swift
//
//  Created by mohamed mohamed El Dehairy on 12/8/16.
//  Copyright © 2016 mohamed El Dehairy. All rights reserved.
//

import UIKit

/**
    Swift implementation of a priority queue (Heap), its default implementation is a Min priority queue.
 
    Its default implementation is a Min priority queue, but by setting the customComparator block you can make a max heap on demand, i.e if customComparator instance variable is not nil it will be used instead of the default Comparable protocol implementation of the generic type.
 */
public class MDPriorityQueue<T : Comparable>: NSObject {
    
    private var array : [Any] = [Any]()
    
    public var customComparator : ((_ obj1 : T, _ obj2 : T)->ComparisonResult)?
    
    override convenience init() {
        self.init(customComparator: nil)
    }
    
    init(customComparator : ((_ obj1 : T, _ obj2 : T)->ComparisonResult)?) {
        super.init()
        array.append(NSNull())
        self.customComparator = customComparator
    }
    
    public func addItem(item : T) -> Void {
        array.append(item)
        self.floatObject(atIndex: array.count-1)
    }
    
    public func count()->Int{
        return array.count-1
    }
    
    public func peakMinItem()->T?{
        if(self.count() == 0){
            return nil
        }
        return array[1] as? T
    }
    
    public func removeMinItem()->T?{
        if self.count() == 0{
            return nil
        }
        
        if self.array.count > 2{
            // Swap min object at index 1 with last object
            swap(&self.array[1], &self.array[array.count-1])
        }
        
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
        
        // If parent is greater than child, then swap them, And recurse
        if let comparison = customComparator?(parent,child){
            if comparison == .orderedDescending {
                swap(&self.array[parentIndex], &self.array[childIndex])
                self.floatObject(atIndex: parentIndex)
            }
        }else if parent > child{
            swap(&self.array[parentIndex], &self.array[childIndex])
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
        let parent = array[atIndex] as! T
        
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

        // Sort children array
        if let comparator = customComparator{
            children = children.sorted(by: { (obj1 : T,obj2 : T)->Bool in
                return comparator(obj1,obj2) == .orderedAscending
            })
        }else{
            children = children.sorted()
        }
        
        
        // Sort children indexes array, according to the their corresponding items in tha array
        childrenIndexes = childrenIndexes.sorted(by: { (i1 :Int,i2 : Int)->Bool in
            let obj1 = array[i1] as! T
            let obj2 = array[i2] as! T
            if let comparator = customComparator{
                return comparator(obj1,obj2) == .orderedAscending
            }else {
                return obj1 < obj2
            }
        })
        
        
        // Compare parent to the minimum child
        if let comparator = customComparator {
            if comparator(parent,children[0]) == .orderedDescending{
                // If parent is greater than the minimum child, then swap and recurse
                swap(&array[atIndex], &array[childrenIndexes[0]])
                sinkObject(atIndex: childrenIndexes[0])
            }
        }else if parent > children[0] {
            // If parent is greater than the minimum child, then swap and recurse
            swap(&array[atIndex], &array[childrenIndexes[0]])
            sinkObject(atIndex: childrenIndexes[0])
        }
        
    }
    
}

extension MDPriorityQueue : Sequence, IteratorProtocol{
    public func next() -> T? {
        return self.removeMinItem()
    }
}
