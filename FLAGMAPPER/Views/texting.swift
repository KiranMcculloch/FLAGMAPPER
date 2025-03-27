//
//  texting.swift
//  FLAGMAPPER
//
//  Created by Kiran McCulloch on 2025-03-27.
//

import SwiftUI

struct texting: View {
    @State var input_name: String = "New Location"
    
    var body: some View {
        TextField(input_name, text: $input_name)
    }
}

#Preview {
    texting()
}
