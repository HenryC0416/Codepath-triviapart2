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
    
    var questions: [Questions] = [
        
        Questions(
            questionNum:"1",
            topic: "Math",
            question: "What is 1 + 1",
            choices:["2","4","5","6"],
            answer: 0),
        Questions(
            questionNum:"2",
            topic: "Geography",
            question: "What is the capital of Thailand?",
            choices:["bangkok","china","new york","Paris"],
            answer:0 ),
        Questions(
            questionNum:"3",
            topic: "History",
            question:"Who was the first president of the US?",
            choices:["Barack Obama", "Donald Trump", "Abraham Lincoln" ,"George Washington"],
            answer:3)
    ]
    var currentQuestion = 0
    var numOfCorrectAnswr = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.layer.cornerRadius = 20.0
        questionLabel.layer.masksToBounds = true
        showQuestion()
        // Do any additional setup after loading the view.
    }
    
    func showQuestion(){
        
        let question = questions[currentQuestion]
        questionNumLabel.text = "Question: " + question.questionNum + "/" + String(questions.count)
        topicLabel.text = question.topic
        questionLabel.text = question.question
        for(index, button) in answerButtons.enumerated(){
            button.setTitle(question.choices[index], for: .normal)
        }
    }
    @IBAction func tappedChoices(_ sender: UIButton) {
        guard let selectedIndex = answerButtons.firstIndex(of: sender) else { return }
        let correctIndex = questions[currentQuestion].answer
        if(selectedIndex == correctIndex){
            numOfCorrectAnswr+=1
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
        currentQuestion = 0
        numOfCorrectAnswr = 0
        showQuestion()
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
    
    

