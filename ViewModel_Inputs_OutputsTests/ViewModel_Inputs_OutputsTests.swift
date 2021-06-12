//
//  ViewModel_Inputs_OutputsTests.swift
//  ViewModel_Inputs_OutputsTests
//
//  Created by Abraham Gonzalez on 3/14/20.
//  Copyright © 2020 Abraham Gonzalez. All rights reserved.
//

import XCTest
@testable import ViewModel_Inputs_Outputs

class ViewModel_Inputs_OutputsTests: XCTestCase {

    func test_ViewDidLoad() {
        let viewModel = ViewModel()
        
        let exp = XCTestExpectation()
        exp.expectedFulfillmentCount = 2
        
        viewModel.outputs.showActivityIndicator = {
            exp.fulfill()
        }
        
        viewModel.outputs.dismissActivityIndicator = {
            exp.fulfill()
        }
        
        viewModel.inputs.viewDidLoad()
        wait(for: [exp], timeout: 2.0)
        
    }

}
