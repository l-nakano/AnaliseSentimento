import Foundation
import NaturalLanguage

struct UserTweet: Decodable, Identifiable {
    let id: String
    let text: String
}

extension UserTweet {
    func getSentimentScore() -> String {
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = self.text
        let (sentiment, _) = tagger.tag(at: self.text.startIndex, unit: .paragraph, scheme: .sentimentScore)
        let sentimentScore = Double(sentiment?.rawValue ?? "0") ?? 0.0
        switch sentimentScore {
        case -1..<(-0.35):
            return "☹️"
        case -0.35..<0.31:
            return "😐"
        default:
            return "😁"
        }
    }
}
