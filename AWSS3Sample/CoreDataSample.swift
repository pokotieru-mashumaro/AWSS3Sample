//
//  CoreDataSample.swift
//  AWSS3Sample
//
//  Created by iniad on 2023/01/25.
//

import SwiftUI

struct CoreDataSample: View {
    @State var weightText = ""
    @State var selectedDay: Date = Date()
    var body: some View {
        VStack {
            TextField("dc", text: $weightText)
                .textFieldStyle(.roundedBorder)
            
            DatePicker("", selection: $selectedDay, displayedComponents: [.date])
                .labelsHidden()
                .environment(\.locale, Locale(identifier: "ja_JP"))

        }
        .padding()
    }
}

struct CoreDataSample_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataSample()
    }
}
