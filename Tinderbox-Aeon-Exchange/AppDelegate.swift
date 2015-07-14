//
//  AppDelegate.swift
//  Tinderbox-Aeon-Exchange
//
//  Created by Michael Prenez-Isbell on 6/24/15.
//  Copyright (c) 2015 Michael Prenez-Isbell. All rights reserved.
//

import Cocoa
import CloudKit


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    
    var mainViewController: ViewController?
    


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        let container = CKContainer.defaultContainer()
        let publicDatabase = container.publicCloudDatabase
        let privateDatabase = container.privateCloudDatabase
        
        let i = 0
        
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

