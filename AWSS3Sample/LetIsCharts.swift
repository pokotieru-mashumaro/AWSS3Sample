//
//  LetIsCharts.swift
//  AWSS3Sample
//
//  Created by iniad on 2023/01/24.
//

import SwiftUI
import Charts

struct reWeights: Identifiable, Codable, Hashable {
    //var userId: String
    var id = UUID().uuidString
    var userId: String
    var date: Date
    var weight: Double
    var animate: Bool = false
}

let calendar = Calendar(identifier: .japanese)

struct LetIsCharts: View {
    
    var sampledata: [reWeights] = [
        reWeights(userId: "aaa", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 24))!, weight: 57.5),
        reWeights(userId: "aaa", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 25))!, weight: 57.0),
        reWeights(userId: "aaa", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 26))!, weight: 56.8),
        reWeights(userId: "aaa", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 27))!, weight: 56.1),
        reWeights(userId: "aaa", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 28))!, weight: 55.5),
        reWeights(userId: "aaa", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 29))!, weight: 55.3),
        reWeights(userId: "aaa", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 30))!, weight: 54.9),
        reWeights(userId: "aaa", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 31))!, weight: 54.7),
    ]
    
    @State var currentActiveItem: reWeights?
    @State var plotWidth: CGFloat = 0
    
    var body: some View {
        Chart {
            ForEach(sampledata) { data in
                LineMark(x: .value("Date", data.date), y: .value("Weight", data.weight))
                
                if let currentActiveItem, currentActiveItem.id == data.id {
                    RuleMark(x: .value("日付", currentActiveItem.date))
                        .lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [2], dashPhase: 5))
                        .annotation(position: .top) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("体重")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Text(String(format: "%.1f", currentActiveItem.weight))
                                    .font(.title3.bold())
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background {
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill(.white.shadow(.drop(radius: 2)))
                            }
                        }
                }
                
            }
            
            RuleMark(xStart: .value("FirstDay", sampledata[2].date),
                     xEnd: .value("FinalDay", sampledata[5].date),
                     y: .value("", 55.5))
            .foregroundStyle(Color.red)
            
        }
        .padding()
        .padding(.top, 200)
        .chartXAxis {
            AxisMarks(values: .stride(by: .day, count: 1)) { _ in
                AxisGridLine()
                AxisTick()
                AxisValueLabel(format: .dateTime.day())
            }
        }
        .chartYScale(domain: .automatic(includesZero: false))
        .chartOverlay(content: { proxy in
            GeometryReader { innerProxy in
                Rectangle()
                    .fill(.clear)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged{ value in
                                let location = value.location
                                if let date: Date = proxy.value(atX: location.x) {
                                    let calendar = Calendar.current
                                    let day = calendar.component(.day, from: date)
                                    if let currentItem = sampledata.first(where: { item in
                                        calendar.component(.day, from: item.date) == day
                                    }) {
                                        self.currentActiveItem = currentItem
                                        self.plotWidth = proxy.plotAreaSize.width
                                    }
                                }
                            }.onEnded{ value in
                                currentActiveItem = nil
                            }
                    )
            }
        })
        
    }
}

struct LetIsCharts_Previews: PreviewProvider {
    static var previews: some View {
        LetIsCharts()
    }
}
