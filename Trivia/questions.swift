//
//  questions.swift
//  Trivia
//
//  Created by Henry Chen on 6/19/25.
//

import Foundation
import UIKit



struct Questions: Decodable{
       let category: String
       let type: String
       let question: String
       let correct_answer: String
       let incorrect_answers: [String]
  
}

struct TriviaResponse: Decodable {
    let response_code: Int
    let results: [Questions]
}


