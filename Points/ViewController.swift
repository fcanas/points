//
//  ViewController.swift
//  Points
//
//  Created by Fabian Canas on 9/3/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

import Cocoa

enum KeyCommand : UInt16 {
    case Return = 36
    case Delete = 51
}

class ViewController: NSViewController {

    @IBOutlet var treeController :NSTreeController?
    var editable :Bool = true
    
    var nodes :[Node] = [] {
        didSet {
            if oldValue != nodes {
                representedObject = nodes
            }
        }
    }
    
    override var representedObject: AnyObject? {
        didSet {
            if let n = representedObject as? [Node] {
                nodes = n
            }
        }
    }
    
    override func keyDown(event :NSEvent) {
        let command = KeyCommand(rawValue: event.keyCode)
        let keys = (r:command, s:event.modifierFlags)
        switch keys {
        case let (c, m) where (m & NSEventModifierFlags.CommandKeyMask) != nil && c == .Return:
            treeController?.insertChild(self)
        case let (c, m) where (m & NSEventModifierFlags.ShiftKeyMask) != nil && c == .Return:
            treeController?.insert(self)
        case let (c, m) where c == .Return:
            println("Can we edit?")
        case let (c, m) where c == .Delete:
            println("delete")
            treeController?.remove(self)
        default:
            println("nothing to be done? \(event.keyCode)")
        }
        
    }

}

