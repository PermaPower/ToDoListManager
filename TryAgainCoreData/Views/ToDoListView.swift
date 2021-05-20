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
                            ToDoListDetailView(todoManager: todoManager, item: item),
                        label: {
                            Button(item.name) {
                                       showingSheet.toggle()
                                   }
                                   
                        })
                        
                }
                .onDelete(perform: { indexSet in
                    todoManager.delete(at: indexSet)
                })
                .onMove(perform: { indices, newOffset in
                    todoManager.move(indices: indices, newOffset: newOffset)
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
            ToDoListView(todoManager: ToDoListManager.emptyState())
        }
    }
}
