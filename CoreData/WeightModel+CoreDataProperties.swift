//
//  WeightModel+CoreDataProperties.swift
//  AWSS3Sample
//
//  Created by iniad on 2023/01/25.
//
//

import Foundation
import CoreData


extension WeightModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeightModel> {
        return NSFetchRequest<WeightModel>(entityName: "WeightModel")
    }

    @NSManaged public var weight: Double
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var type: String?
    @NSManaged public var animate: Bool

}

extension WeightModel {
    public var WrappedDate: Date {date ?? Date()}
    public var WrappedId: UUID {id ?? UUID()}
    public var WrappedType: String {type ?? "現在"}
}

extension WeightModel : Identifiable {

}
