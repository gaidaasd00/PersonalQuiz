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
    @IBOutlet var rangedSlider: UISlider! { // что бы слайдер принимал значения по коллиеству вариантов ответа
        didSet {
            let answersCount = Float(currentAnswers.count - 1)
            rangedSlider.maximumValue = answersCount
            rangedSlider.value = answersCount / 2 // бегунок слайдера установлен по середине
        }
    }
    
    private let questions = Questin.getQuestions()
    private var answersChosen: [Answer] = []
    private var questionIndex = 0 // текущий индекс массива
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.answers = answersChosen
    }

    @IBAction func singleAnswerButtonPreessed(_ sender: UIButton) { // извлечение ответа по индексу
        guard let buttonIndex = singleButotns.firstIndex(of: sender) else { return }
        let answer = currentAnswers[buttonIndex]
        answersChosen.append(answer)
        nextQuestion()
    }
    
    @IBAction func multipalButtonAnswerPressed() {
        for (multipalSwitch, answer) in zip(multipalSwitches, currentAnswers) {
            if multipalSwitch.isOn {
                answersChosen.append(answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let index = lrintf(rangedSlider.value) // извлечение ответа в соответствии с положением слайдера lrintf- округлени до целых имеено флоат
        answersChosen.append(currentAnswers[index])
        nextQuestion()
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
        case .single: showSingleStackView(with: currentAnswers)
        case .multipal: showMultipalSteckView(with: currentAnswers)
        case .ranged: showRangeStackView(with: currentAnswers)
        }
    }
    private func showSingleStackView(with answers: [Answer]) { // отабразить стек с одиночнимы ответами
        singleStackView.isHidden.toggle()
        //присвоение каждой кнопке название
        for (button, answer) in zip(singleButotns, answers) {
            button.setTitle(answer.title, for: .normal)
        }
        
    }
    
    private func showMultipalSteckView(with answers: [Answer]) {
        multipalStackView.isHidden.toggle()
        
        for (lable, answer) in zip(multipalLabels, answers) {
            lable.text = answer.title
        }
    }
    
    private func showRangeStackView(with answers: [Answer]) {
        rangeStackView.isHidden.toggle()
        
        rangedLables.first?.text = answers.first?.title
        rangedLables.last?.text = answers.last?.title
        
    }
    
    private func nextQuestion() { // переход к следующему вопросу
        questionIndex += 1
        
        if questionIndex < questions.count { // проверяем закончились ли вопросы
            updateUI() // скрываються элементы, и все обновляеться
            return
        }
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}
