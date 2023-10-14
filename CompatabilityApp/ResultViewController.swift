//
//  ResultViewController.swift
//  CompatabilityApp
//
//  Created by Ilya Pavlov on 18.07.2023.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var namesLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var firstName: String!
    var secondName: String!
    
    private var resultValue = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultValue = findResult()
        
        namesLabel.text = "\(firstName ?? "") и \(secondName ?? "")"
        
        percentLabel.text = resultValue.formatted(.percent)
        
        progressBar.progress = Float(resultValue) / 100
        
        progressBar.transform = .init(scaleX: 1, y: 2)
    }
    
    private func findValue(for name: String) -> Int {
        var count = 0
        
        for character in name.lowercased () {
            switch character {
            case "а", "и", "й", "ы", "у":
                count += 1
            case "б", "к", "р", "ш":
                count += 2
            case "с", "г", "л", "ц":
                count += 3
            case "д", "м", "т", "э":
                count += 4
            case "е", "х", "н", "ё":
                count += 5
            case "ю", "в", "ж", "я":
                count += 6
            case "о", "з", "ь", "ъ":
                count += 7
            case "ф", "п", "щ", "ч":
                count += 8
            default:
                count += 0
            }
        }
        return count
    }
    
    private func findResult() -> Int {
        var result = 0
        
        let firstValue = findValue(for: firstName)
        let secondValue = findValue(for: secondName)
        let absDifference = abs(firstValue - secondValue)
        
        switch absDifference {
        case 0, 1, 2:
            result = 100
        case 3, 4:
            result = 65
        case 5:
            result = 50
        case 6:
            result = 40
        default:
            result = 30
        }
        return result
    }
    
}
