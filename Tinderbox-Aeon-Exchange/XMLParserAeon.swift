
//
//  XMLParserAeon.swift
//  Tinderbox-Aeon-Exchange
//
//  Created by prenez on 6/28/15.
//  Copyright © 2015 Michael Prenez-Isbell. All rights reserved.
//

import Foundation
import AppKit

class XMLParserAeon   {
    
    
    
    var path: String
    var data: NSData
    var items: [AeonItem]
    var aeonItems : AeonItem = AeonItem()
    
    
    init?(contentPath: NSURL) {
        
        self.path = contentPath.path!
        self.data = NSFileManager.defaultManager().contentsAtPath(path)!
        
        
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        self.items = (appDelegate.mainViewController?.outlineViewControllerAeon.aeonItems)!
        
        
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
            var currentItem : AeonItem = AeonItem()
            self.aeonItems = AeonItem(name: "root", value: "", children: [])
            for child in xmlDoc.root.children {
                if let _ = child.value {
                    print("\(child.name) >> \(child.value!)")
                    currentItem = AeonItem(name: child.name, value: child.value!, children: [])
                    self.aeonItems.addChild(currentItem)
                }
                else {
                    currentItem = AeonItem(name: child.name, value: "", children: [])
                    self.aeonItems.addChild(currentItem)
                }
                
                for attribute in child.attributes {
                    print("\t \(attribute.0) :: \(attribute.1) ")
                    currentItem.addChild(AeonItem(name: attribute.0 as! String, value: attribute.1 as! String, children: [])) // this could break
                    
                }
                getChildren(currentItem, element: child)
            }
            
        }
        
        // make accessible to outlineview
        self.items.append(aeonItems)
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.mainViewController?.outlineViewControllerAeon.aeonItems.append(aeonItems)
        appDelegate.mainViewController?.ovAeon.reloadData()
        
        
        
    }
    
    func getChildren(parentItem: AeonItem, element : AEXMLElement) {
        for child in element.children {
            var currentItem = AeonItem()
            if let _ = child.value {
                print("\(child.name) >> \(child.value!)")
                currentItem = AeonItem(name: child.name, value: child.value!, children: [])
                parentItem.addChild(currentItem)
            }
            else {
                currentItem = AeonItem(name: child.name, value: "", children: [])
                parentItem.addChild(currentItem)
            }
            
            for attribute in child.attributes {
                print("\t \(attribute.0) :: \(attribute.1) ")
                currentItem.addChild(AeonItem(name: attribute.0 as! String, value: attribute.1 as! String, children: [])) // this could break
            }
            getChildren(currentItem, element: child)
        }
        
    }
    
    
    
}

