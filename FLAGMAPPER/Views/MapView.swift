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
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Flag.id, ascending: true)],
        animation: .default)
    private var flags: FetchedResults<Flag>
    

    @State var current_coordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    @State var editing_location : Location? = nil
    
    @State var sensoryTrigger = 0
    
    
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
                                    editing_location = location
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
                        
                    }.mapControls {
                        MapUserLocationButton()
                    }
                    .gesture(LongPressGesture { position in
                        self.current_coordinate = proxy.convert(position, from: .global)!
                        dataManager.showEditorMapView = false
                        dataManager.showNewMapView = true
                        self.sensoryTrigger += 1
                    })
                    .sensoryFeedback(.impact(flexibility: .rigid, intensity: 2.0), trigger: sensoryTrigger)
                }
                
                
                
                VStack{
                    if dataManager.showNewMapView{
                        ZStack {
                            Rectangle()
                                .frame(width: 500, height: 2000)
                                .opacity(0.1)
                                .layoutPriority(-1)
                                .onTapGesture {
                                    dataManager.showNewMapView = false
                                }
                        NewLocationView(coordinate: $current_coordinate, input_name: "New Location")
                            .frame(width: 300, height: 300)
                        }
                    }
                    if dataManager.showEditorMapView{
                        ZStack {
                            Rectangle()
                                .frame(width: 500, height: 2000)
                                .opacity(0.1)
                                .layoutPriority(-1)
                                .onTapGesture {
                                    dataManager.showEditorMapView = false
                                }
                            EditLocationView(stored_location: $editing_location)
                                .frame(width: 300, height: 300)
                        }
                   }
                    Spacer()
                    NavigationLink{
                        CatalogView()
                    } label: {
                        Label("Catalog", systemImage: "folder")
                            .padding()
                    }.background(
                        RoundedRectangle(cornerRadius: 25).foregroundStyle(.white)
                    )
                

                }
                
                
                
                
            }
        }
    }
}


#Preview {
    MapView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(DataManager())
}
