//
//  ScrivenerItem.swift
//  Tinderbox-Aeon-Exchange
//
//  Created by prenez on 6/28/15.
//  Copyright © 2015 Michael Prenez-Isbell. All rights reserved.
//


import Foundation


class ScrivenerItem {
    
    var name : String
    var value: String
    //    var ID: String
    //    var isPrototype: Bool
    //    var aliasID:String
    //    var nextNull: Bool
    //    var hasNoteDescendants: Bool
    //    var hasNoteSiblings: Bool
    //    var parent : TbxItem?
    
    var children: Array<ScrivenerItem>
    
    
    
    //default
    init () {
        
        self.name = ""
        self.value = ""
        //            self.ID = ""
        //            self.isPrototype = false
        //            self.aliasID = ""
        //            self.nextNull = true
        //            self.hasNoteDescendants = false
        //            self.hasNoteSiblings = false
        //            self.parent = nil
        self.children = []
        
        
    }
    
    //designated
    init(name: String, value: String, children: Array<ScrivenerItem>) {
        
        
        self.name = name
        self.value = value
        self.children = []
        
    }
    
    //convenience
    // convenience init (aname: String) {
    
    //    self.init(name: aname, age: 25, children: [])
    
    
    // }
    
    func addChild(item: ScrivenerItem) -> (Void) {
        
        children.append(item)
        
    }
    
    func hasChildren() -> Bool {
        return self.children.count != 0
    }
}

