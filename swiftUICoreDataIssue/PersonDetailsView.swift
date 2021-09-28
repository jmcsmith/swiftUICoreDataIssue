//
//  PersonDetailsView.swift
//  swiftUICoreDataIssue
//
//  Created by Joe Smith on 9/28/21.
//

import SwiftUI

struct PersonDetailsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var person: Person
    @FetchRequest var favs: FetchedResults<Favorite>
    
    init(person: Person) {
        self.person = person

        _favs = FetchRequest(
            entity: Favorite.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Favorite.name, ascending: true)
            ],
            predicate: NSPredicate(format: "person == %@", person)
        )
    }
    var body: some View {
        VStack {
        TextField("Name", text: $person.name.withDefaultValue(""))
            .textFieldStyle(.roundedBorder)
            .padding()
            ForEach(favs) { fav in
                //Works
                //Text(fav.name ?? "Fav name Error")
                
                //Does not work - Cannot find '$fav' in scope
                TextField("Fav", Text($fav.name))
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        
                            try? viewContext.save()
                     
                    }, label: {
                        
                            Text("Save")
                    
                    })
                }
            }
        }
    }
}

extension Binding where Value == String? {
    func withDefaultValue(_ fallback: String) -> Binding<String> {
        return Binding<String>(get: {
            return self.wrappedValue ?? fallback
        }) { value in
            self.wrappedValue = value
        }
    }
}
