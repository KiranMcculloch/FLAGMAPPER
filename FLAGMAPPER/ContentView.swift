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
    @StateObject var locationManager = LocationManager()
    @State var longPressLocation = CGPoint.zero
    @State var customLocation = MapLocation(latitude: 0, longitude: 0)
    @State var newLocation = MapLocation(latitude: 45.519, longitude: -73.581)
    
    var body: some View{
        NavigationStack{
            ZStack(alignment: .bottom) {
                GeometryReader { proxy in
                    Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: [customLocation, newLocation],
                        annotationContent: { location in MapMarker(coordinate: location.coordinate, tint: .red)})
                    .edgesIgnoringSafeArea(.all)
                    .gesture(LongPressGesture(minimumDuration: 0.25)
                    .sequenced(before: DragGesture(minimumDistance: 0, coordinateSpace: .local))
                    .onEnded { value in
                                switch value {
                                    case .second(true, let drag):
                                        longPressLocation = drag?.location ?? .zero
                                        customLocation = convertTap(at: longPressLocation, for: proxy.size)
                                        printLocation()
                                    default:
                                        break
                                }})
                    .highPriorityGesture(DragGesture(minimumDistance: 10))
                }
                
                
                VStack {
                    LocationButton {
                        locationManager.requestLocation()
                    }
                    .frame(width: 180, height: 40)
                    .cornerRadius(30)
                    .symbolVariant(.fill)
                    .foregroundColor(.white)
                }
                .padding()
            }
            
            NavigationLink("list view"){
                ListView()
            }.padding()
            NavigationLink("marker view"){
                MarkerView()
            }.padding()
        }
    }
    
    
    
    
    
    
    private func printLocation() {
            print("x: \(longPressLocation.x) - y: \(longPressLocation.y)")
    }
    
    
    func convertTap(at point: CGPoint, for mapSize: CGSize) -> MapLocation {
        let lat = locationManager.region.center.latitude
        let lon = locationManager.region.center.longitude
            
            let mapCenter = CGPoint(x: mapSize.width/2, y: mapSize.height/2)
            
            // X
            let xValue = (point.x - mapCenter.x) / mapCenter.x
            let xSpan = xValue * locationManager.region.span.longitudeDelta/2
            
            // Y
            let yValue = (point.y - mapCenter.y) / mapCenter.y
            let ySpan = yValue * locationManager.region.span.latitudeDelta/2
            
            return MapLocation(latitude: lat - ySpan, longitude: lon + xSpan)
    }
    
}


