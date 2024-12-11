import SwiftUI

struct KoreanVocabularyView: View {
    @State private var vocabulary = [
        ("안녕하세요", "hello"),
        ("감사합니다", "thank you"),
        ("죄송합니다", "sorry"),
        ("사랑해요", "I love you"),
        ("네", "yes"),
        ("아니요", "no"),
        ("안녕히 가세요", "goodbye"),
        ("안녕히 계세요", "stay well"),
        ("어디예요?", "where is it?"),
        ("얼마예요?", "how much is it?"),
        ("맛있어요", "it's delicious"),
        ("천천히", "slowly"),
        ("빠르게", "quickly"),
        ("도와주세요", "help me"),
        ("괜찮아요", "it's okay"),
        ("알겠습니다", "I understand"),
        ("모르겠습니다", "I don't understand"),
        ("다시 말해 주세요", "please say it again"),
        ("영어 하세요?", "do you speak English?"),
        ("좋아요", "good"),
        ("싫어요", "I don't like it"),
        ("기다려 주세요", "please wait"),
        ("화장실", "bathroom"),
        ("병원", "hospital"),
        ("경찰서", "police station"),
        ("물", "water"),
        ("밥", "rice/meal"),
        ("한국", "Korea"),
        ("사람", "person"),
        ("이름", "name"),
        ("오늘", "today"),
        ("내일", "tomorrow"),
        ("어제", "yesterday"),
        ("시간", "time"),
        ("지금", "now"),
        ("가다", "to go"),
        ("오다", "to come"),
        ("하다", "to do"),
        ("먹다", "to eat"),
        ("마시다", "to drink"),
        ("보다", "to see"),
        ("알다", "to know"),
        ("모르다", "to not know"),
        ("좋다", "to be good"),
        ("싫다", "to dislike"),
        ("가족", "family"),
        ("친구", "friend"),
        ("학교", "school"),
        ("회사", "company"),
        ("집", "house/home")
    ]
    @State private var currentIndex = Int.random(in: 0..<50)
    @State private var userTranslation = ""
    @State private var feedbackMessage = ""
    
    var body: some View {
        VStack {
            Text("Translate the following word:")
                .font(.headline)
                .padding()
            
            Text(vocabulary[currentIndex].0)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            TextField("Enter your translation...", text: $userTranslation)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onSubmit {
                    checkTranslation()
                }
            
            Button("Check") {
                checkTranslation()
            }
            .padding()
            .buttonStyle(.borderedProminent)
            
            Text(feedbackMessage)
                .font(.headline)
                .padding()
                .foregroundColor(feedbackMessage == "Correct!" ? .green : .red)
            
            Button("Next Word") {
                nextWord()
            }
            .padding()
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Korean Vocabulary")
    }
    
    func checkTranslation() {
        let correctTranslation = vocabulary[currentIndex].1.lowercased()
        if userTranslation.lowercased() == correctTranslation {
            feedbackMessage = "Correct!"
        } else {
            feedbackMessage = "Try again!"
        }
    }
    
    func nextWord() {
        currentIndex = Int.random(in: 0..<vocabulary.count)
        userTranslation = ""
        feedbackMessage = ""
    }
}
