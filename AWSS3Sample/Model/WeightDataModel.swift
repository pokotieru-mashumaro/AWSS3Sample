//
//  WeightDataModel.swift
//  AWSS3Sample
//
//  Created by iniad on 2023/01/25.
//

import SwiftUI
import CoreData

class WeightDataModel: ObservableObject {
    @Published var id: UUID = UUID()
    @Published var date: Date = Date()
    @Published var weight: Double = 0.0
    @Published var type: String = "現在"
    @Published var animate: Bool = false
    
    @Published var isNewData = false
    @Published var updateItem : WeightModel!
        
    
}
