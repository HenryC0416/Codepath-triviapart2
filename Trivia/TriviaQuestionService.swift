import Foundation

class TriviaQuestionService {
    static func fetchQuestions(completion: @escaping ([Questions]) -> Void) {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Request error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data returned")
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(TriviaResponse.self, from: data)

                DispatchQueue.main.async {
                    completion(response.results)
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }

        task.resume()
    }
}
