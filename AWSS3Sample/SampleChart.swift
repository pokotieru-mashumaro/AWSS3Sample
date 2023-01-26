//
//  SampleChart.swift
//  AWSS3Sample
//
//  Created by iniad on 2023/01/25.
//

import SwiftUI
import Charts

//struct reWeights: Identifiable, Codable, Hashable {
//    //var userId: String
//    var id = UUID().uuidString
//    var userId: String
//    var type: String
//    var date: Date
//    var weight: Double
//    var animate: Bool = false
//}

//let calendar = Calendar(identifier: .japanese)


struct SampleChart: View {
    var sampledata: [reWeights] = [
        reWeights(userId: "aaa", type: "現在", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 24))!, weight: 57.5),
        reWeights(userId: "aaa", type: "現在", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 25))!, weight: 57.0),
        reWeights(userId: "aaa", type: "現在", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 26))!, weight: 56.8),
        reWeights(userId: "aaa", type: "現在", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 27))!, weight: 56.1),
        reWeights(userId: "aaa", type: "現在", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 28))!, weight: 55.5),
        reWeights(userId: "aaa", type: "現在", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 29))!, weight: 55.3),
        reWeights(userId: "aaa", type: "現在", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 30))!, weight: 54.9),
    ]
    
    var idealData: [reWeights] = [
        reWeights(userId: "aaa", type: "理想", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 22))!, weight: 57.5),
        reWeights(userId: "aaa", type: "理想", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 31))!, weight: 55.0),
    ]
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let start = calendar.date(from: DateComponents(year: 2023, month: 1, day: 24))!
        let end = calendar.date(from: DateComponents(year: 2023, month: 1, day: 30))!
        return start...end
    }()
    
    var body: some View {
            ZStack {
                Chart {
                    ForEach(sampledata) {
                        LineMark(x: .value("Date", $0.date),
                                 y: .value("Weight", $0.weight))
                        .foregroundStyle(.orange)
                        .foregroundStyle(by: .value("color", "現在"))
                        .lineStyle(StrokeStyle(lineWidth: 3))
                    }
         
                    ForEach(idealData) { item in
                        
                        LineMark(x: .value("Date", item.date),
                                 y: .value("Weight", item.weight))
                        .foregroundStyle(.gray)
                        .foregroundStyle(by: .value("color", "目標"))
                        .lineStyle(StrokeStyle(lineWidth: 3, dash: [5, 10]))
                    }
                    
                }
                
                .frame(height: 200)
                .padding()
                .chartLegend(.hidden)
                .chartXScale(domain: dateRange)
                .chartYScale(domain: .automatic(includesZero: false))
                
//                Chart {
//                    ForEach(idealData) {
//                        LineMark(x: .value("Date", $0.date),
//                                 y: .value("Weight", $0.weight))
//                        .foregroundStyle(.gray)
//                        .foregroundStyle(by: .value("color", "目標"))
//                        .lineStyle(StrokeStyle(lineWidth: 3, dash: [5, 10]))
//                    }
//                }
//                .frame(height: 200)
//                .padding()
//                .chartLegend(.hidden)
//                .chartYScale(domain: .automatic(includesZero: false))
            
        }
    }
}

struct SampleChart_Previews: PreviewProvider {
    static var previews: some View {
        SampleChart()
    }
}
