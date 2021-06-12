//
//  TableViewCell.swift
//  ViewModel_Inputs_Outputs
//
//  Created by Abraham Gonzalez on 3/14/20.
//  Copyright © 2020 Abraham Gonzalez. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let reuseIdentifier = "TableViewCellIdentifier"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setTaskName(name: String){
        self.label.text = name
    }
    
    private let label: UILabel = {
        let label = UILabel()
        return label
    }()
}
