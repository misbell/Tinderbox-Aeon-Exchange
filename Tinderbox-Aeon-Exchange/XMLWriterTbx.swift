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
    
    
    var aeonArcTbxXmlElement = AEXMLElement("item")
    var aeonArcAEElement = AEXMLElement("dummy")
    
    
    var aeonEntityTbxXmlElement = AEXMLElement("item")
    var aeonEntityAEElement = AEXMLElement("dummy")
    
    var tbxDocumentCreator = ""
    var nextTbxNoteID : Int64 = 0
    
    var noteTimeStamp : String = ""
    
    var tinderboxXmlDoc : AEXMLDocument?
    
    var existingTascChildrenCount = 0
    
    
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
    
    let aeonAeonEntityAttributes = [ "AeonEntityNoteType",
        "AeonEntityNoteStatus",
        "Notes",
        "EntityType",
        "Visible",
        "Colour",
        "AgeAtFirstEvent",
        "Name"
    ]
    
    let aeonAeonArcAttributes = [ "AeonArcNoteType",
        "AeonArcNoteStatus",
        "Description",
        "ArcIsGlobal",
        "Visible",
        "Name"
    ]
    
    let aeonTbxArcAttributes = [ "AeonArcNoteType,0,0",
        "AeonArcNoteStatus,0,1",
        "AeonArcDescription,0,1",
        "AeonArcArcIsGlobal,0,1",
        "AeonArcVisible,0,1",
        "AeonArcName,0,1"
    ]
    
    let aeonTbxEntityAttributes = [ "AeonEntityNoteType,0,0",
        "AeonEntityNoteStatus,0,1",
        "AeonEntityNotes,0,1",
        "AeonEntityEntityType,0,1",
        "AeonEntityVisible,0,1",
        "AeonEntityColour,0,1",
        "AeonEntityAgeAtFirstEvent,0,1",
        "AeonEntityName,0,1"
    ]
    
    
    
    let aeonTbxEventAttributes = [ "AeonEventNoteType,0,0",
        "AeonEventNoteStatus,0,1",
        "AeonEventID,2,0",
        "AeonEventLocked,2,0",
        "AeonEventTitle,0,1",
        "AeonEventAllDay,2,0",
        "AeonEventStartDate,0,0",
        "AeonEventDescription,0,1",
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
    
    let aeonTbxEventRelationshipAttributes = [ "AeonEventRelationshipNoteType,0,0",
        "AeonEventRelationshipNoteStatus,0,1",]
    
    let aeonTbxEventTagAttributes = [ "AeonEventTagNoteType,0,0",
        "AeonEventTagNoteStatus,0,1",]
    
    let aeonAeonEventRelationshipAttributes = [ "AeonEventRelationshipNoteType",
        "NoteStatus"]
    
    let aeonAeonEventTagAttributes = [ "AeonEventTagNoteType",
        "NoteStatus"]
    
    
    
    let aeonAeonEventAttributes = [ "AeonEventNoteType",
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
        "AgentQuery,$AeonEventNoteType=&quot;AeonEvent&quot;",
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
        "AgentQuery,$AeonArcNoteType=&quot;AeonArc&quot;",
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
        "AgentQuery,$AeonEntityNoteType=&quot;AeonEntity&quot;",
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
    
    
    
    var aeonRelationshipsTbxAdornmentAttributeElements = [
        "AgentQuery,$AeonEventRelationshipNoteType=&quot;AeonRelationship&quot;",
        "Color,orange",
        "Created,2015-07-04T07:21:54-04:00",
        "Height,17.95739746",
        "KeyAttributes,AgentQuery",
        "Modified,2015-07-04T07:21:54-04:00",
        "Name,Aeon Timeline Event Relationships",
        "Searchable,false",
        "SelectionCount,1",
        "SortAlsoTransform,normal",
        "SortTransform,normal",
        "Width,24.79101562",
        "Xpos,-1.574829102",
        "Ypos,-3.1663818359"]
    
    
    var aeonTagsTbxAdornmentAttributeElements = [
        "AgentQuery,$AeonEventTagNoteType=&quot;AeonTag&quot;",
        "Color,violet",
        "Created,2015-07-04T07:21:54-04:00",
        "Height,17.95739746",
        "KeyAttributes,AgentQuery",
        "Modified,2015-07-04T07:21:54-04:00",
        "Name,Aeon Timeline Event Tags",
        "Searchable,false",
        "SelectionCount,1",
        "SortAlsoTransform,normal",
        "SortTransform,normal",
        "Width,24.79101562",
        "Xpos,-1.574829102",
        "Ypos,18.1663818359"]
    
    
    
    
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
        
        
        
        self.noteTimeStamp =  getTodayDateString()
        
        
        
    }
    
    func getTodayDateString() -> String {
        let todaysDate:NSDate = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"
        // formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        formatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)!
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        return  formatter.stringFromDate(todaysDate)
        
    }
    
    
    func captureTbxUserElement(tbxXmlDoc: AEXMLDocument) {
        // add aeon attribs to user section of tinderbox doc
        
        addAeonTimelineEventAttribs(tbxXmlDoc.root["attrib"].children[1])
        addAeonTimelineArcAttribs(tbxXmlDoc.root["attrib"].children[1])
        addAeonTimelineEntityAttribs(tbxXmlDoc.root["attrib"].children[1])
        
        addAeonTimelineEventRelationshipAttribs(tbxXmlDoc.root["attrib"].children[1])
        addAeonTimelineEventTagAttribs(tbxXmlDoc.root["attrib"].children[1])
        
    }
    
    
    
    
    func captureOrCreateTASCItem(tbxXmlDoc: AEXMLDocument) {
        var tascItem : AEXMLElement?
        
        // search all tinderbox items (notes) under the top level item (note)
        
        var tbxTopItemAEXmlElement = tbxXmlDoc.root["item"]
        if let creator = tbxTopItemAEXmlElement.attributes["Creator"] as? String {
            self.tbxDocumentCreator = creator
        }
        
        for tbxItemAEElement in tbxXmlDoc.root["item"].children {
            
            
            for tbxItemAEElementChild in tbxItemAEElement.children {
                if let name  = tbxItemAEElementChild.attributes["name"] as? String {
                    //print (name)
                    if name == "Name" { // "Aeon Timeline TASC Container" {
                        if tbxItemAEElementChild.value == "Aeon Timeline TASC Container" {
                            
                            // this lines means events will be added to FIRST container...
                            // this could be useful, add new events to a separate container...
                            // tascItem = tbxXmlDoc.root["item"]["item"]
                            tascItem = tbxItemAEElement
                            self.tascBaseContainer = tbxItemAEElement // or ... tbxItemAEElementChild
                            
                            
                        }
                        
                    }
                    
                }
            }
            
            
        }
        
        if let _  = tascItem {
            
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
                
                switch attribArray[0]{
                case  "Name":
                    aeTascContainerTbxAttributeElement.value = "Aeon Timeline TASC Container"
                case  "Created":
                    aeTascContainerTbxAttributeElement.value = self.noteTimeStamp
                case  "Modified":
                    aeTascContainerTbxAttributeElement.value = self.noteTimeStamp
                default:
                    aeTascContainerTbxAttributeElement.value = attribArray[1] as String
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
        aeonEventType.addAttribute("name", value: "AeonEventNoteType")
        aeonEventType.value = "AeonEvent"
        self.aeonEventTbxXmlElement.addChild(aeonEventType)
        
        aeonEventType = AEXMLElement("attribute")
        aeonEventType.addAttribute("name", value: "Prototype")
        aeonEventType.value = "AeonEventsPrototype"
        self.aeonEventTbxXmlElement.addChild(aeonEventType)
        
        var anAeonEventAEElement = self.aeonEventAEElement
        
        var aeonEventChildTbxXmlElement = AEXMLElement("attribute")
        aeonEventChildTbxXmlElement.addAttribute("name", value: "TitleHeight")
        aeonEventChildTbxXmlElement.value = "5"
        aeonEventTbxXmlElement.addChild(aeonEventChildTbxXmlElement)
        
        if self.existingTascChildrenCount > 0 {
            var aeonEventChildTbxXmlElement = AEXMLElement("attribute")
            aeonEventChildTbxXmlElement.addAttribute("name", value: "Badge")
            aeonEventChildTbxXmlElement.value = "label green"
            aeonEventTbxXmlElement.addChild(aeonEventChildTbxXmlElement)
        }
        
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
            
            addAdornmentsToTbxAeonEventItem(aeonEventTbxXmlElement, adornmentsArray: self.aeonRelationshipsTbxAdornmentAttributeElements)
            addAdornmentsToTbxAeonEventItem(aeonEventTbxXmlElement, adornmentsArray: self.aeonTagsTbxAdornmentAttributeElements)
            
        }
        
    }
    
    func captureAeonEventElementChildren(aeonXmlDoc: AEXMLDocument) {
        
        // get the event's child element attributes
        
        for aeonEventXmlElementChild in  self.aeonEventAEElement.children {
            
            if aeonEventXmlElementChild.name == "EventTitle" {
                self.saveEventTitle = aeonEventXmlElementChild.value
            }
            
            
            // make a note. if no description in aeon then text must be added here to text anyway
            
            if aeonEventXmlElementChild.name == "Description" {
                
                var aeonEventChildTbxXmlElement = AEXMLElement("text")
                if let aeonEventDescriptionvalue = aeonEventXmlElementChild.value {
                    aeonEventChildTbxXmlElement.value = aeonEventDescriptionvalue
                } else {
                    aeonEventChildTbxXmlElement.value = "No note was found for this event in Aeon Timeline"
                }
                aeonEventTbxXmlElement.addChild(aeonEventChildTbxXmlElement)
                
            }
            
            if aeonEventXmlElementChild.name == "Relationships" {
                captureAeonEventElementRelationshipChildren(aeonEventAEElement,aeonEventAERelationships: aeonEventXmlElementChild)
            } else {
                
                if aeonEventXmlElementChild.name == "Tags" {
                    captureAeonEventElementTagChildren(aeonEventAEElement,aeonEventAETags: aeonEventXmlElementChild)
                } else { // everything else
                    
                    
                    // wrong place for this, added more than once?
                    
                    
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
                        //for attribute in aeonEventXmlElementChild.attributes {
                        //    aeonEventChildTbxXmlElement.addAttribute(attribute.0, value: attribute.1) // dangerous no testing on attribute.1
                        //}
                        
                    }
                    else {
                        aeonEventChildTbxXmlElement.value = " "
                        
                        // for attribute in aeonEventXmlElementChild.attributes {
                        //     aeonEventChildTbxXmlElement.addAttribute(attribute.0, value: attribute.1) // dangerous no testing on attribute.1
                        // }
                    }
                    
                    for attribute in aeonEventXmlElementChild.attributes {
                        aeonEventChildTbxXmlElement.addAttribute(attribute.0, value: attribute.1) // dangerous no testing on attribute.1
                    }
                    
                    aeonEventTbxXmlElement.addChild(aeonEventChildTbxXmlElement)
                }
            }
        }
        
        
    }
    
    func captureAeonEventElementRelationshipChildren(aeonEventAEElement: AEXMLElement, aeonEventAERelationships: AEXMLElement) {
        
        //    not used
        //      let attribArray = aeonTbxEventRelationshipAttributes.componentsSeparatedByString(",")
        
        for aeonEventAEOneRelationship in aeonEventAERelationships.children {
            print ( "rel = \(aeonEventAEOneRelationship.value)")
            
            
            
            var relationshipEntity = ""
            var relationshipParticipation = ""
            for relationshipComponent in aeonEventAEOneRelationship.children {
                
                if relationshipComponent.name == "Entity" {
                    relationshipEntity = relationshipComponent.value!
                }
                if relationshipComponent.name == "ParticipationLevel" {
                    
                    switch relationshipComponent.value! {
                    case "1":
                        relationshipParticipation = "Observer"
                    case "2":
                        relationshipParticipation = "Participant"
                    case "3":
                        relationshipParticipation = "Death"
                    case "4":
                        relationshipParticipation = "Birth"
                    default:
                        relationshipParticipation = "unknown"
                        
                    }
                    
                }
                
            }
            
            let aeonEventChildTbxXmlElement = AEXMLElement("item")
            aeonEventChildTbxXmlElement.addAttribute("ID", value: String(++self.nextTbxNoteID)) // make it real
            aeonEventChildTbxXmlElement.addAttribute("Creator", value: self.tbxDocumentCreator) // make it real
            aeonEventChildTbxXmlElement.addAttribute("proto", value: "AeonRelationshipsPrototype")
            
            for tbxattribute in basicNoteAttributes {
                let attribArray = tbxattribute.componentsSeparatedByString(",")
                
                let aeEventTbxAttributeElement = AEXMLElement("attribute")
                
                aeEventTbxAttributeElement.addAttribute("name", value: attribArray[0])
                
                switch attribArray[0]{
                case  "Name":
                    aeEventTbxAttributeElement.value = "Relationship: " + relationshipEntity + ";" + relationshipParticipation
                case  "Created":
                    aeEventTbxAttributeElement.value = self.noteTimeStamp
                case  "Modified":
                    aeEventTbxAttributeElement.value = self.noteTimeStamp
                default:
                    aeEventTbxAttributeElement.value = attribArray[1] as String
                }
                aeonEventChildTbxXmlElement.addChild(aeEventTbxAttributeElement)
            }
            
            let aeonNoteTypeElement = AEXMLElement("attribute")
            aeonNoteTypeElement.addAttribute("name", value: "AeonEventRelationshipNoteType")
            aeonNoteTypeElement.value = "AeonRelationship"
            aeonEventChildTbxXmlElement.addChild(aeonNoteTypeElement)
            
            let aeonPrototypeTypeElement = AEXMLElement("attribute")
            aeonPrototypeTypeElement.addAttribute("name", value: "Prototype")
            aeonPrototypeTypeElement.value = "AeonRelationshipsPrototype"
            aeonEventChildTbxXmlElement.addChild(aeonPrototypeTypeElement)
            
            aeonEventTbxXmlElement.addChild(aeonEventChildTbxXmlElement)
            
        }
    }
    
    func captureAeonEventElementTagChildren(aeonEventAEElement: AEXMLElement, aeonEventAETags: AEXMLElement)  {
        
        
        //    not used
        //      let attribArray = aeonTbxEventTagAttributes.componentsSeparatedByString(",")
        
        for aeonEventAEOneTag in aeonEventAETags.children {
            print (  "tag = \(aeonEventAEOneTag.value)")
            
            let aeonEventChildTbxXmlElement = AEXMLElement("item")
            aeonEventChildTbxXmlElement.addAttribute("ID", value: String(++self.nextTbxNoteID)) // make it real
            aeonEventChildTbxXmlElement.addAttribute("Creator", value: self.tbxDocumentCreator) // make it real
            aeonEventChildTbxXmlElement.addAttribute("proto", value: "AeonTagsPrototype")
            
            for tbxattribute in basicNoteAttributes {
                let attribArray = tbxattribute.componentsSeparatedByString(",")
                
                let aeEventTbxAttributeElement = AEXMLElement("attribute")
                
                aeEventTbxAttributeElement.addAttribute("name", value: attribArray[0])
                
                switch attribArray[0]{
                case  "Name":
                    aeEventTbxAttributeElement.value = "Tag: " + aeonEventAEOneTag.value!
                case  "Created":
                    aeEventTbxAttributeElement.value = self.noteTimeStamp
                case  "Modified":
                    aeEventTbxAttributeElement.value = self.noteTimeStamp
                default:
                    aeEventTbxAttributeElement.value = attribArray[1] as String
                }
                aeonEventChildTbxXmlElement.addChild(aeEventTbxAttributeElement)
            }
            
            // always add this attribute element to the event note
            let aeonNoteTypeElement = AEXMLElement("attribute")
            aeonNoteTypeElement.addAttribute("name", value: "AeonEventTagNoteType")
            aeonNoteTypeElement.value = "AeonTag"
            aeonEventChildTbxXmlElement.addChild(aeonNoteTypeElement)
            
            let aeonPrototypeTypeElement = AEXMLElement("attribute")
            aeonPrototypeTypeElement.addAttribute("name", value: "Prototype")
            aeonPrototypeTypeElement.value = "AeonTagsPrototype"
            aeonEventChildTbxXmlElement.addChild(aeonPrototypeTypeElement)
            
            aeonEventTbxXmlElement.addChild(aeonEventChildTbxXmlElement)
            
            
        }
    }
    
    func captureAeonArcElementChildren(aeonXmlDoc: AEXMLDocument) {
        
        // get the event's child element attributes
        for aeonArcXmlElementChild in  self.aeonArcAEElement.children {
            
            if aeonArcXmlElementChild.name == "Name" {
                self.saveEventTitle = aeonArcXmlElementChild.value
            }
            
            //          if aeonArcXmlElementChild.name == "Description" {
            //              var aeonArcChildTbxXmlElement = AEXMLElement("text") // not correct, Notes
            //              aeonArcChildTbxXmlElement.value = aeonArcXmlElementChild.value
            //              aeonArcTbxXmlElement.addChild(aeonArcChildTbxXmlElement)
            
            //          }
            
            let i : Int? = aeonAeonArcAttributes.indexOf(aeonArcXmlElementChild.name)
            let s = aeonTbxArcAttributes[i!].componentsSeparatedByString(",")
            
            let aeonArcChildTbxXmlElement = AEXMLElement("attribute")
            aeonArcChildTbxXmlElement.addAttribute("name", value: s[0])
            
            if let _ = aeonArcXmlElementChild.value {
                aeonArcChildTbxXmlElement.value = aeonArcXmlElementChild.value!
                
                // if relationships or tags, a whole new thing
                // get its children and turn into list
                // NEEDS to be HANDLED
                
                // one element has attributes, get it
                for attribute in aeonArcXmlElementChild.attributes {
                    aeonArcChildTbxXmlElement.addAttribute(attribute.0, value: attribute.1) // dangerous no testing on attribute.1
                }
                
            }
            else {
                aeonArcChildTbxXmlElement.value = " "
            }
            
            aeonArcTbxXmlElement.addChild(aeonArcChildTbxXmlElement)
            
        }
        
    }
    
    
    func captureAeonEntityElementChildren(aeonXmlDoc: AEXMLDocument) {
        
        // get the event's child element attributes
        for aeonEntityXmlElementChild in  self.aeonEntityAEElement.children {
            
            if aeonEntityXmlElementChild.name == "Name" {
                self.saveEventTitle = aeonEntityXmlElementChild.value
            }
            
            if aeonEntityXmlElementChild.name == "Notes" {
                var aeonEntityChildTbxXmlElement = AEXMLElement("text") // not correct, Notes or desc
                aeonEntityChildTbxXmlElement.value = aeonEntityXmlElementChild.value
                aeonEntityTbxXmlElement.addChild(aeonEntityChildTbxXmlElement)
                
            }
            
            let i : Int? = aeonAeonEntityAttributes.indexOf(aeonEntityXmlElementChild.name)
            let s = aeonTbxEntityAttributes[i!].componentsSeparatedByString(",")
            
            let aeonEntityChildTbxXmlElement = AEXMLElement("attribute")
            aeonEntityChildTbxXmlElement.addAttribute("name", value: s[0])
            
            if let _ = aeonEntityXmlElementChild.value {
                aeonEntityChildTbxXmlElement.value = aeonEntityXmlElementChild.value!
                
                // if relationships or tags, a whole new thing
                // get its children and turn into list
                // NEEDS to be HANDLED
                
                
                // one element has attributes, get it
                for attribute in aeonEntityXmlElementChild.attributes {
                    aeonEntityChildTbxXmlElement.addAttribute(attribute.0, value: attribute.1) // dangerous no testing on attribute.1
                }
                
            }
            else {
                aeonEntityChildTbxXmlElement.value = " "
            }
            
            aeonEntityTbxXmlElement.addChild(aeonEntityChildTbxXmlElement)
            
        }
        
    }
    
    func addTinderboxAttributesToAeonEventElement(aeonXmlDoc: AEXMLDocument) {
        // also add necessary tinderbox attributes, id and creator
        self.aeonEventTbxXmlElement.addAttribute("ID", value: String(++self.nextTbxNoteID)) // make it real
        self.aeonEventTbxXmlElement.addAttribute("Creator", value: self.tbxDocumentCreator) // make it real
        self.aeonEventTbxXmlElement.addAttribute("proto", value: "AeonEventsPrototype")
        
        // add tinderbox attribute elements to aeon note
        
        for tbxattribute in basicNoteAttributes {
            let attribArray = tbxattribute.componentsSeparatedByString(",")
            
            let aeEventTbxAttributeElement = AEXMLElement("attribute")
            
            aeEventTbxAttributeElement.addAttribute("name", value: attribArray[0])
            
            switch attribArray[0]{
            case  "Name":
                aeEventTbxAttributeElement.value = self.saveEventTitle
            case  "Created":
                aeEventTbxAttributeElement.value = self.noteTimeStamp
            case  "Modified":
                aeEventTbxAttributeElement.value = self.noteTimeStamp
            default:
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
    
    
    func addAdornmentsToTbxAeonEventItem(tbxAeonEventElement: AEXMLElement, adornmentsArray: Array <String>) {
        
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
        tbxAeonEventElement.addChild(adornmentXmlElement)
        
    }
    
    
    
    func addPrototypeToTASCItem(tbxXmlDoc : AEXMLDocument) {
        
        var prototypeEventXmlElement = AEXMLElement("item")
        
        prototypeEventXmlElement.addAttribute("ID", value: String(++self.nextTbxNoteID)) // make it real
        prototypeEventXmlElement.addAttribute("Creator", value: self.tbxDocumentCreator) // make it real
        
        var prototypeEventAttribElement = AEXMLElement("attribute")
        
        prototypeEventAttribElement.value = "TitleHeight;Badge;AeonEventNoteType;AeonEventNoteStatus;AeonEventID;AeonEventLocked;AeonEventTitle;AeonEventAllDay;AeonEventStartDate;AeonEventDescription;AeonEventIncludeInExport;AeonEventLabel;AeonEventArc;AeonEventCompleted;AeonEventDuration;AeonEventDurationUnit;AeonEventShowTime;AeonEventExternalLinks;AeonEventShowMonth;AeonEventShowDay"
        prototypeEventAttribElement.addAttribute("name", value: "KeyAttributes")
        prototypeEventXmlElement.addChild(prototypeEventAttribElement)
        
        prototypeEventAttribElement = AEXMLElement("attribute")
        prototypeEventAttribElement.value = "AeonEventsPrototype"
        prototypeEventAttribElement.addAttribute("name", value: "Name")
        prototypeEventXmlElement.addChild(prototypeEventAttribElement)
        
        prototypeEventAttribElement = AEXMLElement("attribute")
        prototypeEventAttribElement.value = "true"
        prototypeEventAttribElement.addAttribute("name", value: "IsPrototype")
        prototypeEventXmlElement.addChild(prototypeEventAttribElement)
        
        self.tascBaseContainer.addChild(prototypeEventXmlElement)
        
        // and two more, arcs and entities
        // arcs
        
        var prototypeArcXmlElement = AEXMLElement("item")
        
        prototypeArcXmlElement.addAttribute("ID", value: String(++self.nextTbxNoteID)) // make it real
        prototypeArcXmlElement.addAttribute("Creator", value: self.tbxDocumentCreator) // make it real
        
        var prototypeArcAttribElement = AEXMLElement("attribute")
        
        prototypeArcAttribElement.value = "AeonArcNoteType;AeonArcNoteStatus;AeonArcDescription;AeonArcArcIsGlobal;AeonArcVisible;AeonArcName"
        
        prototypeArcAttribElement.addAttribute("name", value: "KeyAttributes")
        prototypeArcXmlElement.addChild(prototypeArcAttribElement)
        
        prototypeArcAttribElement = AEXMLElement("attribute")
        prototypeArcAttribElement.value = "AeonArcsPrototype"
        prototypeArcAttribElement.addAttribute("name", value: "Name")
        prototypeArcXmlElement.addChild(prototypeArcAttribElement)
        
        prototypeArcAttribElement = AEXMLElement("attribute")
        prototypeArcAttribElement.value = "true"
        prototypeArcAttribElement.addAttribute("name", value: "IsPrototype")
        prototypeArcXmlElement.addChild(prototypeArcAttribElement)
        
        self.tascBaseContainer.addChild(prototypeArcXmlElement)
        
        
        // entities
        
        var prototypeEntityXmlElement = AEXMLElement("item")
        
        prototypeEntityXmlElement.addAttribute("ID", value: String(++self.nextTbxNoteID)) // make it real
        prototypeEntityXmlElement.addAttribute("Creator", value: self.tbxDocumentCreator) // make it real
        
        var prototypeEntityAttribElement = AEXMLElement("attribute")
        
        prototypeEntityAttribElement.value = "AeonEntityNoteType;AeonEntityNoteStatus;AeonEntityNotes;AeonEntityEntityType;AeonEntityVisible;AeonEntityColour;AeonEntityAgeAtFirstEvent;AeonEntityName"
        
        prototypeEntityAttribElement.addAttribute("name", value: "KeyAttributes")
        prototypeEntityXmlElement.addChild(prototypeEntityAttribElement)
        
        prototypeEntityAttribElement = AEXMLElement("attribute")
        prototypeEntityAttribElement.value = "AeonEntitiesPrototype"
        prototypeEntityAttribElement.addAttribute("name", value: "Name")
        prototypeEntityXmlElement.addChild(prototypeEntityAttribElement)
        
        prototypeEntityAttribElement = AEXMLElement("attribute")
        prototypeEntityAttribElement.value = "true"
        prototypeEntityAttribElement.addAttribute("name", value: "IsPrototype")
        prototypeEntityXmlElement.addChild(prototypeEntityAttribElement)
        
        self.tascBaseContainer.addChild(prototypeEntityXmlElement)
        
        
        // relationships
        
        var prototypeRelationshipXmlElement = AEXMLElement("item")
        
        prototypeRelationshipXmlElement.addAttribute("ID", value: String(++self.nextTbxNoteID)) // make it real
        prototypeRelationshipXmlElement.addAttribute("Creator", value: self.tbxDocumentCreator) // make it real
        
        var prototypeRelationshipAttribElement = AEXMLElement("attribute")
        
        prototypeRelationshipAttribElement.value = "AeonEventRelationshipNoteType;Prototype"
        
        prototypeRelationshipAttribElement.addAttribute("name", value: "KeyAttributes")
        prototypeRelationshipXmlElement.addChild(prototypeRelationshipAttribElement)
        
        prototypeRelationshipAttribElement = AEXMLElement("attribute")
        prototypeRelationshipAttribElement.value = "AeonRelationshipsPrototype"
        prototypeRelationshipAttribElement.addAttribute("name", value: "Name")
        prototypeRelationshipXmlElement.addChild(prototypeRelationshipAttribElement)
        
        prototypeRelationshipAttribElement = AEXMLElement("attribute")
        prototypeRelationshipAttribElement.value = "true"
        prototypeRelationshipAttribElement.addAttribute("name", value: "IsPrototype")
        prototypeRelationshipXmlElement.addChild(prototypeRelationshipAttribElement)
        
        self.tascBaseContainer.addChild(prototypeRelationshipXmlElement)
        
        
        // tags
        
        var prototypeTagXmlElement = AEXMLElement("item")
        
        prototypeTagXmlElement.addAttribute("ID", value: String(++self.nextTbxNoteID)) // make it real
        prototypeTagXmlElement.addAttribute("Creator", value: self.tbxDocumentCreator) // make it real
        
        var prototypeTagAttribElement = AEXMLElement("attribute")
        
        prototypeTagAttribElement.value = "AeonEventTagNoteType;Prototype"
        
        prototypeTagAttribElement.addAttribute("name", value: "KeyAttributes")
        prototypeTagXmlElement.addChild(prototypeTagAttribElement)
        
        prototypeTagAttribElement = AEXMLElement("attribute")
        prototypeTagAttribElement.value = "AeonTagsPrototype"
        prototypeTagAttribElement.addAttribute("name", value: "Name")
        prototypeTagXmlElement.addChild(prototypeTagAttribElement)
        
        prototypeTagAttribElement = AEXMLElement("attribute")
        prototypeTagAttribElement.value = "true"
        prototypeTagAttribElement.addAttribute("name", value: "IsPrototype")
        prototypeTagXmlElement.addChild(prototypeTagAttribElement)
        
        self.tascBaseContainer.addChild(prototypeTagXmlElement)
        
    }
    
    
    
    
    func addTinderboxAttributesToAeonArcElement(aeonXmlDoc: AEXMLDocument) {
        // also add necessary tinderbox attributes, id and creator
        self.aeonArcTbxXmlElement.addAttribute("ID", value: String(++self.nextTbxNoteID)) // make it real
        self.aeonArcTbxXmlElement.addAttribute("Creator", value: self.tbxDocumentCreator) // make it real
        self.aeonArcTbxXmlElement.addAttribute("proto", value: "AeonArcsPrototype")
        
        // add tinderbox attribute elements to aeon note
        
        for tbxattribute in basicNoteAttributes {
            let attribArray = tbxattribute.componentsSeparatedByString(",")
            
            let aeArcTbxAttributeElement = AEXMLElement("attribute")
            
            aeArcTbxAttributeElement.addAttribute("name", value: attribArray[0])
            
            switch attribArray[0]{
            case  "Name":
                aeArcTbxAttributeElement.value = self.saveEventTitle
            case  "Created":
                aeArcTbxAttributeElement.value = self.noteTimeStamp
            case  "Modified":
                aeArcTbxAttributeElement.value = self.noteTimeStamp
            default:
                aeArcTbxAttributeElement.value = attribArray[1] as String
            }
            self.aeonArcTbxXmlElement.addChild(aeArcTbxAttributeElement)
        }
    }
    
    
    func addTinderboxAttributesToAeonEntityElement(aeonXmlDoc: AEXMLDocument) {
        // also add necessary tinderbox attributes, id and creator
        self.aeonEntityTbxXmlElement.addAttribute("ID", value: String(++self.nextTbxNoteID)) // make it real
        self.aeonEntityTbxXmlElement.addAttribute("Creator", value: self.tbxDocumentCreator) // make it real
        self.aeonEntityTbxXmlElement.addAttribute("proto", value: "AeonEntitiesPrototype")
        
        // add tinderbox attribute elements to aeon note
        
        for tbxattribute in basicNoteAttributes {
            let attribArray = tbxattribute.componentsSeparatedByString(",")
            
            let aeEntityTbxAttributeElement = AEXMLElement("attribute")
            
            aeEntityTbxAttributeElement.addAttribute("name", value: attribArray[0])
            
            switch attribArray[0]{
            case  "Name":
                aeEntityTbxAttributeElement.value = self.saveEventTitle
            case  "Created":
                aeEntityTbxAttributeElement.value = self.noteTimeStamp
            case  "Modified":
                aeEntityTbxAttributeElement.value = self.noteTimeStamp
            default:
                aeEntityTbxAttributeElement.value = attribArray[1] as String
            }
            self.aeonEntityTbxXmlElement.addChild(aeEntityTbxAttributeElement)
        }
    }
    
    
    
    
    func captureAeonArcElement(aeonXmlDoc: AEXMLDocument) {
        
        // always add this attribute element to the event note
        var aeonArcType = AEXMLElement("attribute")
        aeonArcType.addAttribute("name", value: "AeonArcNoteType")
        aeonArcType.value = "AeonArc"
        self.aeonArcTbxXmlElement.addChild(aeonArcType)
        
        aeonArcType = AEXMLElement("attribute")
        aeonArcType.addAttribute("name", value: "Prototype")
        aeonArcType.value = "AeonArcsPrototype"
        self.aeonArcTbxXmlElement.addChild(aeonArcType)
        
    }
    
    
    func captureAeonEntityElement(aeonXmlDoc: AEXMLDocument) {
        
        // always add this attribute element to the event note
        var aeonEntityType = AEXMLElement("attribute")
        aeonEntityType.addAttribute("name", value: "AeonEntityNoteType")
        aeonEntityType.value = "AeonEntity"
        self.aeonEntityTbxXmlElement.addChild(aeonEntityType)
        
        aeonEntityType = AEXMLElement("attribute")
        aeonEntityType.addAttribute("name", value: "Prototype")
        aeonEntityType.value = "AeonEntitiesPrototype"
        self.aeonEntityTbxXmlElement.addChild(aeonEntityType)
        
    }
    
    func matchForAeonEventTitleWithExistingTbxNoteName(childAttributeElementsForTbxNote: AEXMLElement, aeonArcEventTitle: String)  -> Bool{
        
        
        for tbxItemAeElementChildB in childAttributeElementsForTbxNote.children {
            
            if let name = tbxItemAeElementChildB.attributes["name"] as? String {
                if name == "Name" {
                    if tbxItemAeElementChildB.value == aeonArcEventTitle {
                        //  print("aeon arc \(aeoneventitle) already exists")
                        return true
                    }
                }
            }
            
            
        }
        
        return false
        
    }
    
    func matchForAeonIDWithExistingTbxNoteAeonID(childAttributeElementsForTbxNote: AEXMLElement, aeonID: String)  -> Bool{
        
        
        for tbxItemAeElementChildB in childAttributeElementsForTbxNote.children {
            
            if let name = tbxItemAeElementChildB.attributes["name"] as? String {
                if name == "AeonEventID" {
                    if tbxItemAeElementChildB.value == aeonID {
                        //                        print("aeon event \(aeonID) already exists")
                        return true
                    }
                }
            }
            
            
        }
        
        return false
        
    }
    
    // ok
    
    func checkForExistingAeonArc(aeonArcAEElement: AEXMLElement) -> Bool  {
        
         let aeonarceventitle  = aeonArcAEElement.attributes["EventTitle"] as! String
        
        // search the tinderbox document for a note whose tinderbox Name attribute value
        // matches the current Aeon Event Title in aeonarceventtitle
        var weFoundMatchingTbxNote = false
        for tbxItemAEElement in self.tinderboxXmlDoc!.root["item"]["item"].all! {
            
            
            // if this for loop doesn't find a match, it's a new note
            
            for tbxItemAeElementChildA in tbxItemAEElement.children {
                
                if matchForAeonEventTitleWithExistingTbxNoteName(tbxItemAeElementChildA, aeonArcEventTitle: aeonarceventitle) {
                    weFoundMatchingTbxNote = true
                    
                    
                    // the arc's attributes
                    for aeonAttributeElement in aeonEventAEElement.children {
                        
                        let matchingTbxAttributeIndex = aeonAeonArcAttributes.indexOf(aeonAttributeElement.name)
                        let tbxAttributeNameString = aeonTbxArcAttributes[matchingTbxAttributeIndex!]
                        
                        let attribArray = tbxAttributeNameString.componentsSeparatedByString(",")
                        let tbxAttributeName = attribArray[0]
                  
                        if let aeonArcAttributeValue = aeonAttributeElement.value as String? {
                            
                            // not find the matching aeonArcxxxx name in tbx
                            for tbxItemAeElementChildB in tbxItemAeElementChildA.children {
                                
                                if let name = tbxItemAeElementChildB.attributes["name"] as? String {
                            
                                    if name == tbxAttributeName {
                                        
                                        if name == "AeonArcDescription" {
          
                                            if tbxItemAeElementChildB.value != aeonArcAttributeValue { // or other changes were made
                         
                                                var aeonArcChildTbxXmlElement = AEXMLElement("attribute")
                                                aeonArcChildTbxXmlElement.addAttribute("name", value: "Badge")
                                                aeonArcChildTbxXmlElement.value = "label yellow"
                                                tbxItemAeElementChildA.addChild(aeonArcChildTbxXmlElement)
                                                
                              
                                                var text = tbxItemAeElementChildA["text"]
                                                if text.name == "AEXMLError" {
                                                    
                                                    text = AEXMLElement("text")
                                                    text.value = " "
                                                    tbxItemAeElementChildA.addChild(text)
                                                    
                                                    
                                                }
                                                var now = getTodayDateString()
                                                var currenttext = text.value
                                                var newtext = currenttext! + "\n\n\n  ======================= \(now) =============== \n\n" + aeonArcAttributeValue
                                                text.value = newtext
                                                
                                            }
                                        }
                                        
                                        // also update desc if the value was 'no value from aeon timeline'
                                        
                                        tbxItemAeElementChildB.value = aeonArcAttributeValue
                                        
                                        
                                        
                                        break
                                        
                                    } // if you found a match to update the tbx aeon xxx field with
                                } // if you got the name
                            } // for all the attributes on the tbx element
                            
                        } // if there was value in the aeon element (then find the tbx and update it)
                        else { //otherwise
                            // still find the tbx and update it, and you are not currently doing that
                            
                            for tbxItemAeElementChildB in tbxItemAeElementChildA.children {
                                if let name = tbxItemAeElementChildB.attributes["name"] as? String {
                                    if name == tbxAttributeName {
                                        tbxItemAeElementChildB.value = "no value found"
                                        break
                                        
                                    } // if you found a match to update the tbx aeon xxx field with
                                } // if you got the name
                            }
                            
                        }
                    }
                }
                
            }
        }
        
        return true
    }
    
    func checkForExistingAeonEntity(aeonEntityAEElement: AEXMLElement) -> Bool  {
        return true
    }
    
    func checkForExistingAeonEvent(aeonEventAEElement: AEXMLElement) -> Bool  {
        
        let aeoneventid  = aeonEventAEElement.attributes["ID"] as! String
        
        // search the tinderbox document for a note whose AeonEventID attribute value
        // matches the current Aeon Event ID in aeoneventid
        var weFoundMatchingTbxNote = false
        for tbxItemAEElement in self.tinderboxXmlDoc!.root["item"]["item"].all! {
            
            // if this for loop doesn't find a match, it's a new note
            
            for tbxItemAeElementChildA in tbxItemAEElement.children {
                
                // this if test has to set a switch saying the for loop found something
                // else the for loop found nothing and it's a new note
                if matchForAeonIDWithExistingTbxNoteAeonID(tbxItemAeElementChildA, aeonID: aeoneventid) {
                    weFoundMatchingTbxNote = true
                    
                    // so we have the matching tbx note now
                    // so update the note's aeon value and attributes only
                    // array or switch
                    // remember to kill adding adornments here too--they are added only on create
                    
                    // so cycle through the aeon element on the aeon xmldoc
                    // and its child attributes
                    // match to the attributes on this tbx element's children
                    
                    // ok, I have the aeon element
                    
                    
                    
                    for aeonAttributeElement in aeonEventAEElement.children {
                        
                        // print ("aeonAttributeElement name is \(aeonAttributeElement.name)")
                        
                        let matchingTbxAttributeIndex = aeonAeonEventAttributes.indexOf(aeonAttributeElement.name)
                        // print ("Matching Tbx Attribute \(matchingTbxAttributeIndex) for \(aeonAttributeElement.name)")
                        let tbxAttributeNameString = aeonTbxEventAttributes[matchingTbxAttributeIndex!]
                        
                        let attribArray = tbxAttributeNameString.componentsSeparatedByString(",")
                        
                        
                        let tbxAttributeName = attribArray[0]
                        // print ("tbxAttributeName = \(tbxAttributeName)") // aeoneventdescription comes out here
                        
                        
                        if let aeonEventAttributeValue = aeonAttributeElement.value as String? {
                            
                            // not find the matching aeoneventxxxx name in tbx
                            for tbxItemAeElementChildB in tbxItemAeElementChildA.children {
                                
                                if let name = tbxItemAeElementChildB.attributes["name"] as? String {
                                    // print(" name is \(name)  tbxname is \(tbxAttributeName))")
                                    if name == tbxAttributeName {
                                        // print("matching name is \(name) \(aeonEventAttributeValue)")
                                        
                                        var retrieveName = ""
                                        if name == "AeonEventTitle" {
                                            retrieveName = tbxItemAeElementChildB.value!
                                            
                                            var text = tbxItemAeElementChildA["text"]
                                            if text.name == "AEXMLError" {
                                                
                                                text = AEXMLElement("text")
                                                text.value = " "
                                                tbxItemAeElementChildA.addChild(text)
                                                
                                            }
                                            
                                            var now = getTodayDateString()
                                            var currenttext = text.value
                                            var newtext = currenttext! + "\n\n\n  ======================= \(now) =============== \n\n" + aeonEventAttributeValue
                                            text.value = newtext
                                            
                                        }
                                        
                                        if name == "AeonEventDescription" {
                                            
                                            // if the tbx text here is blank or says novalue, add or update the text element too
                                            // this value could be nil:tbxItemAeElementChildB.value  -- have to acct for that
                                            if tbxItemAeElementChildB.value != aeonEventAttributeValue { // or other changes were made
                                                //print ("from tbx: \(tbxItemAeElementChildB.value) ***")
                                                //print ("from aeon: \(aeonEventAttributeValue) ***")
                                                var aeonEventChildTbxXmlElement = AEXMLElement("attribute")
                                                aeonEventChildTbxXmlElement.addAttribute("name", value: "Badge")
                                                aeonEventChildTbxXmlElement.value = "label yellow"
                                                tbxItemAeElementChildA.addChild(aeonEventChildTbxXmlElement)
                                                
                                                // get the <text> element from the <event>.children
                                                var text = tbxItemAeElementChildA["text"]
                                                if text.name == "AEXMLError" {
                                                    
                                                    text = AEXMLElement("text")
                                                    text.value = " "
                                                    tbxItemAeElementChildA.addChild(text)
                                                    
                                                    
                                                }
                                                var now = getTodayDateString()
                                                var currenttext = text.value
                                                var newtext = currenttext! + "\n\n\n  ======================= \(now) =============== \n\n" + aeonEventAttributeValue
                                                text.value = newtext
                                                
                                            }
                                        }
                                        
                                        // also update desc if the value was 'no value from aeon timeline'
                                        
                                        tbxItemAeElementChildB.value = aeonEventAttributeValue
                                        
                                        
                                        
                                        break
                                        
                                    } // if you found a match to update the tbx aeon xxx field with
                                } // if you got the name
                            } // for all the attributes on the tbx element
                            
                        } // if there was value in the aeon element (then find the tbx and update it)
                        else { //otherwise
                            // still find the tbx and update it, and you are not currently doing that
                            
                            for tbxItemAeElementChildB in tbxItemAeElementChildA.children {
                                if let name = tbxItemAeElementChildB.attributes["name"] as? String {
                                    if name == tbxAttributeName {
                                        tbxItemAeElementChildB.value = "no value found"
                                        break
                                        
                                    } // if you found a match to update the tbx aeon xxx field with
                                } // if you got the name
                            }
                            
                        }
                        
                    } // for tbx elements search loop
                    
                    
                } // if you get aeonEventAttributeValue
                
                
            } // for children of the element
            
            
            
            
            
        } // for doc all loop
        
        if weFoundMatchingTbxNote {
            return true
        } else {
            return false
        }
    }
    
    func addAeonAttributesToTinderboxDoc() {
        
        var error: NSError?
        
        if let tbxXmlDoc = AEXMLDocument(xmlData: self.tbxdata, error: &error) {
            
            self.tinderboxXmlDoc = tbxXmlDoc
            
            captureTbxUserElement(tbxXmlDoc)
            captureOrCreateTASCItem(tbxXmlDoc)
            
            addAdornmentsToTASCItem(tbxXmlDoc, adornmentsArray: self.aeonEventsTbxAdornmentAttributeElements)
            addAdornmentsToTASCItem(tbxXmlDoc, adornmentsArray: self.aeonArcsTbxAdornmentAttributeElements)
            addAdornmentsToTASCItem(tbxXmlDoc, adornmentsArray: self.aeonEntitiesTbxAdornmentAttributeElements)
            
            addPrototypeToTASCItem(tbxXmlDoc)
            
            
            var error: NSError?
            var aeonEventPreExists = false
            var aeonArcPreExists = false
            var aeonEntityPreExists = false
            
            if let aeonXmlDoc = AEXMLDocument(xmlData: self.aeondata, error: &error) {
                
                existingTascChildrenCount = tascBaseContainer.children.count
                
                
                // get the events
                for aeonEventAEElement in aeonXmlDoc.root["Events"]["Event"].all! {
                    
                    aeonEventPreExists = checkForExistingAeonEvent(aeonEventAEElement)
                    
                    if !aeonEventPreExists {
                        
                        self.aeonEventTbxXmlElement = AEXMLElement("item")
                        self.aeonEventAEElement = aeonEventAEElement
                        
                        captureAeonEventElement(aeonXmlDoc)
                        captureAeonEventElementChildren(aeonXmlDoc)
                        addTinderboxAttributesToAeonEventElement(aeonXmlDoc)
                        
                        //    var anewone = self.aeonEventTbxXmlElement
                        //  var tascbasecontainer = self.tascBaseContainer
                        
                        
                        self.tascBaseContainer.addChild( self.aeonEventTbxXmlElement)
                    }
                    
                }
                
                
                for aeonArcAEElement in aeonXmlDoc.root["Arcs"]["Arc"].all! {
                    
                    aeonArcPreExists = checkForExistingAeonArc(aeonArcAEElement)
                    
                    if !aeonArcPreExists {
                        
                        self.aeonArcTbxXmlElement = AEXMLElement("item")
                        self.aeonArcAEElement = aeonArcAEElement
                        
                        captureAeonArcElement(aeonXmlDoc)
                        captureAeonArcElementChildren(aeonXmlDoc)
                        addTinderboxAttributesToAeonArcElement(aeonXmlDoc)
                        
                        self.tascBaseContainer.addChild(self.aeonArcTbxXmlElement)
                        
                    }
                }
                
                // get the entities
                for aeonEntityAEElement in aeonXmlDoc.root["Entities"]["Entity"].all! {
                    
                    aeonEntityPreExists = checkForExistingAeonEntity(aeonEntityAEElement)
                    
                    if !aeonEntityPreExists {
                        
                        self.aeonEntityTbxXmlElement = AEXMLElement("item")
                        self.aeonEntityAEElement = aeonEntityAEElement
                        
                        captureAeonEntityElement(aeonXmlDoc)
                        captureAeonEntityElementChildren(aeonXmlDoc)
                        addTinderboxAttributesToAeonEntityElement(aeonXmlDoc)
                        
                        self.tascBaseContainer.addChild(self.aeonEntityTbxXmlElement)
                        
                    }
                    
                    
                }
                
                
            }
            
            var i = tascBaseContainer.children.count
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
    
    
    
    
    func writeTinderboxXMLDocument() {
        
        
        addAeonAttributesToTinderboxDoc()
        
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
    
    func addAeonTimelineArcAttribs(aeonArcAttribElement : AEXMLElement) {
        
        
        
        for attrib in aeonTbxArcAttributes {
            
            let attribArray = attrib.componentsSeparatedByString(",")
            
            let aeArcAttribElement = AEXMLElement("attrib")
            
            aeArcAttribElement.addAttribute("parent", value: "User")
            aeArcAttribElement.addAttribute("Name", value: attribArray[0])
            aeArcAttribElement.addAttribute("editable", value: attribArray[2])
            aeArcAttribElement.addAttribute("visibleInEditor", value: "1")
            aeArcAttribElement.addAttribute("type", value: attribArray[1])
            aeArcAttribElement.addAttribute("default", value: "")
            
            
            aeonArcAttribElement.addChild(aeArcAttribElement)
            
        }
        
    }
    
    func addAeonTimelineEntityAttribs(aeonEntityAttribElement : AEXMLElement) {
        
        
        
        for attrib in aeonTbxEntityAttributes {
            
            let attribArray = attrib.componentsSeparatedByString(",")
            
            let aeEntityAttribElement = AEXMLElement("attrib")
            
            aeEntityAttribElement.addAttribute("parent", value: "User")
            aeEntityAttribElement.addAttribute("Name", value: attribArray[0])
            aeEntityAttribElement.addAttribute("editable", value: attribArray[2])
            aeEntityAttribElement.addAttribute("visibleInEditor", value: "1")
            aeEntityAttribElement.addAttribute("type", value: attribArray[1])
            aeEntityAttribElement.addAttribute("default", value: "")
            
            
            aeonEntityAttribElement.addChild(aeEntityAttribElement)
            
        }
        
    }
    
    func addAeonTimelineEventTagAttribs(aeonEventTagAttribElement : AEXMLElement) {
        
        for attrib in aeonTbxEventTagAttributes {
            
            let attribArray = attrib.componentsSeparatedByString(",")
            
            let aeTagAttribElement = AEXMLElement("attrib")
            
            aeTagAttribElement.addAttribute("parent", value: "User")
            aeTagAttribElement.addAttribute("Name", value: attribArray[0])
            aeTagAttribElement.addAttribute("editable", value: attribArray[2])
            aeTagAttribElement.addAttribute("visibleInEditor", value: "1")
            aeTagAttribElement.addAttribute("type", value: attribArray[1])
            aeTagAttribElement.addAttribute("default", value: "")
            
            aeonEventTagAttribElement.addChild(aeTagAttribElement)
            
        }
        
    }
    
    func addAeonTimelineEventRelationshipAttribs(aeonEventRelationshipAttribElement : AEXMLElement) {
        
        
        
        
        for attrib in aeonTbxEventRelationshipAttributes {
            
            let attribArray = attrib.componentsSeparatedByString(",")
            
            let aeEventRelationshipAttribElement = AEXMLElement("attrib")
            
            aeEventRelationshipAttribElement.addAttribute("parent", value: "User")
            aeEventRelationshipAttribElement.addAttribute("Name", value: attribArray[0])
            aeEventRelationshipAttribElement.addAttribute("editable", value: attribArray[2])
            aeEventRelationshipAttribElement.addAttribute("visibleInEditor", value: "1")
            aeEventRelationshipAttribElement.addAttribute("type", value: attribArray[1])
            aeEventRelationshipAttribElement.addAttribute("default", value: "")
            
            
            aeonEventRelationshipAttribElement.addChild(aeEventRelationshipAttribElement)
            
        }
        
    }
    
}
