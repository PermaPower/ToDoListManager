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

    @State var itemName: String
    
    var body: some View {
        
        VStack {
        TextField("Name", text: $itemName)
            .padding()
            .background(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                    
        Button(action: {
            todoManager.update(item: ItemEntity.init(context: todoManager.container.viewContext), itemName: itemName)
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

        ToDoListDetailView(todoManager: ToDoListManager(), itemName: "TEST")
    }
}
