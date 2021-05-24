//
//  ToDoListManager.swift
//  TryAgainCoreData
//
//  Created by David Power on 19/5/21.
//

import Foundation
import CoreData

class ToDoListManager: ObservableObject {
    
    let container: NSPersistentContainer
    
    @Published var items: [ItemEntity] = []
    
    init(isForTest: Bool = false) {
        // Get my data and set it to my items array
        container = NSPersistentContainer(name: "Data")
        
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data \(error.localizedDescription)")
            } else {
                print ("Successfully loaded Core Data")
                self.fetchData()
            }
        }
        
        // isForTest default is false otherwise
        if !isForTest {
            
            container.loadPersistentStores { (description, error) in
                if let error = error {
                    print("Error loading Core Data \(error.localizedDescription)")
                } else {
                    print ("Successfully loaded Core Data")
                    self.fetchData()
                }
            }
            
        }
    }
    
    func fetchData() {
        let request = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
    
        do {
            items = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Core Data \(error.localizedDescription)")
        }
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchData()
        } catch let error {
            print ("Error saving Core Data \(error.localizedDescription)")
        }
    }
    
    func addItem() {
        let newPlant = ItemEntity(context: container.viewContext)
        newPlant.name = "New Item"
        newPlant.id = UUID()
        saveData()
    }
    
    func delete(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = items[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func update(item: ItemEntity, itemName: String) {
        
        let currentID = item.id ?? UUID()
        item.name = itemName
        item.id = currentID
        saveData()
        }
    
    static func emptyState() -> ToDoListManager {
        let manager = ToDoListManager()
        manager.items = []
        return manager
    }
    
    static func fullState() -> ToDoListManager {
        
        let manager = ToDoListManager(isForTest: true)

        let newPlant = ItemEntity(context: manager.container.viewContext)
        
        newPlant.name = "New Item"
        newPlant.id = UUID()
        
        manager.saveData()
            
        return manager
    }
}
