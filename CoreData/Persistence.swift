//
//  Persistence.swift
//  AWSS3Sample
//
//  Created by iniad on 2023/01/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // Previewが必要な場合もここにコードを書く
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let newWeightData = WeightModel(context: viewContext)
        newWeightData.id = UUID()
        newWeightData.date = Date()
        newWeightData.weight = 0.0
        newWeightData.type = ""
        newWeightData.animate = false
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "AWSS3Sample")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
