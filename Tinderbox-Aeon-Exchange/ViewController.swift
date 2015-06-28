//
//  ViewController.swift
//  Tinderbox-Aeon-Exchange
//
//  Created by Michael Prenez-Isbell on 6/24/15.
//  Copyright (c) 2015 Michael Prenez-Isbell. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var parseTbx : Bool?
    var parseAeon : Bool?
    
    
    @IBOutlet var textViewTinderbox: TASCTextViewTB!
    @IBOutlet var textViewAeon: TASCTextViewAE!
    
    
    @IBOutlet weak var ovTinderbox: NSOutlineView!
    
    @IBOutlet weak var ovAeon: NSOutlineView!
    
    
    @IBOutlet var outlineViewControllerTbx: OutlineViewControllerTbx!

    @IBOutlet var outlineViewControllerAeon: OutlineViewControllerAeon!
    
    
    var people: Array<Person> = []
    
    required   init?(coder: NSCoder) {
        super.init(coder: coder)
        parseAeon = false
        parseTbx = false
        let appDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.mainViewController = self

    }
    
    @IBAction func loadAeonXmlDocument(sender: AnyObject) {
    }
    
    /*
    
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
            
//xmldoc
            
        }
        
        // retry the completion handler version
        
        // aeonxml
        //test
        
    }
    */

    
    

    
    
    
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
        
        if let fileurl  = openPanel.URL {
   
            if let xmlParserTbx = XMLParserTbx(contentPath: fileurl  ) {
                xmlParserTbx.parse()
                
            }
            else {
                
            }

        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        var x = outlineViewControllerTbx.tbxItems
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}





