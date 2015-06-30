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
        
        let aeonAttributes = ["AeonEventNoteStatus",
        "AeonEventID",
        "AeonEventLocked",
        "AeonEventTitle",
        "AeonEventAllDay",
        "AeonEventStartDate",
        "AeonEventDescription",
        "AeonEventIncludeInExport",
        "AeonEventLabel",
        "AeonEventArc",
        "AeonEventRelationships",
        "AeonEventTags",
        "AeonEventCompleted",
        "AeonEventDuration",
        "AeonEventDurationUnit",
        "AeonEventShowTime",
        "AeonEventShowDay",
        "AeonEventShowMonth",
        "AeonEventExternalLinks",
        "AeonEventNoteStatus" ]
        
        print("one  \(self.tbxItem)")
        print("many \(self.tbxItems)")
        
        print ("name \(tbxItem.name) value \(tbxItem.value)")
        
        for child in tbxItem.children {
            
            print (" \(child.name)  \(child.value)")
            
            writeChildren(child)
            
        }
        
        
        
        let rootAttribElement = AEXMLElement("Tools") // like system and user
        rootAttribElement.value = ""
        rootAttribElement.addAttribute("editable", value: "0")
        rootAttribElement.addAttribute("visibleInEditor", value: 1)
        rootAttribElement.addAttribute("default", value: "")

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
        
        
        addAeonTimelineEventAttributes(AEEventAttribElement)
        
        
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
        
        
    }
    
    func addAeonTimelineEventAttributes(AEEventAttribElement : AEXMLElement) {
        
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
