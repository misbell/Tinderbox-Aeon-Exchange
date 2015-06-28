//
//  XMLParserTbx.swift
//  Tinderbox-Aeon-Exchange
//
//  Created by prenez on 6/28/15.
//  Copyright © 2015 Michael Prenez-Isbell. All rights reserved.
//

import Foundation

class XMLParserTbx   {
    
    var path: String
    var data: NSData
    
    init?(contentPath: NSURL) {
   
         self.path = contentPath.path!
         self.data = NSFileManager.defaultManager().contentsAtPath(path)!
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
            
            for child in xmlDoc.root.children {
                if let _ = child.value {
                    print("\(child.name) >> \(child.value!)")
                }
                else {
                    print("\(child.name) >> no value")
                }
                
                
                
                for attribute in child.attributes {
                    print("\t \(attribute.0) :: \(attribute.1) ")
                }
                getChildren(child)
            }
            
        }
        
    }
    
    func getChildren(element : AEXMLElement) {
        for child in element.children {
            if let _ = child.value {
                print("\(child.name) >> \(child.value!)")
            }
            else {
                print("\(child.name) >> no value")
            }
            
            for attribute in child.attributes {
                print("\t \(attribute.0) :: \(attribute.1) ")
            }
            getChildren(child)
        }
        
    }
    
    
    
}

