//
//  OutlineViewController.swift
//  Tinderbox-Aeon-Exchange
//
//  Created by prenez on 6/27/15.
//  Copyright © 2015 Michael Prenez-Isbell. All rights reserved.
//

import Foundation
import AppKit


class OutlineViewControllerTbx  : NSObject {
    
    var tbxItems: Array<TbxItem> = []
    
    // designated
    override init() {
        super.init()

    }
    
}

extension OutlineViewControllerTbx : NSOutlineViewDataSource {


    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
        
        return (item == nil) ? self.tbxItems.count : (item as! TbxItem).children.count
        
    } 
    
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
        
        // if item is nil, this will break
        
        return (item as! TbxItem).children.count != 0

    }//
    
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
        
        return (item == nil) ? self.tbxItems[index] : (item as! TbxItem).children[index]

        
    }
    
    func outlineView(outlineView: NSOutlineView, objectValueForTableColumn tableColumn: NSTableColumn?, byItem item: AnyObject?) -> AnyObject? {
        
        // heres where we decide which properties on object we want to display
        // to do this have to set the identifier on the column for the outlinevie
        // in interfacebuilder
        
        if tableColumn?.identifier == "name" {
            return (item as! TbxItem).name
            
        }
        
        if tableColumn?.identifier == "value" {
            return (item as! TbxItem).value
            
        }
        
        return "no column";
        
    }
    

}

extension OutlineViewControllerTbx: NSOutlineViewDelegate {
    func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        
        if tableColumn?.identifier == "name" {
            let cell : NSTableCellView = outlineView.makeViewWithIdentifier("tbxNameCellView", owner: self) as! NSTableCellView
            cell.textField?.stringValue = (item as! TbxItem).name
            // cell.imageViewCell.image = xxx
            return cell
            
        }
        
        if tableColumn?.identifier == "value" {
            let cell : NSTableCellView = outlineView.makeViewWithIdentifier("tbxValueCellView", owner: self) as! NSTableCellView
            cell.textField?.stringValue = String((item as! TbxItem).value)
            // cell.imageViewCell.image = xxx
            return cell
            
        }
        
        return nil
        
    }
}

