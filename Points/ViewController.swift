//
//  ViewController.swift
//  Points
//
//  Created by Fabian Canas on 9/3/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var treeController :NSTreeController?
    var editable :Bool = true
    
    var nodes :[Node] = []
    
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func keyDown(event :NSEvent) {
        let returnKey = event.keyCode == 36
        let keys = (r:returnKey, s:event.modifierFlags)
        switch keys {
        case let (true, m) where (m & NSEventModifierFlags.ShiftKeyMask) != nil:
            println("adding child")
            treeController?.insertChild(self)
        case let (true, m):
            println("adding node")
            treeController?.insert(self)
        default:
            println("nothing to be done")
        }
        
    }

}

