//
//  QuizViewModel.swift
//  QuizGame
//
//  Created by Rares Marina on 1/12/24.
//
import UIKit
import Foundation

class QuizViewModel {
    private var gameModels = [Question]()
    private var currentQuestionIndex = 0
    private var score = 0

    func loadQuestions() {
                gameModels.append(Question(text: "Which planet in our solar system is known as the Red Planet?",
                                           answers: [Answer(text: "Venus", correct: false),
                                                     Answer(text: "Jupiter", correct: false),
                                                     Answer(text: "Saturn", correct: false),
                                                     Answer(text: "Mars", correct: true)],
                                           image: UIImage(named: "mars")))
                gameModels.append(Question(text: "What is the largest planet in our solar system?",
                                           answers: [Answer(text: "Venus", correct: false),
                                                     Answer(text: "Mars", correct: false),
                                                     Answer(text: "Saturn", correct: true),
                                                     Answer(text: "Jupiter ", correct: true)],
                                           image: UIImage(named: "jupiter")))
                gameModels.append(Question(text: "Which planet is known for its impressive rings?",
                                           answers: [Answer(text: "YCR3", correct: false),
                                                     Answer(text: "Saturn", correct: true),
                                                     Answer(text: "C3PO", correct: false),
                                                     Answer(text: "Jupiter", correct: false)],
                                           image: UIImage(named: "saturn")))
                gameModels.append(Question(text: "How many moons (natural satellites) does Earth have?",
                                           answers: [Answer(text: "2", correct: false),
                                                     Answer(text: "1", correct: true),
                                                     Answer(text: "0", correct: false),
                                                     Answer(text: "7", correct: false)],
                                           image: UIImage(named: "moon")))
                gameModels.append(Question(text: "Which planet is considered a dwarf planet in our solar system?",
                                           answers: [Answer(text: "Earth", correct: false),
                                                     Answer(text: "Saturn", correct: false),
                                                     Answer(text: "Pluto", correct: true),
                                                     Answer(text: "Jupiter", correct: false)],
                                           image: UIImage(named: "pluto")))
    }

    func getCurrentQuestion() -> Question? {
        guard currentQuestionIndex < gameModels.count else {
            return nil
        }
        return gameModels[currentQuestionIndex]
    }

    func submitAnswer(atIndex index: Int) -> Bool {
        guard let currentQuestion = getCurrentQuestion(), index < currentQuestion.answers.count else {
            return false
        }

        let selectedAnswer = currentQuestion.answers[index]
        if selectedAnswer.correct {
            score += 1
        }

        return true
    }

    func moveToNextQuestion() -> Bool {
        currentQuestionIndex += 1
        return currentQuestionIndex < gameModels.count
    }

    func getScore() -> Int {
        return score
    }
}
