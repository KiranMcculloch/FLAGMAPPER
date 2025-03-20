//
//  ContentView.swift
//  FLAGMAPPER
//
//  Created by Kiran McCulloch on 2023-01-29.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct MapView: View{
    @EnvironmentObject var dataManager: DataManager
    @StateObject var locationManager = LocationManager()
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Location.id, ascending: true)],
        animation: .default)
    private var locations: FetchedResults<Location>
    @State var current_coordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    var body: some View{
        NavigationStack{
            ZStack {
                MapReader{ proxy in
                    Map{
                        ForEach(locations) { location in
                            Annotation("", coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(location.latitude), longitude: CLLocationDegrees(location.longitude))){
                                ZStack {
                                    Image(systemName: "mappin.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .foregroundStyle(.white, .purple)
                                }.onTapGesture {
                                    dataManager.editingLocation = location
                                    dataManager.showNewMapView = false
                                    dataManager.showEditorMapView = true
                                    print("tapped on \(String(describing: location.name))")
                                }
                            }
                        }
                        if dataManager.showNewMapView{
                            Annotation("", coordinate: current_coordinate){
                                ZStack {
                                    Image(systemName: "mappin.circle.fill")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40, height: 40)
                                        .foregroundStyle(.white, .red)
                                }
                            }
                        }
                        
                    }
                    .onTapGesture {
                        dataManager.showEditorMapView = false
                        dataManager.showNewMapView = false
                    }
                    .gesture(LongPressGesture { position in
                        self.current_coordinate = proxy.convert(position, from: .global)!
                        dataManager.showEditorMapView = false
                        dataManager.showNewMapView = true
                    })
          
                }
                VStack{
                    if dataManager.showNewMapView{
                        NewLocationView(coordinate: $current_coordinate, input_name: "New Location")
                            .frame(width: 300, height: 300)
                    }
                    if dataManager.showEditorMapView{
                        EditLocationView(stored_location: dataManager.editingLocation!)
                   }
                    Spacer()
                    LocationButton {
                        locationManager.requestLocation()
                    }
                        .frame(width: 180, height: 40)
                        .cornerRadius(30)
                        .symbolVariant(.fill)
                        .foregroundColor(.white)
                }
                
            }
        }
    }
}


#Preview {
    MapView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(DataManager())
}
