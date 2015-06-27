//
//  ViewController.swift
//  Tinderbox-Aeon-Exchange
//
//  Created by Michael Prenez-Isbell on 6/24/15.
//  Copyright (c) 2015 Michael Prenez-Isbell. All rights reserved.
//

import Cocoa

class ViewController: NSViewController,  NSXMLParserDelegate {
    
    var parseTbx : Bool?
    var parseAeon : Bool?
    
    
    @IBOutlet var textViewTinderbox: TASCTextViewTB!
    @IBOutlet var textViewAeon: TASCTextViewAE!
    
    
    @IBOutlet weak var ovTinderbox: NSOutlineView!
    
    @IBOutlet weak var ovAeon: NSOutlineView!


    @IBOutlet var ovc: OutlineViewController!
    
    
    var people: Array<Person> = []
    
    required   init?(coder: NSCoder) {
        super.init(coder: coder)
        parseAeon = false
        parseTbx = false
        
        let boss = Person(name: "yoda", age: 900, children: [])
        boss.addChild(Person(name:"stephan", age: 25, children:[]))
        boss.addChild(Person(name:"kara", age: 19, children:[]))
        boss.addChild(Person(name:"jesse", age: 18, children:[]))
        
        let p = (boss.children)[0]
        p.addChild(Person(name:"sue", age: 18, children:[]))
        
        let pp = (boss.children)[1]
        
        
        pp.addChild(Person(name:"adam", age: 21, children:[]))
        
        // add all this to the array property
        // this will be our datasource for the treeview
        self.people.append(boss)
    }
    
    @IBAction func loadAeonXmlDocument(sender: AnyObject) {
        
        print("well done ae")
        
        let openFileTypes = ["aeonxml"]
        
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedFileTypes = openFileTypes
        
        openPanel.directoryURL = NSURL(fileURLWithPath: "/Users/mprenez-isbell/Dropbox/___aeon/",isDirectory: false)
        let _ = openPanel.URLs
        let _ = openPanel.runModal()
        
        if let chosenfile  = openPanel.URL {
            print("file found")
            parseAeon = true
            
            //  textViewAeon.string = "hello, world"
            
            let xmlParser = NSXMLParser(contentsOfURL: openPanel.URL!)
            xmlParser!.delegate = self
            xmlParser!.parse()
            parseAeon = false
            
            var error: NSError?
            
            //let text2 = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)
            let path = chosenfile.path!
            let data: NSData = NSFileManager.defaultManager().contentsAtPath(path)!
            //var str : NSString = NSString(data: vara, encoding: NSUTF8StringEncoding)!
            
            if let xmlDoc = AEXMLDocument(xmlData: data, error: &error) {
                
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
        
        // retry the completion handler version
        
        // aeonxml
        //test
        
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
    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String]) {
        //print("Element's name is \(elementName)")
        //print("Element's attributes are \(attributeDict)")
        
        if parseAeon! {
            //print("parseaeon")
            let str = "Element's name is \(elementName) \n Element's attributes are \(attributeDict) \n"
            textViewAeon.textStorage?.mutableString.appendString(str)
        }
        if parseTbx! {
            // print("parsetinderbox")
            let str = "Element's name is \(elementName) \n Element's attributes are \(attributeDict) \n"
            textViewTinderbox.textStorage?.mutableString.appendString(str)
        }
    }
    
    
    
    
    @IBAction func loadTinderboxXmlDocument(sender: AnyObject) {
        
        print("well done tb")
        
        let openFileTypes = ["tbx"]
        
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedFileTypes = openFileTypes
        
        openPanel.directoryURL = NSURL(fileURLWithPath: "/Users/mprenez-isbell/Dropbox/___tbx6/",isDirectory: false)
        let _ = openPanel.URLs
        let _ = openPanel.runModal()
        
        if let chosenfile  = openPanel.URL {
            print("file found")
            parseTbx = true
            
            //  textViewAeon.string = "hello, world"
            
            let xmlParser = NSXMLParser(contentsOfURL: openPanel.URL!)
            xmlParser!.delegate = self
            xmlParser!.parse()
            parseAeon = false
            
            var error: NSError?
            
            //let text2 = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)
            let path = chosenfile.path!
            let data: NSData = NSFileManager.defaultManager().contentsAtPath(path)!
            // var str: NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
            
            if let xmlDoc = AEXMLDocument(xmlData: data, error: &error) {
                
              //  var itemelement = AEXMLElement("item", value: "")
                
                var firstelement = xmlDoc.root["item"]
                print (xmlDoc.root["item"].stringValue)
                
                var firstitem =  xmlDoc.root["attrib"].countWithAttributes(["Name" : "Item"])
                
                xmlDoc.root["attrib"].countWithAttributes(["Name" : "Item"])
                
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
            
            
            //   let xmlParser = NSXMLParser(contentsOfURL: openPanel.URL!)
            //   xmlParser!.delegate = self
            //   xmlParser!.parse()
            parseTbx = false
            
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}



extension ViewController : NSOutlineViewDataSource {
    
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        
        return (item == nil) ? self.people.count : (item as! Person).children.count
        
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        
        // if item is nil, this will break
        
        return (item as! Person).children.count != 0
        
    }
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        
        return (item == nil) ? self.people[index] : (item as! Person).children[index]
        
        
    }
    
    func outlineView(outlineView: NSOutlineView, objectValueForTableColumn tableColumn: NSTableColumn?, byItem item: AnyObject?) -> AnyObject? {
        
        // heres where we decide which properties on object we want to display
        // to do this have to set the identifier on the column for the outlinevie
        // in interfacebuilder
        
        
    // THIS IS ONLY USED FOR CELL BASED TABLE AND OUTLINE VIEWS
    // BUT THIS IS A VIEW BASED OUTLINE VIEW SO SEE DELEGATE METHOD BELOW

        
        if tableColumn?.identifier == "name" {
            print( (item as! Person).name)
            return (item as! Person).name as NSString
            
        }
        
        if tableColumn?.identifier == "age" {
            print( (item as! Person).age)
            return (item as! Person).age as NSNumber
            
        }
        
        return "no column";
        
    }
    

    
}

extension ViewController: NSOutlineViewDelegate {
    func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        
        // this is used for VIEW BASED OUTLINE VIEWS, which is what this is
        
        if tableColumn?.identifier == "name" {
            let cell : NSTableCellView = outlineView.makeViewWithIdentifier("tbxNameCellView", owner: self) as! NSTableCellView
            cell.textField?.stringValue = (item as! Person).name
            // cell.imageViewCell.image = xxx
            return cell
            
        }

        
        if tableColumn?.identifier == "age" {
            let cell : NSTableCellView = outlineView.makeViewWithIdentifier("tbxAgeCellView", owner: self) as! NSTableCellView
            cell.textField?.stringValue = String((item as! Person).age)
            // cell.imageViewCell.image = xxx
            return cell
            
        }
        
        return nil
        
    }
    
}


