//
//  ContentView.swift
//  FLAGMAPPER
//
//  Created by Kiran McCulloch on 2025-03-19.
//

import SwiftUI
import CoreData
import MapKit

struct LocationsListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Location.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Location>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Name: \(item.name ?? "unknown")")
                        Text("ID: \(item.id?.uuidString ?? "unknown")")
                    } label: {
                        Text(item.name ?? "unknown name")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addLocation()) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
            }
            Text("Select an item")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


#Preview {
    LocationsListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
