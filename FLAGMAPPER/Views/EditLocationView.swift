//
//  EditLocationView.swift
//  FLAGMAPPER
//
//  Created by Kiran McCulloch on 2025-03-20.
//

import Foundation
//
//  CreateMarkerView.swift
//  FLAGMAPPER
//
//  Created by Kiran McCulloch on 2025-03-20.
//

import SwiftUI
import MapKit

struct EditLocationView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataManager: DataManager

    @State var nameInEditMode = false
    @Binding var stored_location : Location?
    @State var input_name : String = ""
    
    var body: some View {
        VStack{
            HStack{
                if nameInEditMode {
                    TextField(
                        input_name, text: $input_name
                    ).font(.largeTitle)
                        .fontWeight(.bold)
                        .autocorrectionDisabled(true)
                        .foregroundStyle(.black)
                } else {
                    Text(input_name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                }

                Button(action: {
                    if nameInEditMode {
                        self.nameInEditMode = false
                        self.stored_location?.name = input_name
                    } else {
                        self.nameInEditMode = true
                    }
                }) {
                    if nameInEditMode {
                        Text("Done")
                            .font(.system(size: 20))
                            .fontWeight(.light)
                            .foregroundStyle(.blue)
                    } else {
                        Image(systemName: "square.and.pencil")
                            .foregroundStyle(.blue)
                    }
                }
            }.padding()
            Button(action: {saveLocation()}){
                Text("Save")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding()
            }.padding()
        }.background(.white).clipShape(RoundedRectangle(cornerRadius: 25))
            .onAppear(
                perform: {self.input_name = self.stored_location?.name ?? "Unknown Name"}
            )

    }
    
    private func saveLocation() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        dataManager.showEditorMapView = false
    }
}



//#Preview {
//    EditLocationView(stored_location: Location()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//        .environmentObject(DataManager())
//}
