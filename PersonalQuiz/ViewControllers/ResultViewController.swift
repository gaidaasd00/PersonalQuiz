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
    
    var answers: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let result = calculateResul()
        updateUI(with: result)
        self.navigationItem.setHidesBackButton(true, animated: true)
      
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
    
}

// MARK: Private Methoods
extension ResultViewController {
 
    private func calculateResul() -> Animal? {
       
        var howManyAreFound: [Animal: Int] = [:]
        let animals = answers.map { $0.animal }
        
        for animal in animals {
            if let animalTypeCount = howManyAreFound[animal] {
                howManyAreFound.updateValue(animalTypeCount + 1, forKey: animal)
            } else {
                howManyAreFound[animal] = 1
            }
        }
            
            let sorted = howManyAreFound.sorted { $0.value > $1.value}
            guard let isMoreCommon = sorted.first?.key else { return nil }
        
        return isMoreCommon
        
    }
    private func updateUI(with animal: Animal?) {
        animalCharLable.text = "Вы - \(animal?.rawValue ?? "🐕‍🦺")!"
        descriptionLable.text = animal?.definition ?? ""
    }
}
