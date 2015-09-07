//
//  Node.swift
//  Points
//
//  Created by Fabian Canas on 9/3/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

import Cocoa

@objc public class Node: NSObject, NSCopying, NSCoding {
    
    public var children :Array<Node> = []
    var isLeaf :Bool {
        get {
            return false
        }
    }
    public var name :String = "-"
    
    public override class func keyPathsForValuesAffectingValueForKey(key: String) -> Set<String> {
        if key == "cost" {
            return Set(["children"])
        }
        return Set<NSObject>()
    }

    var storedCost :Int = 0
    public var cost :Int {
        get {
            return children.count > 0 ? children.reduce(0) { $0 + $1.cost } : storedCost
        }
        set(newCost) {
            storedCost = newCost
        }
    }
    
    public required override init() {
        super.init()
    }
    
    public func copyWithZone(zone: NSZone) -> AnyObject {
        let new :Node = self.dynamicType.init()
        new.name = name
        new.cost = cost
        new.children = children.map({ $0.copy() as! Node })
        return new
    }
    
    public required init?(coder aDecoder: NSCoder) {
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

extension Node :Equatable {}

public func ==(lhs: Node, rhs: Node) -> Bool {
    
    if lhs.name != rhs.name || lhs.children.count != rhs.children.count {
        return false
    }
    if lhs.children.count > 1 {
        return zip(lhs.children, rhs.children).reduce(true, combine: {(eq, cs) in eq && cs.0 == cs.1 })
    }
    
    return lhs.storedCost == rhs.storedCost
}
