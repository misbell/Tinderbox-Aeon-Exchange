
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
    
    var eventIDNumbers : [Int64] = []
    
    
    
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
            
            var currentItem = AeonItem(name: (xmlDoc.root.first?.name)!, value: "", children: [])
            self.aeonItems = currentItem
            for attribute in xmlDoc.root.attributes {
                currentItem.addChild(AeonItem(name: attribute.0 as! String, value: attribute.1 as! String, children: [])) // this could break
            }
            
            for child in xmlDoc.root.children {
                if let _ = child.value {
                    currentItem = AeonItem(name: child.name, value: child.value!, children: [])
                    self.aeonItems.addChild(currentItem)
                }
                else {
                    currentItem = AeonItem(name: child.name, value: "", children: [])
                    self.aeonItems.addChild(currentItem)
                }
                
                for attribute in child.attributes {
                    if currentItem.name == "Event" {
                        if attribute.0 == "ID" {

                            let x = Int64(attribute.1 as! String)
                            self.eventIDNumbers.append(x!)
                        }
                    }
                    
                    currentItem.addChild(AeonItem(name: attribute.0 as! String, value: attribute.1 as! String, children: [])) // this could break
                    
                }
                getChildren(currentItem, element: child)
            }
            
        }
        
        let sortedEventIDNumbers =  eventIDNumbers.sort()
        let lowest = sortedEventIDNumbers.first
        let highest = sortedEventIDNumbers.last
        
     //   print(" lowest is \(lowest) and highest is \(highest)")
        
        
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
                currentItem = AeonItem(name: child.name, value: child.value!, children: [])
                parentItem.addChild(currentItem)
            }
            else {
                currentItem = AeonItem(name: child.name, value: "", children: [])
                parentItem.addChild(currentItem)
            }
            
            for attribute in child.attributes {
                if currentItem.name == "Event" {
                    if attribute.0 == "ID" {

                        let x = Int64(attribute.1 as! String)
                        self.eventIDNumbers.append(x!)
                    }
                }
                currentItem.addChild(AeonItem(name: attribute.0 as! String, value: attribute.1 as! String, children: [])) // this could break
            }
            getChildren(currentItem, element: child)
        }
        
    }
    
    
    
}

