//
//  ToDoListManager.swift
//  TryAgainCoreData
//
//  Created by David Power on 19/5/21.
//

import Foundation

class ToDoListManager: ObservableObject {
    
    @Published var items: [Item] = [
            Item(id: UUID(), name: "First"),
            Item(id: UUID(), name: "Second"),
            Item(id: UUID(), name: "Third")
        ]
    
    init(isForTest: Bool = false) {
        // Get my data and set it to my items array
        
        // isForTest default is false otherwise
        if !isForTest {
            
        }
    }
    
    func move(indices: IndexSet, newOffset: Int) {
        items.move(fromOffsets: indices, toOffset: newOffset)
    }
    
    func addItem() {
        items.append(Item(id: UUID(), name: "New Item"))
    }
    
    func delete(at indexSet: IndexSet) {
        for index in indexSet {
            items.remove(at: index)
        }
    }
    
    func update(name: String, item: Item) {
        
        let index = items.firstIndex(where: { $0.id == item.id })
            items[index ?? 0].name = name
        }
    
    static func emptyState() -> ToDoListManager {
        let manager = ToDoListManager()
        manager.items = []
        return manager
    }
    
    static func fullState() -> ToDoListManager {
        let manager = ToDoListManager(isForTest: true)
        manager.items = [
            Item(id: UUID(), name: "First"),
            Item(id: UUID(), name: "Second"),
            Item(id: UUID(), name: "Third")
        ]
        return manager
    }
}
