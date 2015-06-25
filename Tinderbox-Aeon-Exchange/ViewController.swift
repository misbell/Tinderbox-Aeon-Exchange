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
        
        println("well done ae")
        
        let openFileTypes = ["aeonxml"]
        
        var openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedFileTypes = openFileTypes
        
        openPanel.directoryURL = NSURL(fileURLWithPath: "/Users/mprenez-isbell/Dropbox/___aeon/",isDirectory: false)
        let urls = openPanel.URLs
        let result = openPanel.runModal()
        
        if let chosenfile = openPanel.URL {
            println("file found")
            var xmlParser = NSXMLParser(contentsOfURL: openPanel.URL)
            xmlParser!.delegate = self
            xmlParser!.parse()
            
        }
     
        // aeonxml
        
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        println("Element's name is \(elementName)")
        println("Element's attributes are \(attributeDict)")
    }


    
    
    @IBAction func loadTinderboxXmlDocument(sender: AnyObject) {
        
        println("well done tb")
        
        let openFileTypes = ["tbx"]
        
        var openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedFileTypes = openFileTypes
        
        openPanel.directoryURL = NSURL(fileURLWithPath: "/Users/mprenez-isbell/Dropbox/___tbx6/",isDirectory: false)
        let urls = openPanel.URLs
        let result = openPanel.runModal()

        if let chosenfile = openPanel.URL {
            println("file found")
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

