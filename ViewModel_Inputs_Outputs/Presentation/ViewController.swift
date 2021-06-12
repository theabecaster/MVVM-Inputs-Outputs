//
//  ViewController.swift
//  ViewModel_Inputs_Outputs
//
//  Created by Abraham Gonzalez on 3/14/20.
//  Copyright © 2020 Abraham Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        viewModel = ViewModel()
        bind()
        viewModel.inputs.viewDidLoad()
    }
    
    private func setupViews() {
        activityIndicatorContainerView = UIView()
        activityIndicatorContainerView.backgroundColor = .black
        activityIndicatorContainerView.alpha = 0.7
        activityIndicatorContainerView.layer.cornerRadius = 8
        view.addSubview(activityIndicatorContainerView)
        
        activityIndicatorContainerView.frame = CGRect(x: (view.frame.width / 2) - 100/2, y: view.frame.midY - 100/2, width: 100, height: 100)
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .white
        view.addSubview(activityIndicator)
        activityIndicator.frame = CGRect(x: (view.frame.width / 2) - 10/2, y: view.frame.midY - 10/2, width: 10, height: 10)
        
        activityIndicatorContainerView.isHidden = true
        
        textField.delegate = self
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    private func bind(){
        viewModel.outputs.insertRowWithTask = { [unowned self] tasks in
            self.tasks.append(contentsOf: tasks)
            self.tableView.reloadData()
        }
        
        viewModel.outputs.showActivityIndicator = { [unowned self] in
            self.activityIndicatorContainerView.isHidden = false
            self.activityIndicator.startAnimating()
        }
        
        viewModel.outputs.dismissActivityIndicator = { [unowned self] in
            self.activityIndicator.stopAnimating()
            self.activityIndicatorContainerView.isHidden = true
        }
    }
    
    @IBAction func tappedAddButton(_ sender: Any) {
        self.textField.text = ""
        viewModel.inputs.tappedAddButton()
    }
    
    
    // MARK: - Outlets
    @IBOutlet weak var textField: UITextField!
    private var activityIndicatorContainerView: UIView!
    private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: ViewModel!
    private var tasks = [Task]()
    
}

extension ViewController: UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier) as! TableViewCell
        tableViewCell.setTaskName(name: tasks[indexPath.row].name)
        return tableViewCell
    }
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension ViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let range = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: range, with: string)
            viewModel.inputs.textChanged(text: updatedText)
        }
        
        return true
    }
}

