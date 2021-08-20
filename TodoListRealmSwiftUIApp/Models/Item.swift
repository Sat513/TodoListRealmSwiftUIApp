//
//  Item.swift
//  TodoAppWithRealm
//
//  Created by Satoshi Kawakami on 2021/08/15.
//

import SwiftUI
import RealmSwift

class Item: Object, Identifiable {
    @objc var id: Date = Date()
    @objc var title = ""
    @objc var detail = ""
}
