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
    
    var currentElement: String = ""
    var saveEventTitle : String?
    
    var aeonEventTbxXmlElement = AEXMLElement("item")
    var aeonEventAEElement = AEXMLElement("dummy")
    
    var tbxDocumentCreator = ""
    var nextTbxNoteID : Int64 = 0
    
    
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
    
    var tascBaseContainer : AEXMLElement = AEXMLElement("dummy")
    
    // AeonNoteType - events, arcs, entities
    // AeonNoteStatus - tbd - future use
    
    //relations and tags are lists, child elements entity, participation level
    // duration has a an attribute
    
    let aeonTbxArcAttributes = [""]
    let aeonTbxEntityAttributes = [""]
    
    let aeonAeonArcAttributes = [""]
    let aeonAeonEntityAttributes = [""]
    
    
    let aeonTbxEventAttributes = [ "AeonNoteType,0,0",
        "AeonEventNoteStatus,0,1",
        "AeonEventID,2,0",
        "AeonEventLocked,2,0",
        "AeonEventTitle,0,0",
        "AeonEventAllDay,2,0",
        "AeonEventStartDate,0,0",
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
        "AeonEventExternalLinks,10,0"
    ]
    
    let aeonAeonEventAttributes = [ "AeonNoteType",
        "NoteStatus",
        "ID",
        "Locked",
        "EventTitle",
        "AllDay",
        "StartDate",
        "Description",
        "IncludeInExport",
        "Label",
        "Arc",
        "Relationships",
        "Tags",
        "Completed",
        "Duration",
        "DurationUnit",
        "ShowTime",
        "ShowDay",
        "ShowMonth",
        "ExternalLinks"
    ]
    
    let basicNoteAttributes = [
        
        "Created,2015-07-02T20:39:52-04:00",
        "Modified,2015-07-02T20:39:52-04:00",
        "Name,untitled",
        "SelectionCount,1",
        "Xpos,7.92578125",
        "Ypos,5.116577148"
        
    ]
    
    
    
    var aeonEventsTbxAdornmentAttributeElements = [
        "AgentQuery,$AeonNoteType=&quot;AeonEvent&quot;",
        "Color,green",
        "Created,2015-07-04T07:21:54-04:00",
        "Height,17.95739746",
        "KeyAttributes,AgentQuery",
        "Modified,2015-07-04T07:21:54-04:00",
        "Name,Aeon Timeline Events",
        "Searchable,false",
        "SelectionCount,1",
        "SortAlsoTransform,normal",
        "SortTransform,normal",
        "Width,24.79101562",
        "Xpos,-1.574829102",
        "Ypos,-3.1663818359"]
    
    
    var aeonArcsTbxAdornmentAttributeElements = [
        "AgentQuery,$AeonNoteType=&quot;AeonArc&quot;",
        "Color,blue",
        "Created,2015-07-04T07:21:54-04:00",
        "Height,17.95739746",
        "KeyAttributes,AgentQuery",
        "Modified,2015-07-04T07:21:54-04:00",
        "Name,Aeon Timeline Arcs",
        "Searchable,false",
        "SelectionCount,1",
        "SortAlsoTransform,normal",
        "SortTransform,normal",
        "Width,24.79101562",
        "Xpos,-1.574829102",
        "Ypos,18.1663818359"]
    
    
    
    var aeonEntitiesTbxAdornmentAttributeElements = [
        "AgentQuery,$AeonNoteType=&quot;AeonEntity&quot;",
        "Color,red",
        "Created,2015-07-04T07:21:54-04:00",
        "Height,17.95739746",
        "KeyAttributes,AgentQuery",
        "Modified,2015-07-04T07:21:54-04:00",
        "Name,Aeon Timeline Entities",
        "Searchable,false",
        "SelectionCount,1",
        "SortAlsoTransform,normal",
        "SortTransform,normal",
        "Width,24.79101562",
        "Xpos,-1.574829102",
        "Ypos,40.1663818359"]
    
    //<attribute name="KeyAttributes" >AeonNoteType;AeonEventNoteStatus;AeonEventID;AeonEventLocked;AeonEventTitle;AeonEventAllDay;AeonEventStartDate;AeonEventDescription;AeonEventIncludeInExport;AeonEventLabel;AeonEventArc;AeonEventRelationships;AeonEventTags;AeonEventCompleted;AeonEventDuration;AeonEventDurationUnit;AeonEventShowTime;AeonEventExternalLinks;AeonEventShowMonth;AeonEventShowDay</attribute>
    
    
    
    var rootAttribElement: AEXMLElement = AEXMLElement("dummy")
    
    init() {
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        self.tbxItems = (appDelegate.mainViewController?.outlineViewControllerTbx.tbxItems)!
        self.nextTbxNoteID = (appDelegate.mainViewController?.highestTinderboxNoteID)!
        self.tbxItem = tbxItems[0]
        
        
        // try optional chaining here on file urls, at some point
        
        // init tbx data
        if let tbxfurl = (appDelegate.mainViewController?.tbxfileURL) {
            self.tbxfileurl = tbxfurl
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
    
    func captureTbxUserElement(tbxXmlDoc: AEXMLDocument) {
        // add aeon attribs to user section of tinderbox doc
        for tbxAttributeElement in tbxXmlDoc.root["attrib"]["attrib"].all! {
            if let name  = tbxAttributeElement.attributes["Name"] as? String {
                if name == "User" {
                    
                    let x = tbxXmlDoc.root["attrib"]["attrib"]
                    x.addChild(self.rootAttribElement)
                }
            }
        }
        
    }
    
    func captureOrCreateTASCItem(tbxXmlDoc: AEXMLDocument) {
        var tascItem : AEXMLElement?
        
        // search all tinderbox items (notes) under the top level item (note)
        
        var tbxTopItemAEXmlElement = tbxXmlDoc.root["item"]
        if let creator = tbxTopItemAEXmlElement.attributes["Creator"] as? String {
            self.tbxDocumentCreator = creator
        }
        
        for tbxItemAEElement in tbxXmlDoc.root["item"]["item"].all! {
            
            
            for tbxItemAEElementChild in tbxItemAEElement.children {
                if let name  = tbxItemAEElementChild.attributes["name"] as? String {
                    //print (name)
                    if name == "Name" { // "Aeon Timeline TASC Container" {
                        if tbxItemAEElementChild.value == "Aeon Timeline TASC Container" {
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
            
            tascBaseItem.addAttribute("ID", value: String(++self.nextTbxNoteID)) // make it real
            tascBaseItem.addAttribute("Creator", value: self.tbxDocumentCreator) // make it real
            
            
            // tinderbox attributes
            
            for tbxattribute in basicNoteAttributes {
                let attribArray = tbxattribute.componentsSeparatedByString(",")
                
                let aeTascContainerTbxAttributeElement = AEXMLElement("attribute")
                
                aeTascContainerTbxAttributeElement.addAttribute("name", value: attribArray[0])
                if attribArray[0] == "Name" {
                    aeTascContainerTbxAttributeElement.value = "Aeon Timeline TASC Container"
                } else {
                    aeTascContainerTbxAttributeElement.value = attribArray[1] as String
                    // print ( aeTascContainerTbxAttributeElement.value)
                }
                
                
                tascBaseItem.addChild(aeTascContainerTbxAttributeElement)
            }
            
            self.tascBaseContainer = tascBaseItem
            baseItem.addChild(tascBaseItem)
            
            
        }
    }
    
    func captureAeonEventElement(aeonXmlDoc: AEXMLDocument) {
        
        // always add this attribute element to the event note
        var aeonEventType = AEXMLElement("attribute")
        aeonEventType.addAttribute("name", value: "AeonNoteType")
        aeonEventType.value = "AeonEvent"
        self.aeonEventTbxXmlElement.addChild(aeonEventType)
        
        aeonEventType = AEXMLElement("attribute")
        aeonEventType.addAttribute("name", value: "Prototype")
        aeonEventType.value = "AeonEventsPrototype"
        self.aeonEventTbxXmlElement.addChild(aeonEventType)
        
        // turn the aeon event xml attributes into tinderbox attribute elements, add to event note
        for aeonattribute in  self.aeonEventAEElement.attributes {
            
            let i : Int? = aeonAeonEventAttributes.indexOf(aeonattribute.0 as! String)
            let s = aeonTbxEventAttributes[i!].componentsSeparatedByString(",")
            
            let aeonAttToTbxElement = AEXMLElement("attribute")
            aeonAttToTbxElement.addAttribute("name", value: s[0])
            
            if aeonattribute.1 is String {
                if let s:String = aeonattribute.1 as! String {
                    if !s.isEmpty {
                        aeonAttToTbxElement.value = s
                    }
                    else {
                        aeonAttToTbxElement.value = " "
                    }
                }
                else {
                    aeonAttToTbxElement.value = " "
                }
            }
            else {
                aeonAttToTbxElement.value = " "
            }
            
            self.aeonEventTbxXmlElement.addChild(aeonAttToTbxElement)
        }
        
    }
    
    func captureAeonEventElementChildren(aeonXmlDoc: AEXMLDocument) {
        
        // get the event's child element attributes
        for aeonEventXmlElementChild in  self.aeonEventAEElement.children {
            
            if aeonEventXmlElementChild.name == "EventTitle" {
                self.saveEventTitle = aeonEventXmlElementChild.value
            }
            
            let i : Int? = aeonAeonEventAttributes.indexOf(aeonEventXmlElementChild.name)
            let s = aeonTbxEventAttributes[i!].componentsSeparatedByString(",")
            
            let aeonEventChildTbxXmlElement = AEXMLElement("attribute")
            aeonEventChildTbxXmlElement.addAttribute("name", value: s[0])
            
            if let _ = aeonEventXmlElementChild.value {
                aeonEventChildTbxXmlElement.value = aeonEventXmlElementChild.value!
                
                // if relationships or tags, a whole new thing
                // get its children and turn into list
                // NEEDS to be HANDLED
                
                
                // one element has attributes, get it
                for attribute in aeonEventXmlElementChild.attributes {
                    aeonEventChildTbxXmlElement.addAttribute(attribute.0, value: attribute.1) // dangerous no testing on attribute.1
                }
                
            }
            else {
                aeonEventChildTbxXmlElement.value = " "
            }
            
            aeonEventTbxXmlElement.addChild(aeonEventChildTbxXmlElement)
            
        }
        
    }
    
    func addTinderboxAttributesToAeonEventElement(aeonXmlDoc: AEXMLDocument) {
        // also add necessary tinderbox attributes, id and creator
        self.aeonEventTbxXmlElement.addAttribute("ID", value: String(++self.nextTbxNoteID)) // make it real
        self.aeonEventTbxXmlElement.addAttribute("Creator", value: self.tbxDocumentCreator) // make it real
        
        // add tinderbox attribute elements to aeon note
        
        for tbxattribute in basicNoteAttributes {
            let attribArray = tbxattribute.componentsSeparatedByString(",")
            
            let aeEventTbxAttributeElement = AEXMLElement("attribute")
            
            
            aeEventTbxAttributeElement.addAttribute("name", value: attribArray[0])
            if attribArray[0] == "Name" {
                aeEventTbxAttributeElement.value = self.saveEventTitle
            } else {
                aeEventTbxAttributeElement.value = attribArray[1] as String
            }
            
            
            self.aeonEventTbxXmlElement.addChild(aeEventTbxAttributeElement)
        }
    }
    
    func addAdornmentsToTASCItem(tbxXmlDoc : AEXMLDocument, adornmentsArray: Array <String>) {
        
        
        
        var adornmentXmlElement = AEXMLElement("adornment")
        
        adornmentXmlElement.addAttribute("ID", value: String(++self.nextTbxNoteID)) // make it real
        adornmentXmlElement.addAttribute("Creator", value: self.tbxDocumentCreator) // make it real
        
        for adornmentAttributeElement in adornmentsArray {
            
            let adornmentAttribArray = adornmentAttributeElement.componentsSeparatedByString(",")
            
            let  adornmentAttribElement = AEXMLElement("attribute")
            adornmentAttribElement.value = adornmentAttribArray[1]
            adornmentAttribElement.addAttribute("name", value: adornmentAttribArray[0])
            
            adornmentXmlElement.addChild(adornmentAttribElement)
            
            
        }
        self.tascBaseContainer.addChild(adornmentXmlElement)
        
    }
    
    
    func addPrototypeToTASCItem(tbxXmlDoc : AEXMLDocument) {
        var prototypeXmlElement = AEXMLElement("item")
        
        prototypeXmlElement.addAttribute("ID", value: String(++self.nextTbxNoteID)) // make it real
        prototypeXmlElement.addAttribute("Creator", value: self.tbxDocumentCreator) // make it real
        
        var prototypeAttribElement = AEXMLElement("attribute")
        
        prototypeAttribElement.value = "AeonNoteType;AeonEventNoteStatus;AeonEventID;AeonEventLocked;AeonEventTitle;AeonEventAllDay;AeonEventStartDate;AeonEventDescription;AeonEventIncludeInExport;AeonEventLabel;AeonEventArc;AeonEventRelationships;AeonEventTags;AeonEventCompleted;AeonEventDuration;AeonEventDurationUnit;AeonEventShowTime;AeonEventExternalLinks;AeonEventShowMonth;AeonEventShowDay"
        prototypeAttribElement.addAttribute("name", value: "KeyAttributes")
        prototypeXmlElement.addChild(prototypeAttribElement)
        
        prototypeAttribElement = AEXMLElement("attribute")
        prototypeAttribElement.value = "AeonEventsPrototype"
        prototypeAttribElement.addAttribute("name", value: "Name")
        prototypeXmlElement.addChild(prototypeAttribElement)
        
        prototypeAttribElement = AEXMLElement("attribute")
        prototypeAttribElement.value = "true"
        prototypeAttribElement.addAttribute("name", value: "IsPrototype")
        prototypeXmlElement.addChild(prototypeAttribElement)
        
        self.tascBaseContainer.addChild(prototypeXmlElement)
        
        // and two more, arcs and entities
    }
    
    
    func addAeonAttributesToTinderboxDoc() {
        
        var error: NSError?
        
        if let tbxXmlDoc = AEXMLDocument(xmlData: self.tbxdata, error: &error) {
            
            
            captureTbxUserElement(tbxXmlDoc)
            captureOrCreateTASCItem(tbxXmlDoc)
            
            addAdornmentsToTASCItem(tbxXmlDoc, adornmentsArray: self.aeonEventsTbxAdornmentAttributeElements)
            addAdornmentsToTASCItem(tbxXmlDoc, adornmentsArray: self.aeonArcsTbxAdornmentAttributeElements)
            addAdornmentsToTASCItem(tbxXmlDoc, adornmentsArray: self.aeonEntitiesTbxAdornmentAttributeElements)
            
            addPrototypeToTASCItem(tbxXmlDoc)
            
            
            var error: NSError?
            
            if let aeonXmlDoc = AEXMLDocument(xmlData: self.aeondata, error: &error) {
                
                // get the events
                for aeonEventAEElement in aeonXmlDoc.root["Events"]["Event"].all! {
                    
                    self.aeonEventTbxXmlElement = AEXMLElement("item")
                    self.aeonEventAEElement = aeonEventAEElement
                    
                    captureAeonEventElement(aeonXmlDoc)
                    captureAeonEventElementChildren(aeonXmlDoc)
                    addTinderboxAttributesToAeonEventElement(aeonXmlDoc)
                    
                    
                    self.tascBaseContainer.addChild(aeonEventTbxXmlElement)
                }
                
                
                
            }
            
            
            // print(tbxXmlDoc.xmlString)
            
            var path : String = ""
            let savePanel = NSSavePanel()
            savePanel.beginWithCompletionHandler { (result: Int) -> Void in
                if result == NSFileHandlingPanelOKButton {
                    _ = savePanel.URL  //writing
                    
                    path  = savePanel.URL!.path!
                    
                }
                
                do {
                    try
                        tbxXmlDoc.xmlString.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding)
                    
                } catch {
                    // Catch all error-handling
                }
                
                
                
            } // End block
            
            
            
            
        }
        
    }
    
    enum FileWriteError: ErrorType {
        case Unknown
        case Known
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
        if let tbxXmlDoc = AEXMLDocument(xmlData: self.tbxdata, error: &error) {
            
            for tbxAttributeElement in tbxXmlDoc.root["attrib"]["attrib"].all! {
                if let name  = tbxAttributeElement.attributes["Name"] as? String {
                    if name == "User" {
                        self.rootAttribElement = tbxAttributeElement
                        let x = tbxXmlDoc.root["attrib"]["attrib"]
                        x.addChild(self.rootAttribElement)
                        addAeonTimelineEventAttribs(self.rootAttribElement)
                    }
                }
            }
            
            
        }
        
    }
    
    func addAeonTimelineEventAttribs(aeonEventAttribElement : AEXMLElement) {
        
        
        
        for attrib in aeonTbxEventAttributes {
            
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
