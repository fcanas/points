//
//  NodeTest.swift
//  Points
//
//  Created by Fabian Canas on 9/5/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

import Cocoa
import XCTest
import Points

class NodeTest: XCTestCase {

    var node :Node = Node()
    
    override func setUp() {
        super.setUp()
        node = Node()
        node.name = "Node Name"
        node.cost = 3
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testEquatable() {
        let node2 = node.copy() as! Node
        
        XCTAssert(node == node2, "Two equivalent nodes should be equal")
        
        node2.name = "Different Name"
        XCTAssert(node != node2, "Nodes with different names should not be equal")
        node2.name = node.name
        
        node2.cost = 10
        XCTAssert(node != node2, "Nodes with different costs should not be equal")
        node2.cost = node.cost
    }
    
    func testCopyingEquatable() {
        let node2 = node.copy() as! Node
        XCTAssert(node == node2, "A copied node should be equal to the original")
        
        node2.cost += 1
        XCTAssert(node != node2, "A copied node should be a distinct instance")
    }
    
    func testChildren() {
        var (c1, c2, c3) = (Node(), Node(), Node())
        c1.name = "Child 1"
        c1.cost = 1
        
        c2.name = "Child 2"
        c2.cost = 2
        
        c3.name = "Child 3"
        c3.cost = 3
        
        node.children = [c1, c2, c3]
        XCTAssertEqual(node.cost, reduce(node.children, 0, {(u, c) in u + c.cost}), "A node's cost should be equal to the cost of its children")
        
        var node2 = node.copy() as! Node
        XCTAssert(node == node2, "Two equivalent nodes should be equal, even if they have children")
        
        node2.children[1].cost = 100
        
        XCTAssert(node != node2, "Two otherwise equal nodes with different children should not be equal")
    }
    
    func testArchiving() {
        let data = NSKeyedArchiver.archivedDataWithRootObject(node)
        let node2 = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Node
        XCTAssert(node == node2, "Archiving and unarchiving should result in equivalent Nodes")
    }
}
