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
    var type: String
    var date: Date
    var weight: Double
    var animate: Bool = false
}

let calendar = Calendar(identifier: .japanese)

struct LetIsCharts: View {
    
    var sampledata: [reWeights] = [
        reWeights(userId: "aaa", type: "現在", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 24))!, weight: 57.5),
        
        reWeights(userId: "aaa", type: "目標", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 24))!, weight: 57.5),
        reWeights(userId: "aaa", type: "現在", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 25))!, weight: 57.0),
        reWeights(userId: "aaa", type: "現在", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 26))!, weight: 56.8),
        reWeights(userId: "aaa", type: "現在", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 27))!, weight: 56.1),
        reWeights(userId: "aaa", type: "現在", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 28))!, weight: 55.5),
        reWeights(userId: "aaa", type: "現在", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 29))!, weight: 55.3),
        reWeights(userId: "aaa", type: "現在", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 30))!, weight: 54.9),
        
        reWeights(userId: "aaa", type: "現在", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 31))!, weight: 54.7),
        reWeights(userId: "aaa", type: "目標", date: calendar.date(from: DateComponents(year: 2023, month: 1, day: 31))!, weight: 55.0),
       // reWeights(userId: "aaa", type: "現在", date: calendar.date(from: DateComponents(year: 2023, month: 2, day: 1))!, weight: 54.5),

    ]
    
    @AppStorage("IdealGraphSelection") var idealGraphSelection: Bool = false
    @AppStorage("ideal_weght") var hopeWeight: String = ""
    
    @State var currentActiveItem: reWeights?
    @State var plotWidth: CGFloat = 0
    
    let weekRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let start = calendar.date(from: DateComponents(year: 2023, month: 1, day: 24))!
        let end = calendar.date(from: DateComponents(year: 2023, month: 1, day: 30))!
        return start...end
    }()
    
    var body: some View {
        VStack {
            Button {
                idealGraphSelection.toggle()
            } label: {
                Image(systemName: "repeat")
            }

            
            Chart(sampledata) { item in
                    if item.type == "現在" {
                        LineMark(x: .value("Date", item.date), y: .value("Weight", item.weight))
                            .foregroundStyle(by: .value("color", item.type))
                    }
                
                    if item.type == "目標", idealGraphSelection{
                        LineMark(x: .value("Date", item.date), y: .value("Weight", item.weight))
                            .lineStyle(.init(lineWidth: 1, miterLimit: 1, dash: [5], dashPhase: 5))
                            .foregroundStyle(by: .value("color", item.type))
                            
                        
                        PointMark(x: .value("Date", item.date), y: .value("Weight", item.weight))
                            .foregroundStyle(by: .value("color", item.type))
                    }
                
                if !idealGraphSelection {
                    RuleMark(y: .value("体重", Double(hopeWeight) ?? 55.0))
                        .foregroundStyle(.gray.opacity(0.08))
                        .lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [5], dashPhase: 5))
                        .annotation(alignment: .leading) {
                            Text("目標")
                                .foregroundColor(.gray.opacity(0.1))
                                .font(.caption)
                        }
                }
 
                    
                    if let currentActiveItem, currentActiveItem.id == item.id {
                        RuleMark(x: .value("日付", currentActiveItem.date))
                            .foregroundStyle(.orange.opacity(0.6))
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
                .frame(height: 250)
                .padding()
                .chartForegroundStyleScale([
                    "現在": .orange, "目標": .gray
                ])
                .chartXAxis {
                    AxisMarks(values: .stride(by: .day, count: 1)) { _ in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel(format: .dateTime.day())
                    }
                }
//                .chartXScale(domain: 0...max)
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
}

struct LetIsCharts_Previews: PreviewProvider {
    static var previews: some View {
        LetIsCharts()
    }
}
