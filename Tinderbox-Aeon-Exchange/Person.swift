//
//  Person.swift
//  Tinderbox-Aeon-Exchange
//
//  Created by prenez on 6/27/15.
//  Copyright © 2015 Michael Prenez-Isbell. All rights reserved.
//

import Foundation

/* struct
value type
can't inherit
no type casting or checking at runtime
no deinit
no reference counting, so no multiple references to an instance (always a copy)
*/


class Person {
    
    var name: String
    var children: Array<Person>
    var age: Int
    
    //default
 //    init () {
 //
 //       self.name = "test name"
 //       self.age = 25
 //       self.children = []
 //
 //   }
    
    //designated
    init(name: String, age: Int, children: Array<Person>) {
        
      
        self.name = name
        self.age = age
        self.children = []
        
    }
    
    //convenience
    convenience init (aname: String) {
        
        self.init(name: aname, age: 25, children: [])

        
    }
    
    func addChild(p: Person) -> (Void) {
        
        children.append(p)
        
    }
    
}