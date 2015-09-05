//
//  Document.swift
//  Points
//
//  Created by Fabian Canas on 9/3/15.
//  Copyright (c) 2015 Fabian Canas. All rights reserved.
//

import Cocoa

class Document: NSDocument {

    var nodes :[Node] = []
    
    override var documentEdited :Bool {
        get {
            return true
        }
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }
    
    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: "Main", bundle: nil)!
        let windowController = storyboard.instantiateControllerWithIdentifier("Document Window Controller") as! NSWindowController
        self.addWindowController(windowController)
        // set the document as the view controller's represented object
        let vc = windowController.contentViewController as? ViewController
        vc?.representedObject = self
    }

    override func dataOfType(typeName: String, error outError: NSErrorPointer) -> NSData? {
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        // outError.memory = NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        
        return NSKeyedArchiver.archivedDataWithRootObject(nodes as NSArray)
    }

    override func readFromData(data: NSData, ofType typeName: String, error outError: NSErrorPointer) -> Bool {
        if let n = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [Node] {
            nodes = n
            return true
        }
        
        outError.memory = NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        return false
    }


}

