//
//  CatalogView.swift
//  FLAGMAPPER
//
//  Created by Kiran McCulloch on 2025-04-11.
//

import SwiftUI

struct CatalogView: View {
    var body: some View {
        NavigationLink("see all locations"){
            LocationsListView()
        }
        NavigationLink("see all flags"){
            FlagsListView()
        }
    }
}

#Preview {
    CatalogView()
}
