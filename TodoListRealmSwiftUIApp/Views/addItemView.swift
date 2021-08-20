//
//  AddItemView.swift
//  TodoAppWithRealm
//
//  Created by Satoshi Kawakami on 2021/08/16.
//

import SwiftUI

struct AddItemView: View {
    
    @EnvironmentObject var model: ItemViewModel
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Title")) {
                    TextField("", text: $model.title)
                }
                
                Section(header: Text("Detail")) {
                    TextField("", text: $model.detail)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(model.updateObject == nil ? "Add Item" : "Edit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        model.addData(presentation: presentation)
                    }, label: {
                        Text("Done")
                    })
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
            }
        }
        .onAppear(perform: model.setUpInitialData)
        .onDisappear(perform: model.deInitData)
    }
}
