//
//  GameViewController.swift
//  QuizGame
//
//  Created by Rares Marina on 1/9/24.
//
//
import UIKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var viewModel = QuizViewModel()

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        viewModel.loadQuestions()
        showNextQuestion()
    }

    private func showNextQuestion() {
        guard let currentQuestion = viewModel.getCurrentQuestion() else {
            showGameResult()
            return
        }

        label.text = currentQuestion.text
        imageView.image = currentQuestion.image
        table.reloadData()
    }

    private func showGameResult() {
        let score = viewModel.getScore()
        let alert = UIAlertController(title: "Congratulations", message: "You finish the game with \(score) points", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Finish", style: .cancel) {_ in
            self.dismiss(animated: true, completion: nil)
        })
        present(alert, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCurrentQuestion()?.answers.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.getCurrentQuestion()?.answers[indexPath.row].text
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard viewModel.submitAnswer(atIndex: indexPath.row) else {
            return
        }

        if viewModel.moveToNextQuestion() {
            showNextQuestion()
        } else {
            showGameResult()
        }
    }
}
