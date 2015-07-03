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
    var fileurl : NSURL
    var path: String
    var data: NSData
    
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
    
    var rootAttribElement: AEXMLElement = AEXMLElement("dummy")
    
    init() {
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        self.tbxItems = (appDelegate.mainViewController?.outlineViewControllerTbx.tbxItems)!
        self.tbxItem = tbxItems[0]
        if let furl = (appDelegate.mainViewController?.fileURL) {
            self.fileurl = furl
        }
        else {
            self.fileurl = NSURL(fileURLWithPath: "") // should never happen
        }
        
        
        self.path = self.fileurl.path!
        self.data = NSFileManager.defaultManager().contentsAtPath(path)!
        
    }
    
    func addToolsAeonAttributesToTinderboxDoc() {
        
        var error: NSError?
        
        if let xmlDoc = AEXMLDocument(xmlData: self.data, error: &error) {
            
            for arrayel in xmlDoc.root["attrib"]["attrib"].all! {
                if let name  = arrayel.attributes["Name"] as? String {
                    if name == "User" {
                        
                        let x = xmlDoc.root["attrib"]["attrib"]
                        x.addChild(self.rootAttribElement)
                    }
                }
            }


          print(xmlDoc.xmlString)
            
       
        }
        
    }
    
    func writeOutTheTinderboxDocToTheDrive() {
        
    }
    
    func writeTinderboxXMLDocument() {
        
       constructToolsAeonAttributesForTinderboxDoc()
       addToolsAeonAttributesToTinderboxDoc()
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
    
    
    func constructToolsAeonAttributesForTinderboxDoc() {

                var error: NSError?
        if let xmlDoc = AEXMLDocument(xmlData: self.data, error: &error) {
            
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
    
    
    func writeChildren(item: TbxItem) {
        
        for child in item.children {
            
            writeChildren(child)
            
        }
        
    }
    
}
