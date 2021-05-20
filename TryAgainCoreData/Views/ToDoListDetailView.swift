//
//  ToDoListDetailView.swift
//  TryAgainCoreData
//
//  Created by David Power on 20/5/21.
//

import SwiftUI

struct ToDoListDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var todoManager: ToDoListManager

        
    @State var item: Item
    
    var body: some View {
        
        VStack {
        TextField("Name", text: $item.name)
            .padding()
            .background(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                    
        Button(action: {
            todoManager.update(name: item.name, item: item)
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Update")
        })
            
            
        }
    }
}

struct ToDoListDetailView_Previews: PreviewProvider {
    @State private var name: String
    @ObservedObject var todoManager: ToDoListManager

    static var previews: some View {
        
        ToDoListDetailView(todoManager: ToDoListManager(), item: Item(id: UUID(), name: "TEST"))
    }
}
