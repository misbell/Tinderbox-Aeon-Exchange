//
//  OutlineViewController.swift
//  Tinderbox-Aeon-Exchange
//
//  Created by prenez on 6/27/15.
//  Copyright © 2015 Michael Prenez-Isbell. All rights reserved.
//

import Foundation
import AppKit


class OutlineViewControllerAeon  : NSObject {
    
    var aeonItems: Array<AeonItem> = []
    
    // designated
    override init() {
        super.init()

    }
    
}

extension OutlineViewControllerAeon : NSOutlineViewDataSource {
    
    
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        
        return (item == nil) ? self.aeonItems.count : (item as! AeonItem).children.count
        
    }
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        
        // if item is nil, this will break
        
        return (item as! AeonItem).children.count != 0
        
    }//
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        
        return (item == nil) ? self.aeonItems[index] : (item as! AeonItem).children[index]
        
        
    }
    
    func outlineView(outlineView: NSOutlineView, objectValueForTableColumn tableColumn: NSTableColumn?, byItem item: AnyObject?) -> AnyObject? {
        
        // heres where we decide which properties on object we want to display
        // to do this have to set the identifier on the column for the outlinevie
        // in interfacebuilder
        
        if tableColumn?.identifier == "name" {
            return (item as! AeonItem).name
            
        }
        
        if tableColumn?.identifier == "value" {
            return (item as! AeonItem).value
            
        }
        
        return "no column";
        
    }
    
    
}

extension OutlineViewControllerAeon: NSOutlineViewDelegate {
    func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        
        if tableColumn?.identifier == "name" {
            let cell : NSTableCellView = outlineView.makeViewWithIdentifier("aeonNameCellView", owner: self) as! NSTableCellView
            cell.textField?.stringValue = (item as! AeonItem).name
            // cell.imageViewCell.image = xxx
            return cell
            
        }
        
        if tableColumn?.identifier == "value" {
            let cell : NSTableCellView = outlineView.makeViewWithIdentifier("aeonValueCellView", owner: self) as! NSTableCellView
            cell.textField?.stringValue = String((item as! AeonItem).value)
            // cell.imageViewCell.image = xxx
            return cell
            
        }
        
        return nil
        
    }
}

