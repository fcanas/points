//
//  Node.swift
//  Points
//
//  Created by Fabian Canas on 9/3/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

import Cocoa

@objc class Node: NSObject, NSCopying {
    
    let image :NSImage? = nil
    var children :Array<Node> = []
    var isLeaf :Bool {
        get {
            return false
        }
    }
    var name :String = "Hi"
    
    var storedCost :Int = 0
    var cost :Int {
        get {
            return children.count > 0 ? reduce(children, 0) { $0 + $1.cost } : storedCost
        }
        set(newCost) {
            storedCost = newCost
        }
    }
    
    var editableCost :Bool {
        return children.count == 0
    }
    
    required override init() {
        super.init()
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        var new :Node = self.dynamicType()
        new.name = name
        new.cost = cost
        return new
    }
    
}
