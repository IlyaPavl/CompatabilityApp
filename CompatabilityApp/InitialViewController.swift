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

// напишем протокол, который поможет настроить отображение клавиатуры на экране
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
    
    /*
     ограничение для ввода только символов
     1. Создается переменная allowedChar, которая представляет собой объединение символов из CharacterSet.letters (буквы) и CharacterSet.whitespaces (пробелы). Этот набор символов определяет, какие символы разрешены для ввода.
     2. Создается переменная replacementCharSet, которая представляет собой CharacterSet, созданный из строки string. Этот набор символов представляет символы, которые будут вставлены или заменят указанный диапазон в текстовом поле.
     3. Выполняется проверка с помощью метода isSubset(of:), чтобы определить, является ли набор символов replacementCharSet подмножеством набора разрешенных символов allowedChar.
     4. Возвращается булево значение: true, если набор символов replacementCharSet является подмножеством allowedChar (т.е. символы допустимы для ввода); false, если есть хотя бы один символ в replacementCharSet, который не является разрешенным символом.
     */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedChar = CharacterSet.letters.union(.mySet)
        let replacementCharSet = CharacterSet(charactersIn: string)
        
        return replacementCharSet.isSubset(of: allowedChar)
    }
}
// делаем расширение для имен, которые пишутся через тире
extension CharacterSet {
    static var mySet: CharacterSet {
        var symbols = CharacterSet()
        symbols.insert(charactersIn: "-")
        return symbols
    }
}

