//
//  ToDoListView.swift
//  TryAgainCoreData
//
//  Created by David Power on 19/5/21.
//

import SwiftUI

struct ToDoListView: View {
            
    @ObservedObject var todoManager: ToDoListManager
    
    @State private var showingSheet = false

    var body: some View {
        
        NavigationView{
            List {
                ForEach(todoManager.items) { item in
                    NavigationLink(
                        destination:
                            ToDoListDetailView(todoManager: todoManager, item: item, itemName: item.name ?? "Missing Name"),
                        label: {
                            Button(item.name ?? "Name Missing") {
                                       showingSheet.toggle()
                                   }
                                   
                        })
                        
                }
                .onDelete(perform: { indexSet in
                    todoManager.delete(at: indexSet)
                })
            }.navigationBarTitle(Text("ToDo's"), displayMode: .large)
            .toolbar(content: {
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    EditButton()
                    
                    Button (action: {
                        todoManager.addItem()
                    }
                    , label: {
                        Image(systemName: "plus")
                    })
                }
            })
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ToDoListView(todoManager: ToDoListManager.fullState())
                .previewDisplayName("fullstate")
            
            ToDoListView(todoManager: ToDoListManager.emptyState())
                .previewDisplayName("emptyState")
        }
    }
}
