//
//  Category.swift
//  Todoey
//
//  Created by Jake Garcia on 8/15/19.
//  Copyright © 2019 Jake Garcia. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
