//
//  DataManager.swift
//  FLAGMAPPER
//
//  Created by Kiran McCulloch on 2025-03-20.
//

import Foundation

class DataManager: ObservableObject{
    @Published var showNewMapView : Bool = false
    @Published var showEditorMapView : Bool = false
    @Published var editingLocation : Location? = nil
}
