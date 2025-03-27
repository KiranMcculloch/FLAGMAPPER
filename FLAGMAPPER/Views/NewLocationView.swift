//
//  CreateMarkerView.swift
//  FLAGMAPPER
//
//  Created by Kiran McCulloch on 2025-03-20.
//

import SwiftUI
import MapKit

struct NewLocationView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataManager: DataManager

    @State var nameInEditMode = false
    @Binding var coordinate: CLLocationCoordinate2D
    @State var input_name: String = "New Location"
//    @State var final_name: String = ""
    
    var body: some View {
        VStack{
            HStack{
                if nameInEditMode {
                    TextField(input_name, text: $input_name)
                        .font(.largeTitle)
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

    }
    
    private func saveLocation() {
        let newLocation = Location(context: viewContext)
        newLocation.id = UUID()
        newLocation.name = self.input_name
        newLocation.latitude = Float(self.coordinate.latitude)
        newLocation.longitude = Float(self.coordinate.longitude)
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        dataManager.showNewMapView = false
    }
}


//
//#Preview {
//    NewLocationView(coordi)
//}
