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
        yourNameTF.returnKeyType = .next
        partnerNameTF.returnKeyType = .done
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ResultViewController else { return }
        
        destinationVC.firstName = yourNameTF.text
        destinationVC.secondName = partnerNameTF.text
    }
    
    @IBAction func pressedButton() {
        guard let firstName = yourNameTF.text, let secondName = partnerNameTF.text else {return}
        
        if firstName.isEmpty || secondName.isEmpty {
            showAlert(title: "Ошибка!", message: "Введите оба имени")
            return
        }
        
        performSegue(withIdentifier: "resultSegue", sender: nil)
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        yourNameTF.text = ""
        partnerNameTF.text = ""
    }
    
}

extension InitialViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension InitialViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == yourNameTF {
            partnerNameTF.becomeFirstResponder()
        } else {
            pressedButton()
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedChar = CharacterSet.letters.union(.mySet)
        let replacementCharSet = CharacterSet(charactersIn: string)
        
        return replacementCharSet.isSubset(of: allowedChar)
    }
}

extension CharacterSet {
    static var mySet: CharacterSet {
        var symbols = CharacterSet()
        symbols.insert(charactersIn: "-")
        return symbols
    }
}

