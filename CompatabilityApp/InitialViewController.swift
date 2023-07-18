//
//  ViewController.swift
//  CompatabilityApp
//
//  Created by Ilya Pavlov on 18.07.2023.
//

import UIKit

class InitialViewController: UIViewController {
    @IBOutlet weak var yourNameTF: UITextField!
    @IBOutlet weak var partnerNameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ResultViewController else { return }
        
        destinationVC.firstName = yourNameTF.text
        destinationVC.secondName = partnerNameTF.text
    }
    
    @IBAction func pressedButton() {
        
        performSegue(withIdentifier: "resultSegue", sender: nil)
    }
    

}

