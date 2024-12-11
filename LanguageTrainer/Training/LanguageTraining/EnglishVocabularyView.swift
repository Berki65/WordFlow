import SwiftUI

struct EnglishVocabularyView: View {
    @State private var vocabulary = [
        ("hello", "안녕하세요"),
        ("thank you", "감사합니다"),
        ("sorry", "죄송합니다"),
        ("I love you", "사랑해요"),
        ("yes", "네"),
        ("no", "아니요"),
        ("goodbye", "안녕히 가세요"),
        ("stay well", "안녕히 계세요"),
        ("where is it?", "어디예요?"),
        ("how much is it?", "얼마예요?"),
        ("it's delicious", "맛있어요"),
        ("slowly", "천천히"),
        ("quickly", "빠르게"),
        ("help me", "도와주세요"),
        ("it's okay", "괜찮아요"),
        ("I understand", "알겠습니다"),
        ("I don't understand", "모르겠습니다"),
        ("please say it again", "다시 말해 주세요"),
        ("do you speak English?", "영어 하세요?"),
        ("good", "좋아요"),
        ("I don't like it", "싫어요"),
        ("please wait", "기다려 주세요"),
        ("bathroom", "화장실"),
        ("hospital", "병원"),
        ("police station", "경찰서"),
        ("water", "물"),
        ("rice/meal", "밥"),
        ("Korea", "한국"),
        ("person", "사람"),
        ("name", "이름"),
        ("today", "오늘"),
        ("tomorrow", "내일"),
        ("yesterday", "어제"),
        ("time", "시간"),
        ("now", "지금"),
        ("to go", "가다"),
        ("to come", "오다"),
        ("to do", "하다"),
        ("to eat", "먹다"),
        ("to drink", "마시다"),
        ("to see", "보다"),
        ("to know", "알다"),
        ("to not know", "모르다"),
        ("to be good", "좋다"),
        ("to dislike", "싫다"),
        ("family", "가족"),
        ("friend", "친구"),
        ("school", "학교"),
        ("company", "회사"),
        ("house/home", "집")
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
            
            Spacer()
        }
        .padding()
        .navigationTitle("English Vocabulary")
    }
    
    func checkTranslation() {
        let correctTranslation = vocabulary[currentIndex].1.lowercased()
        if userTranslation.lowercased() == correctTranslation {
            feedbackMessage = "Correct!"
            // Automatically load the next word
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Delay to show feedback
                nextWord()
            }
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
