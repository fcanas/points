//
//  Node.swift
//  Points
//
//  Created by Fabian Canas on 9/3/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

import Cocoa

@objc public class Node: NSObject, NSCopying, NSCoding, Equatable {
    
    public var children :Array<Node> = []
    var isLeaf :Bool {
        get {
            return false
        }
    }
    public var name :String = "-"
    
    public override class func keyPathsForValuesAffectingValueForKey(key: String) -> Set<NSObject> {
        if key == "cost" {
            return Set(["children"])
        }
        return Set<NSObject>()
    }

    var storedCost :Int = 0
    public var cost :Int {
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
    
    public required override init() {
        super.init()
    }
    
    public func copyWithZone(zone: NSZone) -> AnyObject {
        var new :Node = self.dynamicType()
        new.name = name
        new.cost = cost
        new.children = map(children, { $0.copy() as! Node })
        return new
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init()
        storedCost = aDecoder.decodeIntegerForKey("storedCost")
        name = aDecoder.decodeObjectOfClass(NSString.self, forKey: "name") as! NSString as String
        children = aDecoder.decodeObjectOfClass(NSArray.self, forKey: "children") as! NSArray as? [Node] ?? []
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(storedCost, forKey: "storedCost")
        aCoder.encodeObject(name as NSString, forKey: "name")
        aCoder.encodeObject(children as NSArray, forKey: "children")
    }
}

public func ==(lhs: Node, rhs: Node) -> Bool {
    
    if lhs.name != rhs.name {
        return false
    }
    if lhs.children.count != rhs.children.count {
        return false
    }
    
    if lhs.children.count > 1 {
        return reduce(zip(lhs.children, rhs.children), true, {(eq, cs) in eq && cs.0 == cs.1 })
    }
    
    return lhs.storedCost == rhs.storedCost
}
