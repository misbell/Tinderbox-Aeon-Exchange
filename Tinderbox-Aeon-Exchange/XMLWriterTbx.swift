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
    var tbxfileurl : NSURL
    var tbxpath: String
    var tbxdata: NSData
    
    var aeonfileurl : NSURL
    var aeonpath: String
    var aeondata: NSData
    
    
    let aeonEventAttributes = ["AeonEventNoteStatus,0,1",
        "AeonEventID,2,0",
        "AeonEventLocked,2,0",
        "AeonEventTitle,0,0",
        "AeonEventAllDay,2,0",
        "AeonEventStartDate, 0,0",
        "AeonEventDescription,0,0",
        "AeonEventIncludeInExport,2,0",
        "AeonEventLabel,0,0",
        "AeonEventArc,0,0",
        "AeonEventRelationships,10,0",
        "AeonEventTags,10,0",
        "AeonEventCompleted,2,0",
        "AeonEventDuration,2,0",
        "AeonEventDurationUnit,0,0",
        "AeonEventShowTime,0,0",
        "AeonEventShowDay,2,0",
        "AeonEventShowMonth,2,0",
        "AeonEventExternalLinks,10,0",
        "AeonEventNoteStatus,8,0" ]
    
    let basicNoteAttributes = [
        
        "Created,2015-07-02T20:39:52-04:00",
        "Modified,2015-07-02T20:39:52-04:00",
        "Name,untitled",
        "SelectionCount,1",
        "Xpos,7.92578125",
        "Ypos,5.116577148"
        
    ]
    
    var rootAttribElement: AEXMLElement = AEXMLElement("dummy")
    
    init() {
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        self.tbxItems = (appDelegate.mainViewController?.outlineViewControllerTbx.tbxItems)!
        self.tbxItem = tbxItems[0]
        
        
        // try optional chaining here on file urls, at some point
        
        // init tbx data
        if let furl = (appDelegate.mainViewController?.tbxfileURL) {
            self.tbxfileurl = furl
        }
        else {
            self.tbxfileurl = NSURL(fileURLWithPath: "") // should never happen
        }
        
        
        self.tbxpath = self.tbxfileurl.path!
        self.tbxdata = NSFileManager.defaultManager().contentsAtPath(self.tbxpath)!
        
        
        // init aeon data
        if let aeonfurl = (appDelegate.mainViewController?.aeonfileURL) {
            self.aeonfileurl = aeonfurl
        }
        else {
            self.aeonfileurl = NSURL(fileURLWithPath: "") // should never happen
        }
        
        
        self.aeonpath = self.aeonfileurl.path!
        self.aeondata = NSFileManager.defaultManager().contentsAtPath(self.aeonpath)!
        
    }
    
    func addAeonAttributesToTinderboxDoc() {
        
        var error: NSError?
        
        if let tbxXmlDoc = AEXMLDocument(xmlData: self.tbxdata, error: &error) {
            
            
            // add aeon attribs to user section of tinderbox doc
            for arrayel in tbxXmlDoc.root["attrib"]["attrib"].all! {
                if let name  = arrayel.attributes["Name"] as? String {
                    if name == "User" {
                        
                        let x = tbxXmlDoc.root["attrib"]["attrib"]
                        x.addChild(self.rootAttribElement)
                    }
                }
            }
            
            
            // add aeon attribs to user section of tinderbox doc
            var tascItem : AEXMLElement?
            for arrayel in tbxXmlDoc.root["item"]["item"].all! {
                
                
                for arraych in arrayel.children {
                    //print (arraych.attributes)
                    if let name  = arraych.attributes["name"] as? String {
                        print (name)
                        if name == "Name" { // "Aeon Timeline TASC Container" {
                            if arraych.value == "Aeon Timeline TASC Container" {
                                tascItem = tbxXmlDoc.root["item"]["item"]
                                // tascItem!.addChild(self.rootAttribElement)
                            }
                            
                        }
                    }
                }
                
                
            }
            
            if let atascItem = tascItem {
                
            }
            else {
                //make a new tascItem
                let baseItem = tbxXmlDoc.root["item"]
                let tascBaseItem = AEXMLElement("item" )
                tascBaseItem.value = " "
                // xml attributes
                tascBaseItem.addAttribute("ID", value: "1535924109") // make it real
                tascBaseItem.addAttribute("Creator", value: "prenez") // make it real
                
                
                // tinderbox attributes
                
                for tbxattribute in basicNoteAttributes {
                    let attribArray = tbxattribute.componentsSeparatedByString(",")
                    
                    let aeTascContainerTbxAttributeElement = AEXMLElement("attribute")
                    
                    aeTascContainerTbxAttributeElement.addAttribute("name", value: attribArray[0])
                    if attribArray[0] == "Name" {
                        aeTascContainerTbxAttributeElement.value = "Aeon Timeline TASC Container"
                    } else {
                        aeTascContainerTbxAttributeElement.value = attribArray[1] as String
                        print ( aeTascContainerTbxAttributeElement.value)
                    }
                    
                    
                    tascBaseItem.addChild(aeTascContainerTbxAttributeElement)
                }
                
                
                baseItem.addChild(tascBaseItem)
                
                
            }
            
            
            // now,
            
            
            
            print(tbxXmlDoc.xmlString)
            
            
        }
        
    }
    
    func writeOutTheTinderboxDocToTheDrive() {
        
    }
    
    
    func  addAeonEventElementsToTinderboxDoc() {
        
        // for every event element in aeon doc
        //     create tinderbox note element
        //     set item attributes
        //     for every aeon event attribute
        //         create attributeelement for item
        //     add item to items array
        
        
        //  when done writing the array
        //
    }
    
    func  addAeonArcElementsToTinderboxDoc() {
        
        
        
    }
    
    func  addAeonEntityElementsToTinderBoxDoc() {
        
    }
    
    
    func writeTinderboxXMLDocument() {
        
        constructAeonAttributesForTinderboxDoc()
        addAeonAttributesToTinderboxDoc()
        
        addAeonEventElementsToTinderboxDoc()
        addAeonArcElementsToTinderboxDoc()
        addAeonEntityElementsToTinderBoxDoc()
        
        
        
        writeOutTheTinderboxDocToTheDrive()
        
    }
    
    /* <attrib Name="IsPrototype"
    parent="General"
    editable="1"
    visibleInEditor="1"
    type="4"
    canInherit="0"
    default="false">
    */
    
    
    /*
    0 - string
    1 - color
    2 - number
    3 - file
    4 - boolean
    5 - date
    6 - (alias)
    7 - action
    8 - set
    9 - url
    10 - list
    */
    
    
    func constructAeonAttributesForTinderboxDoc() {
        
        var error: NSError?
        if let xmlDoc = AEXMLDocument(xmlData: self.tbxdata, error: &error) {
            
            for arrayel in xmlDoc.root["attrib"]["attrib"].all! {
                if let name  = arrayel.attributes["Name"] as? String {
                    if name == "User" {
                        self.rootAttribElement = arrayel
                        let x = xmlDoc.root["attrib"]["attrib"]
                        x.addChild(self.rootAttribElement)
                        addAeonTimelineEventAttribs(self.rootAttribElement)
                    }
                }
            }
            
            
        }
        
    }
    
    func addAeonTimelineEventAttribs(aeonEventAttribElement : AEXMLElement) {
        
        
        
        for attrib in aeonEventAttributes {
            
            let attribArray = attrib.componentsSeparatedByString(",")
            
            let aeEventAttribElement = AEXMLElement("attrib")
            
            aeEventAttribElement.addAttribute("parent", value: "User")
            aeEventAttribElement.addAttribute("Name", value: attribArray[0])
            aeEventAttribElement.addAttribute("editable", value: attribArray[2])
            aeEventAttribElement.addAttribute("visibleInEditor", value: "1")
            aeEventAttribElement.addAttribute("type", value: attribArray[1])
            aeEventAttribElement.addAttribute("default", value: "")
            
            aeonEventAttribElement.addChild(aeEventAttribElement)
            
        }
        
    }
    
    func addAeonTimelineArcAttributes(AEArcAttribElement : AEXMLElement) {
        
    }
    
    
    func addAeonTimelineEntityAttributes(AEEntityAttribElement : AEXMLElement) {
        
    }
    
    /*
    
    func writeChildren(item: TbxItem) {
    
    for child in item.children {
    
    writeChildren(child)
    
    }
    
    }
    */
}
