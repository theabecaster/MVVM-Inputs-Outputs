//
//  ViewModel.swift
//  ViewModel_Inputs_Outputs
//
//  Created by Abraham Gonzalez on 3/14/20.
//  Copyright © 2020 Abraham Gonzalez. All rights reserved.
//

import Foundation

protocol ViewModelInputs{
    func viewDidLoad()
    func tappedAddButton()
    func textChanged(text: String)
}

protocol ViewModelOutputs{
    var insertRowWithTask: (([Task]) -> Void) { get set }
    var showActivityIndicator: (() -> Void) { get set }
    var dismissActivityIndicator: (() -> Void) { get set }
}

protocol ViewModelType{
    var inputs: ViewModelInputs { get }
    var outputs: ViewModelOutputs { get set }
}


class ViewModel: ViewModelInputs, ViewModelOutputs, ViewModelType{
    
    // MARK: - ViewModelType
    var inputs: ViewModelInputs { return self }
    var outputs: ViewModelOutputs {
        get { return self }
        set {  }
    }
    
    // MARK: - ViewModelInputs
    func viewDidLoad() {
        showActivityIndicator()
        let tasks = self.taskManager.loadAllTasks()
        // mocked delayed
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.insertRowWithTask(tasks)
            self.dismissActivityIndicator()
        }
    }
    
    func tappedAddButton() {
        if text.count == 0 { return }
        let task = Task(name: self.text)
        taskManager.saveTask(task: task)
        insertRowWithTask([task])
    }
    
    func textChanged(text: String) {
        self.text = text
    }
    
    
    // MARK: - ViewModelOutputs
    var insertRowWithTask: (([Task]) -> Void) = { _ in }
    var showActivityIndicator: (() -> Void) = { }
    var dismissActivityIndicator: (() -> Void) = {}
    
    // Internal
    private let taskManager = Tasks()
    private var text: String = ""
    
}
