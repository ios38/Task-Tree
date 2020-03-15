//
//  Task.swift
//  Task Tree
//
//  Created by Maksim Romanov on 15.03.2020.
//  Copyright © 2020 Maksim Romanov. All rights reserved.
//

import Foundation

class Task {
    var name: String
    var children: [Task]

    init(name: String, children: [Task]) {
        self.name = name
        self.children = children
    }
}
