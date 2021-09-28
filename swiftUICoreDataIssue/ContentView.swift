//
//  ContentView.swift
//  swiftUICoreDataIssue
//
//  Created by Joe Smith on 9/28/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Person.name, ascending: true)],
        animation: .default)
    private var people: FetchedResults<Person>

    var body: some View {
        NavigationView {
            List {
                ForEach(people) { person in
                    NavigationLink {
                        PersonDetailsView(person: person)
                    } label: {
                        Text(person.name ?? "Name Error")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Person.init(entity: Person.entity(), insertInto: viewContext)
            newItem.name = "New Person"
            let a = Favorite.init(entity: Favorite.entity(), insertInto: viewContext)
            a.name = "Ice Cream"
            newItem.addToFavorites(a)
            let b = Favorite.init(entity: Favorite.entity(), insertInto: viewContext)
            b.name = "Coffee"
            newItem.addToFavorites(b)
            let c = Favorite.init(entity: Favorite.entity(), insertInto: viewContext)
            c.name = "Beer"
            newItem.addToFavorites(c)
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

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { people[$0] }.forEach(viewContext.delete)

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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


