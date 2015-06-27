//
//  OutlineViewController.swift
//  Tinderbox-Aeon-Exchange
//
//  Created by prenez on 6/27/15.
//  Copyright © 2015 Michael Prenez-Isbell. All rights reserved.
//

import Foundation
import AppKit


class OutlineViewController  : NSObject {
    var people: Array<Person> = []
    
    // designated
    override init() {
        super.init()
        let boss = Person(name: "yoda", age: 900, children: [])
        boss.addChild(Person(name:"stephan", age: 25, children:[]))
        boss.addChild(Person(name:"kara", age: 19, children:[]))
        boss.addChild(Person(name:"jesse", age: 18, children:[]))
        
        let p = (boss.children)[0]
        p.addChild(Person(name:"sue", age: 18, children:[]))
        
        let pp = (boss.children)[1]
        
        
        pp.addChild(Person(name:"adam", age: 21, children:[]))
        
        // add all this to the array property
        // this will be our datasource for the treeview
        self.people.append(boss)
    }
    
    
}

extension OutlineViewController: NSOutlineViewDataSource {
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        
        return (item == nil) ? self.people.count : (item as! Person).children.count
        
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        
        // if item is nil, this will break
        
        return (item as! Person).children.count != 0

    }
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        
        return (item == nil) ? self.people[index] : Person()

        
    }
    
    func outlineView(outlineView: NSOutlineView, objectValueForTableColumn tableColumn: NSTableColumn?, byItem item: AnyObject?) -> AnyObject? {
        
        // heres where we decide which properties on object we want to display
        // to do this have to set the identifier on the column for the outlinevie
        // in interfacebuilder
        
        if tableColumn?.identifier == "name" {
            return (item as! Person).name
            
        }
        
        if tableColumn?.identifier == "age" {
            return (item as! Person).age as NSNumber
            
        }
        
        return "something is wrong";
        
    }
    
    
}

extension OutlineViewController: NSOutlineViewDelegate {
    
}

