//
//  ItemViewModel.swift
//  TodoAppWithRealm
//
//  Created by Satoshi Kawakami on 2021/08/16.
//

import SwiftUI
import RealmSwift

class ItemViewModel: ObservableObject {
    @Published var title = ""
    @Published var detail = ""
    
    @Published var isOpen = false
    
    @Published var items: [Item] = []
    
    @Published var updateObject: Item?
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard let realm = try? Realm() else {
            return
        }
        
        let results = realm.objects(Item.self)
        print(results)
        self.items = results.compactMap({ (item) -> Item? in
            return item
        })
    }
    
    func addData(presentation: Binding<PresentationMode>) {
        if title == "" || detail == "" { return }
        
        let item = Item()
        item.title = title
        item.detail = detail
        
        guard let realm = try? Realm() else {
            return
        }
        
        try? realm.write {
            guard let availableObject = updateObject else {
                realm.add(item)
                
                return
            }
            
            availableObject.title = title
            availableObject.detail = detail
        }
        fetchData()
        
        presentation.wrappedValue.dismiss()
    }
    
    func deleteData(Object: Item) {
        guard let realm = try? Realm() else {
            return
        }
        
        try? realm.write {
            realm.delete(Object)
            
            fetchData()
        }
    }
    
    func setUpInitialData() {
        guard let updateData = updateObject else {
            return
        }
        
        title = updateData.detail
        detail = updateData.detail
    }
    
    func deInitData() {
        updateObject = nil
        title = ""
        detail = ""
    }
    
    
}
