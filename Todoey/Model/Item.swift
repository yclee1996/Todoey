//
//  Item.swift
//  Todoey
//
//  Created by yuchi.lee on 2019/7/1.
//  Copyright © 2019 Yuchi Lee. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var date : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
