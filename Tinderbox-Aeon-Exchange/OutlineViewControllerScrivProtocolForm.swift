//
//  OutlineViewControllerScrivProtocolForm.swift
//  Tinderbox-Aeon-Exchange
//
//  Created by prenez on 6/28/15.
//  Copyright © 2015 Michael Prenez-Isbell. All rights reserved.
//

import Cocoa

class OutlineViewControllerScrivProtocolForm: NSObject, NSOutlineViewDataSource,NSOutlineViewDelegate {

}

//
//  OutlineViewControllerScrivener.swift
//  Tinderbox-Aeon-Exchange
//
//  Created by prenez on 6/28/15.
//  Copyright © 2015 Michael Prenez-Isbell. All rights reserved.
//


import Foundation
import AppKit


class OutlineViewControllerScriv  : NSObject {
    
    var scrivenerItems: Array<ScrivenerItem> = []
    
    // designated
    override init() {
        super.init()
        
    }
    


    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        
        return (item == nil) ? self.scrivenerItems.count : (item as! ScrivenerItem).children.count
        
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        
        // if item is nil, this will break
        
        return (item as! ScrivenerItem).children.count != 0
        
    }//
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        
        return (item == nil) ? self.scrivenerItems[index] : (item as! ScrivenerItem).children[index]
        
        
    }
    
    func outlineView(outlineView: NSOutlineView, objectValueForTableColumn tableColumn: NSTableColumn?, byItem item: AnyObject?) -> AnyObject? {
        
        // heres where we decide which properties on object we want to display
        // to do this have to set the identifier on the column for the outlinevie
        // in interfacebuilder
        
        if tableColumn?.identifier == "name" {
            return (item as! ScrivenerItem).name
            
        }
        
        if tableColumn?.identifier == "value" {
            return (item as! ScrivenerItem).value
            
        }
        
        return "no column";
        
    }
    

    func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        
        if tableColumn?.identifier == "name" {
            let cell : NSTableCellView = outlineView.makeViewWithIdentifier("scrivNameCellView", owner: self) as! NSTableCellView
            cell.textField?.stringValue = (item as! AeonItem).name
            // cell.imageViewCell.image = xxx
            return cell
            
        }
        
        if tableColumn?.identifier == "value" {
            let cell : NSTableCellView = outlineView.makeViewWithIdentifier("scrivValueCellView", owner: self) as! NSTableCellView
            cell.textField?.stringValue = String((item as! AeonItem).value)
            // cell.imageViewCell.image = xxx
            return cell
            
        }
        
        return nil
        
    }
}

