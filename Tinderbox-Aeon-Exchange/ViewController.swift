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
    
    
    @IBOutlet weak var outlineViewTinderbox: TASCOutlineViewTinderbox!
    
    @IBOutlet weak var outlineViewAeon: TASCOutlineViewAeon!
    
    
    required   init?(coder: NSCoder) {
        super.init(coder: coder)
        parseAeon = false
        parseTbx = false
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
        
        if let _  = openPanel.URL {
            print("file found")
            parseAeon = true
            
          //  textViewAeon.string = "hello, world"

            let xmlParser = NSXMLParser(contentsOfURL: openPanel.URL!)
            xmlParser!.delegate = self
            xmlParser!.parse()
            parseAeon = false
            
        }
        
        // retry the completion handler version
     
        // aeonxml
        //test
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String]) {
        //print("Element's name is \(elementName)")
        //print("Element's attributes are \(attributeDict)")
        
        if parseAeon! {
            print("parseaeon")
            let str = "Element's name is \(elementName) \n Element's attributes are \(attributeDict) \n"
            textViewAeon.textStorage?.mutableString.appendString(str)
        }
        if parseTbx! {
            print("parsetinderbox")
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
        
        if let _  = openPanel.URL {
            print("file found")
            parseTbx = true
            
            let xmlParser = NSXMLParser(contentsOfURL: openPanel.URL!)
            xmlParser!.delegate = self
            xmlParser!.parse()
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

