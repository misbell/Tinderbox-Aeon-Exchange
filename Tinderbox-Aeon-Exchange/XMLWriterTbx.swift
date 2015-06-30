//
//  XMLWriterTbx.swift
//  Tinderbox-Aeon-Exchange
//
//  Created by prenez on 6/30/15.
//  Copyright © 2015 Michael Prenez-Isbell. All rights reserved.
//

import Cocoa

class XMLWriterTbx  {
    
    var tbxItems : [TbxItem]
    var tbxItem : TbxItem
    
    init() {
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        self.tbxItems = (appDelegate.mainViewController?.outlineViewControllerTbx.tbxItems)!
        self.tbxItem = tbxItems[0]
    }
    
    func writeTinderboxXMLDocument() {
        
        print("one  \(self.tbxItem)")
        print("many \(self.tbxItems)")
        
        print ("name \(tbxItem.name) value \(tbxItem.value)")
        
        for child in tbxItem.children {
            
            print (" \(child.name)  \(child.value)")
            
            writeChildren(child)
            
        }
        
        
        //let attributes = [
        let rootAttribElement = AEXMLElement("Tools")
        rootAttribElement.value = ""
        rootAttribElement.addAttribute("parent", value: "anything")
        rootAttribElement.addAttribute("editable", value: "0")
        rootAttribElement.addAttribute("visibleInEditor", value: 1)
        rootAttribElement.addAttribute("default", value: "")

        
        
        
    }
    
    func writeChildren(item: TbxItem) {
        
        for child in item.children {
            
            print (" \(child.name)  \(child.value)")
            
            writeChildren(child)
            
        }
        
    }

}
