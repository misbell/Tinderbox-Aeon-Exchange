//
//  ViewController.swift
//  Tinderbox-Aeon-Exchange
//
//  Created by Michael Prenez-Isbell on 6/24/15.
//  Copyright (c) 2015 Michael Prenez-Isbell. All rights reserved.
//

import Cocoa

class ViewController: NSViewController,  NSXMLParserDelegate {
    
    
    @IBOutlet weak var textViewTinderbox: TASCTextViewTB!
    
    @IBOutlet weak var textViewAeon: TASCTextViewAE!
    
    
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
            let xmlParser = NSXMLParser(contentsOfURL: openPanel.URL!)
            xmlParser!.delegate = self
            xmlParser!.parse()
            
        }
     
        // aeonxml
        
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String]) {
        print("Element's name is \(elementName)")
        print("Element's attributes are \(attributeDict)")
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
            let xmlParser = NSXMLParser(contentsOfURL: openPanel.URL!)
            xmlParser!.delegate = self
            xmlParser!.parse()
            
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

