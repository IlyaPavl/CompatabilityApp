//
//  ResultViewController.swift
//  CompatabilityApp
//
//  Created by Ilya Pavlov on 18.07.2023.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var namesLabel: UILabel!
    @IBOutlet weak var percentLevel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var firstName: String!
    var secondName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        namesLabel.text = "\(firstName ?? "") и \(secondName ?? "")"
    }
    
}
