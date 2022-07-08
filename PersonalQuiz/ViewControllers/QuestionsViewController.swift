//
//  ViewController.swift
//  PersonalQuiz
//
//  Created by Алексей Гайдуков on 07.07.2022.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    @IBOutlet var questionLable: UILabel!
    @IBOutlet var questionProgressView: UIProgressView!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButotns: [UIButton]!
    
    @IBOutlet var multipalStackView: UIStackView!
    @IBOutlet var multipalLabels: [UILabel]!
    @IBOutlet var multipalSwitches: [UISwitch]!
    
    @IBOutlet var rangeStackView: UIStackView!
    @IBOutlet var rangedLables: [UILabel]!
    @IBOutlet var rangedSlider: UISlider!
    
    private let questions = Questin.getQuestions()
    private var questionIndex = 0 // текущий индекс массива

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func singleAnswerButtonPreessed(_ sender: UIButton) {
    }
    
    @IBAction func multipalButtonAnswerPressed() {
    }
    
    @IBAction func rangedAnswerButtonPressed() {
    }
}

//MARK: Private Methods
extension QuestionsViewController  {
    private func updateUI() {
        // Hide stack - скрыть стеки
        for stackView in [singleStackView, multipalStackView, rangeStackView] {
            stackView?.isHidden = true
        }
        // Get current question - получить текущий вопрос
        let currentQuestion = questions[questionIndex]
        
        // Set current question for question lable - установка текущего вопроса для лейбла
        questionLable.text = currentQuestion.title
        
        // Calculate progress - текущее положение прогресс вью
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        // Set progrss for questionProgressView передача свойсва в прогрессВью
        questionProgressView.setProgress(totalProgress, animated: true)
        
        // Set navigation title - установка заголовка
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        // отображение ответов
        showCurrentAnswers(for: currentQuestion.responseType) // показать ответы в соответствие с категорией
    }
    private func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single: break
        case .multipal: break
        case .ranged: break
        }
    }
    private func showSingleStackView(with answers: [Answer]) { // отабразить стек с одиночнимы ответами
        singleStackView.isHidden = false
        //присвоение каждой кнопке название
        for (button, answer) in zip(singleButotns, answers) {
            
        }
        
    }
}
