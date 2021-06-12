//
//  Tasks.swift
//  ViewModel_Inputs_Outputs
//
//  Created by Abraham Gonzalez on 3/14/20.
//  Copyright © 2020 Abraham Gonzalez. All rights reserved.
//

import Foundation
import CoreData

struct Task{
    let name: String
}

class Tasks{
    
    fileprivate let container = PersistentContainer()
    
    func loadAllTasks() -> [Task] { return container.fetchTasks() }
    
    func saveTask(task: Task) { container.saveTask(task: task) }
    
}

fileprivate class PersistentContainer{
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error { fatalError("\(error.localizedDescription)") }
        }
        return container
    }()
    
    func fetchTasks() -> [Task] {
        var tasks: [Task] = []
        
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TaskEntity")
        
        do {
           let managedTasks = try context.fetch(fetchRequest)
            tasks = managedTasks.map {
                let taskName = $0.value(forKey: "name") as? String ?? ""
                return Task(name: taskName)
            }
           
        } catch let error {
            print("\(error.localizedDescription)")
        }
        
        return tasks
    }
    
    func saveTask(task: Task) {
        let context = persistentContainer.viewContext
        let taskEntity = NSEntityDescription.entity(forEntityName: "TaskEntity", in: context)
        let newTask = NSManagedObject(entity: taskEntity!, insertInto: context)
        newTask.setValue(task.name, forKey: "name")
        
        do {
            try context.save()
        } catch let error {
            print("Could not save to local storage. \(error.localizedDescription)")
        }
    }
    
    
    
}
