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
    
    var itemIDNumbers : [Int64] = []
    
    var appDelegate : AppDelegate?
    
 //   var highestTbxNoteID : Int64 = 0
    
    
    init?(contentPath: NSURL) {
        
        self.path = contentPath.path!
        self.data = NSFileManager.defaultManager().contentsAtPath(path)!

        
        self.appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        self.items = (self.appDelegate!.mainViewController?.outlineViewControllerTbx.tbxItems)!
        
        
    }
    
    
    func parse() {
        
        var error: NSError?
        
        
        if let xmlDoc = AEXMLDocument(xmlData: self.data, error: &error ) {
            
            // might want to structure it
            // parse items
            // parse colors
            // parse etc
            // all the top level stuff
            // also think about making an array for each of the top level elements,
            // the easier to make key value lists with later
            
           // var firstelement = xmlDoc.root["item"]
           // print (xmlDoc.root[xmldoc "item"].stringValue)
            
           // var firstitem =  xmlDoc.root["attrib"].countWithAttributes(["Name" : "Item"])
            
           // xmlDoc.root["attrib"].countWithAttributes(["Name" : "Item"])
            
            // this parses every element in the document
            // this is where i build my array
            var currentItem = TbxItem(name: (xmlDoc.root.first?.name)!, value: "", children: [])
            self.tbxItems = currentItem
            for attribute in xmlDoc.root.attributes {
                currentItem.addChild(TbxItem(name: attribute.0 as! String, value: attribute.1 as! String, children: [])) // this could break
            }
            
            for child in xmlDoc.root.children {
                if let _ = child.value {
                 //   print("\(child.name) and \(child.value!)")
                    currentItem = TbxItem(name: child.name, value: child.value!, children: [])
                    self.tbxItems.addChild(currentItem)
                }
                else {
                            //print("\(child.name) and NO VALUE NO VALUE NO VALUE )")
                    currentItem = TbxItem(name: child.name, value: "", children: [])
                    self.tbxItems.addChild(currentItem)
                }
                
                for attribute in child.attributes {
                    
                    if currentItem.name == "item" {
                        if attribute.0 == "ID" {

                            let x = Int64(attribute.1 as! String)
                            self.itemIDNumbers.append(x!)
                        }
                    }
                    
                    currentItem.addChild(TbxItem(name: attribute.0 as! String, value: attribute.1 as! String, children: [])) // this could break
                    
                }
                getChildren(currentItem, element: child)
            }
            
        }
        
        let sortedItemIDNumbers =  itemIDNumbers.sort()
        let lowest = sortedItemIDNumbers.first
        self.appDelegate!.mainViewController?.highestTinderboxNoteID = sortedItemIDNumbers.last!
        
       
        
        // make accessible to outlineview
        self.items.append(tbxItems)
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.mainViewController?.outlineViewControllerTbx.tbxItems.append(tbxItems)
        appDelegate.mainViewController?.ovTinderbox.reloadData()
        
        
        
    }
    
    func getChildren(parentItem: TbxItem, element : AEXMLElement) {
        var currentItem = TbxItem()
        for child in element.children {
            
            if let _ = child.value {
           //      print("\(child.name) and \(child.value!)")
                currentItem = TbxItem(name: child.name, value: child.value!, children: [])
                parentItem.addChild(currentItem)
            }
            else {
               // print("\(child.name) and NO VALUE  )")
                currentItem = TbxItem(name: child.name, value: "", children: [])
                parentItem.addChild(currentItem)
                
                
            }
            
            for attribute in child.attributes {
                if currentItem.name == "item" {
                    if attribute.0 == "ID" {

                        let x = Int64(attribute.1 as! String)
                        self.itemIDNumbers.append(x!)
                    }
                }
                
                currentItem.addChild(TbxItem(name: attribute.0 as! String, value: attribute.1 as! String, children: [])) // this could break
            }
            getChildren(currentItem, element: child)
        }
        
    }
    
    
    
}

