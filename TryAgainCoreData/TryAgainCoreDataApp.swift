//
//  TryAgainCoreDataApp.swift
//  TryAgainCoreData
//
//  Created by David Power on 19/5/21.
//

import SwiftUI

@main
struct TryAgainCoreDataApp: App {
    
    @StateObject var todoManager = ToDoListManager()
    @State var isPresented = false
    
    var body: some Scene {
        WindowGroup {
            ToDoListView(todoManager: todoManager)
        }
    }
}
