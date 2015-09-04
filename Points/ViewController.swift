//
//  ViewController.swift
//  Points
//
//  Created by Fabian Canas on 9/3/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

import Cocoa

enum KeyCommand : UInt16 {
    case Return      = 36
    case Delete      = 51
    case N           = 45
    case P           = 35
    case SingleQuote = 39
    case SemiColon = 41
}

class ViewController: NSViewController {

    @IBOutlet var treeController :NSTreeController?
    @IBOutlet var outlineView :NSOutlineView?
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
        case let (c, m) where c == .SemiColon:
            treeController?.insertChild(self)
        case let (c, m) where c == .SingleQuote:
            treeController?.insert(self)
        case let (c, m) where c == .Return:
            println("Can we edit?")
        case let (c, m) where c == .Delete:
            treeController?.remove(self)
        case let (c, m) where c == .N && (m & NSEventModifierFlags.ControlKeyMask) != nil:
            if let selectedRow = outlineView?.selectedRow {
                outlineView?.selectRowIndexes(NSIndexSet(index: selectedRow + 1), byExtendingSelection: false)
            }
        case let (c, m) where c == .P && (m & NSEventModifierFlags.ControlKeyMask) != nil:
            if let selectedRow = outlineView?.selectedRow {
                outlineView?.selectRowIndexes(NSIndexSet(index: selectedRow - 1), byExtendingSelection: false)
            }
        default:
            println("nothing to be done? \(event.keyCode) + \(event.modifierFlags)")
        }
        
    }

}

