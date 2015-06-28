//
//  XMLParserTbx.swift
//  Tinderbox-Aeon-Exchange
//
//  Created by prenez on 6/28/15.
//  Copyright © 2015 Michael Prenez-Isbell. All rights reserved.
//

import Foundation
import AppKit

class XMLParserTbx   {
    
    
    
    var path: String
    var data: NSData
    var items: [TbxItem]
    var tbxItems : TbxItem = TbxItem()
    var currentItem: TbxItem = TbxItem()
    
    init?(contentPath: NSURL) {
        
        self.path = contentPath.path!
        self.data = NSFileManager.defaultManager().contentsAtPath(path)!
        
        
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        self.items = (appDelegate.mainViewController?.outlineViewControllerTbx.tbxItems)!
        
        
    }
    
    
    func parse() {
        
        var error: NSError?
        
        
        if let xmlDoc = AEXMLDocument(xmlData: self.data, error: &error) {
            
            // might want to structure it
            // parse items
            // parse colors
            // parse etc
            // all the top level stuff
            // also think about making an array for each of the top level elements,
            // the easier to make key value lists with later
            
            var firstelement = xmlDoc.root["item"]
            print (xmlDoc.root["item"].stringValue)
            
            var firstitem =  xmlDoc.root["attrib"].countWithAttributes(["Name" : "Item"])
            
            xmlDoc.root["attrib"].countWithAttributes(["Name" : "Item"])
            
            // this parses every element in the document
            // this is where i build my array
            
            self.tbxItems = TbxItem(name: "root", value: "", children: [])
            for child in xmlDoc.root.children {
                if let _ = child.value {
                    print("\(child.name) >> \(child.value!)")
                    self.currentItem = TbxItem(name: child.name, value: child.value!, children: [])
                     self.tbxItems.addChild(currentItem)
                }
                else {
                    self.currentItem = TbxItem(name: child.name, value: "no value", children: [])
                    self.tbxItems.addChild(currentItem)
                }
                
                for attribute in child.attributes {
                    print("\t \(attribute.0) :: \(attribute.1) ")
                    self.currentItem.addChild(TbxItem(name: attribute.0 as! String, value: attribute.1 as! String, children: [])) // this could break
            
                }
                getChildren(child)
            }
            
        }
        
        // make accessible to outlineview
        self.items.append(tbxItems)
         let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.mainViewController?.outlineViewControllerTbx.tbxItems.append(tbxItems)
    }
    
    func getChildren(element : AEXMLElement) {
        for child in element.children {
            if let _ = child.value {
                print("\(child.name) >> \(child.value!)")
                self.currentItem = TbxItem(name: child.name, value: child.value!, children: [])
                self.tbxItems.addChild(currentItem)
            }
            else {
                self.currentItem = TbxItem(name: child.name, value: "no value", children: [])
                self.tbxItems.addChild(currentItem)
            }
            
            for attribute in child.attributes {
                print("\t \(attribute.0) :: \(attribute.1) ")
                self.currentItem.addChild(TbxItem(name: attribute.0 as! String, value: attribute.1 as! String, children: [])) // this could break
            }
            getChildren(child)
        }
        
    }
    
    
    
}

