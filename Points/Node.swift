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
            return children.count == 0
        }
    }
    var name :String = "Hi"
    var note :String = "Something or other"
    
    required override init() {
        super.init()
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        var new :Node = self.dynamicType()
        new.name = name
        new.note = note
        return new
    }
    
}
