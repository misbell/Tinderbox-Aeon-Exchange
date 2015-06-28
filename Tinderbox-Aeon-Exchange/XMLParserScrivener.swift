//
//  XMLParserScrivener.swift
//  Tinderbox-Aeon-Exchange
//
//  Created by prenez on 6/28/15.
//  Copyright © 2015 Michael Prenez-Isbell. All rights reserved.
//



import Foundation
import AppKit

class XMLParserScrivener  {
    
    
    
    var path: String
    var data: NSData
    var items: [ScrivenerItem]
    var scrivenerItems : ScrivenerItem = ScrivenerItem()
    
    
    init?(contentPath: NSURL) {
        
        self.path = contentPath.path!
        self.data = NSFileManager.defaultManager().contentsAtPath(path)!
        
        
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        self.items = (appDelegate.mainViewController?.outlineViewControllerScrivener.scrivenerItems)!
        
        
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
            var currentItem : ScrivenerItem = ScrivenerItem()
            self.scrivenerItems = ScrivenerItem(name: "root", value: "", children: [])
            for child in xmlDoc.root.children {
                if let _ = child.value {
                    print("\(child.name) >> \(child.value!)")
                    currentItem = ScrivenerItem(name: child.name, value: child.value!, children: [])
                    self.scrivenerItems.addChild(currentItem)
                }
                else {
                    currentItem = ScrivenerItem(name: child.name, value: "", children: [])
                    self.scrivenerItems.addChild(currentItem)
                }
                
                for attribute in child.attributes {
                    print("\t \(attribute.0) :: \(attribute.1) ")
                    currentItem.addChild(ScrivenerItem(name: attribute.0 as! String, value: attribute.1 as! String, children: [])) // this could break
                    
                }
                getChildren(currentItem, element: child)
            }
            
        }
        
        // make accessible to outlineview
        self.items.append(scrivenerItems)
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.mainViewController?.outlineViewControllerScrivener.scrivenerItems.append(scrivenerItems)
        appDelegate.mainViewController?.ovScrivener.reloadData()
        
        
        
    }
    
    func getChildren(parentItem: ScrivenerItem, element : AEXMLElement) {
        for child in element.children {
            var currentItem = ScrivenerItem()
            if let _ = child.value {
                print("\(child.name) >> \(child.value!)")
                currentItem = ScrivenerItem(name: child.name, value: child.value!, children: [])
                parentItem.addChild(currentItem)
            }
            else {
                currentItem = ScrivenerItem(name: child.name, value: "", children: [])
                parentItem.addChild(currentItem)
            }
            
            for attribute in child.attributes {
                print("\t \(attribute.0) :: \(attribute.1) ")
                currentItem.addChild(ScrivenerItem(name: attribute.0 as! String, value: attribute.1 as! String, children: [])) // this could break
            }
            getChildren(currentItem, element: child)
        }
        
    }
    
    
    
}

