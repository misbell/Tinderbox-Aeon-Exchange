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
            
            
            let el = xmlDoc.root["attrib"]["attrib"].attributes["Name"]!
            if el as! String == "System" {
                let x = xmlDoc.root["attrib"]["attrib"]
                x.addChild(self.rootAttribElement)
                
            }
            
            print(xmlDoc.rawXmlString)
            
       
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
        

        
       // self.rootAttribElement = AEXMLElement("Tools") // like system and user
       // self.rootAttribElement.value = ""
       // self.rootAttribElement.addAttribute("editable", value: "0")
       // self.rootAttribElement.addAttribute("visibleInEditor", value: 1)
       // self.rootAttribElement.addAttribute("default", value: "")
        
        let groupAttribElement = AEXMLElement("AeonTimeline")
        groupAttribElement.addAttribute("parent", value: "Tools")
        groupAttribElement.addAttribute("editable", value: "0")
        groupAttribElement.addAttribute("visibleInEditor", value: 1)
        groupAttribElement.addAttribute("default", value: "")
        
        let AEEventAttribElement = AEXMLElement("AeonTimelineEvent")
        AEEventAttribElement.addAttribute("parent", value: "AeonTimeline")
        AEEventAttribElement.addAttribute("editable", value: "0")
        AEEventAttribElement.addAttribute("visibleInEditor", value: 1)
        AEEventAttribElement.addAttribute("default", value: "")
        
        
        addAeonTimelineEventAttribs(AEEventAttribElement)
        
        
        let AEArcAttribElement = AEXMLElement("AeonTimelineArc")
        AEArcAttribElement.addAttribute("parent", value: "AeonTimeline")
        AEArcAttribElement.addAttribute("editable", value: "0")
        AEArcAttribElement.addAttribute("visibleInEditor", value: 1)
        AEArcAttribElement.addAttribute("default", value: "")
        
        let AEEntityAttribElement = AEXMLElement("AeonTimelineEntity")
        AEEntityAttribElement.addAttribute("parent", value: "AeonTimeline")
        AEEntityAttribElement.addAttribute("editable", value: "0")
        AEEntityAttribElement.addAttribute("visibleInEditor", value: 1)
        AEEntityAttribElement.addAttribute("default", value: "")
        
        //self.rootAttribElement.addChild(groupAttribElement)
        groupAttribElement.addChild(AEEventAttribElement)
        groupAttribElement.addChild(AEArcAttribElement)
        groupAttribElement.addChild(AEEntityAttribElement)
        
        self.rootAttribElement = groupAttribElement
        
        
        
        
        
        
    }
    
    func addAeonTimelineEventAttribs(aeonEventAttribElement : AEXMLElement) {
        
        
        
        for attrib in aeonEventAttributes {
            
            let attribArray = attrib.componentsSeparatedByString(",")
            
            let aeEventAttribElement = AEXMLElement(attribArray[0])
            
            aeEventAttribElement.addAttribute("parent", value: "AeonTimeline")
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
            
            print (" \(child.name)  \(child.value)")
            
            writeChildren(child)
            
        }
        
    }
    
}
