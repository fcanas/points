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
    var cost :Int = 0
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
