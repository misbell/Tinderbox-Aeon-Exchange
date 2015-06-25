//
//  ViewController.swift
//  Tinderbox-Aeon-Exchange
//
//  Created by Michael Prenez-Isbell on 6/24/15.
//  Copyright (c) 2015 Michael Prenez-Isbell. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    
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
        }
        
              
        // aeonxml
        
        
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

