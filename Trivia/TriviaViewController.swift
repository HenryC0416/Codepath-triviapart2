//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Henry Chen on 6/19/25.
//

import UIKit

class TriviaViewController: UIViewController {
    
    @IBOutlet weak var questionNumLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet var answerButtons: [UIButton]!
    
    private var questions = [Questions]()
    var currentQuestion = 0
    var numOfCorrectAnswr = 0
    var choices: [String] = []
    var correctAnswerIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.layer.cornerRadius = 20.0
        questionLabel.layer.masksToBounds = true
        loadQuestions()
        // Do any additional setup after loading the view.
    }
    func loadQuestions() {
        TriviaQuestionService.fetchQuestions { fetchedQuestions in
            self.questions = fetchedQuestions
            self.currentQuestion = 0
            self.numOfCorrectAnswr = 0
            self.showQuestion()
        }
    }
    
    func showQuestion(){
        
        let question = questions[currentQuestion]
        questionNumLabel.text = "Question: \(currentQuestion + 1)/\(questions.count)"
        topicLabel.text = questions[currentQuestion].category
        questionLabel.text = question.question
        var allAnswers = question.incorrect_answers + [question.correct_answer]
           allAnswers.shuffle()
           self.choices = allAnswers
           self.correctAnswerIndex = allAnswers.firstIndex(of: question.correct_answer) ?? 0

          
           for (index, button) in answerButtons.enumerated() {
               if index < allAnswers.count {
                   button.setTitle(allAnswers[index], for: .normal)
                   button.isHidden = false
               } else {
                   button.isHidden = true
               }
           }
       }
    @IBAction func tappedChoices(_ sender: UIButton) {
        guard let selectedIndex = answerButtons.firstIndex(of: sender) else { return }
        if selectedIndex == correctAnswerIndex {
               numOfCorrectAnswr += 1
           }
       
        
        if(currentQuestion<questions.count-1){
            currentQuestion+=1
            showQuestion()
        }
        else {
            showFinalSocre()
        }
    }
        
    func resetQuiz() {
        loadQuestions()
    }
        
    func showFinalSocre(){
        let alert = UIAlertController(
            title: "Game Over!",
            message: "Final Score: \(numOfCorrectAnswr)/\(questions.count)",
            preferredStyle: .alert
        )
        
        
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in self.resetQuiz() }))
            
            present(alert, animated: true, completion: nil)
        
    }
        
   
}

        

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    

