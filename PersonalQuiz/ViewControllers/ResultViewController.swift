//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Алексей Гайдуков on 08.07.2022.
//

import UIKit

class ResultViewController: UIViewController {
        
    @IBOutlet var animalCharLable: UILabel!
    @IBOutlet var descriptionLable: UILabel!
    
    var answers: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculateResul()
      
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
    
}

// MARK: Private Methoods
extension ResultViewController {
 
    private func calculateResul() {
       
        var howManyAreFound: [Animal: Int] = [:]
        let animals = answers.map { $0.animal }
//
//        for animal in animals {
//            if let animalTypeCount = howManyAreFound[animal] {
//                howManyAreFound.updateValue(animalTypeCount + 1, forKey: animal)
//            } else {
//                howManyAreFound[animal] = 1
//            }
//        }
        
        for animal in animals {
            howManyAreFound[animal, default: 0] += 1 
        }
            
            let sorted = howManyAreFound.sorted { $0.value > $1.value}
            guard let isMoreCommon = sorted.first?.key else { return }
        
        
        updateUI(with: isMoreCommon)

    }
    private func updateUI(with animal: Animal?) {
        animalCharLable.text = "Вы - \(animal?.rawValue ?? "🐕‍🦺")!"
        descriptionLable.text = animal?.definition ?? ""
    }
}
