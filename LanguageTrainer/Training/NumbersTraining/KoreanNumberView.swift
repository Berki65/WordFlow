import SwiftUI

struct KoreanNumberView: View {
    // MARK: - State Properties
    @State private var givenNumber = 0
    @State private var userInput = ""
    @State private var selectedNumberType: NumberType = .Sino
    @State private var friendlyNumberMode = false
    @State private var selectedMaxValue = 10000
    @State private var showAnswer = false
    
    // MARK: - Constants
    let koreanSinoInKoreanToNine = ["영", "일", "이", "삼", "사", "오", "육", "칠", "팔", "구"]
    let koreanNativeInKoreanToNine = ["공", "하나", "둘", "셋", "넷", "다섯", "여섯", "일곱", "여덟", "아홉"]
    let koreanTenner = ["십", "백", "천", "만", "십만", "백만", "천만", "억", "조"]
    let maxValueOptions = [10, 100, 1000, 10000, 100000, 1000000, 10000000]
    
    // MARK: - Enum
    enum NumberType: String, CaseIterable {
        case Sino
        case Native
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.red.opacity(0.2), Color.red.opacity(0.5)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Card Display Section
                cardSection
                    .padding(.horizontal)
                
                // Bottom Sheet Input Section
                bottomSheetInputSection
                
                Spacer()
                
                // Controls Section
                controlsSection
                    .padding(.horizontal)
            }
        }
        .onAppear {
            nextNumber()
        }
    }
    
    // MARK: - Card Section
    private var cardSection: some View {
        VStack(spacing: 10) {
            Text("Practice Mode")
                .font(.title2.bold())
                .foregroundColor(.primary)
            
            Text("What's this number?")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("\(givenNumber)")
                .font(.system(size: 64, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
                .padding()
            
            if showAnswer {
                Text(convertedNumberText())
                    .font(.title3)
                    .foregroundColor(.blue)
                    .padding(.top, 5)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.85))
                .shadow(radius: 10)
        )
    }
    
    // MARK: - Bottom Sheet Input Section
    private var bottomSheetInputSection: some View {
        VStack(spacing: 10) {
            TextField("Type your answer", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.white.opacity(0.85))
                .cornerRadius(10)
                .padding(.horizontal)
                .onChange(of: userInput) {
                    checkForAnswer()
                }
            
            Button(action: {
                nextNumber()
                userInput = ""
            }) {
                Text("Skip")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(10)
            }
            .padding(.horizontal)
        }
        .padding(.top)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.85))
                .shadow(radius: 10)
        )
        .padding(.horizontal)
    }
    
    // MARK: - Controls Section
    private var controlsSection: some View {
        VStack(spacing: 15) {
            numberTypePicker
            
            Toggle("Friendly Mode", isOn: $friendlyNumberMode)
                .toggleStyle(SwitchToggleStyle(tint: Color.blue))
            
            Toggle("Show Answer", isOn: $showAnswer)
                .toggleStyle(SwitchToggleStyle(tint: Color.green))
            
            maxValuePicker
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.85))
                .shadow(radius: 10)
        )
    }
    
    // MARK: - Views
    private var numberTypePicker: some View {
        Picker("Number Type", selection: $selectedNumberType) {
            ForEach(NumberType.allCases, id: \.self) { type in
                Text(type.rawValue).tag(type)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    private var maxValuePicker: some View {
        Picker("Max Value", selection: $selectedMaxValue) {
            ForEach(maxValueOptions, id: \.self) { value in
                if !(selectedNumberType == .Native && value > 100) {
                    Text("\(value)").tag(value)
                }
            }
        }
        .pickerStyle(MenuPickerStyle())
    }
    
    // MARK: - Methods
    private func convertedNumberText() -> String {
        switch selectedNumberType {
        case .Sino:
            return convertToSinoKorean(givenNumber)
        case .Native:
            return convertToNativeKorean(givenNumber)
        }
    }
    
    private func randomNumberGenerator() {
        var maxValue = selectedMaxValue
        
        if selectedNumberType == .Native {
            maxValue = min(maxValue, 100)
        }
        
        givenNumber = Int.random(in: 0..<maxValue)
        if friendlyNumberMode && givenNumber >= 1000 {
            givenNumber = (givenNumber / 1000) * 1000
        }
    }
    
    private func nextNumber() {
        randomNumberGenerator()
    }
    
    
    func convertToSinoKorean(_ number: Int) -> String {
        guard number > 0 else {
            return koreanSinoInKoreanToNine[0]
        }
        
        var result = ""
        
        let koreanSinoInKoreanToNine = ["영", "일", "이", "삼", "사", "오", "육", "칠", "팔", "구"]
        
        
        if number >= 100000 {  // Handle numbers above 100,000
            let firstTwoDigits = number / 10000
            let firstPart = convertTwoDigitNumberToKorean(firstTwoDigits, omitOne: true)  // Pass omitOne: true here
            
            result += firstPart + "만"
            
            let remainder = number % 10000
            if remainder > 0 {
                result += convertToSinoKorean(remainder)
            }
        } else if number >= 10000 {  // Handle numbers between 10,000 and 99,999
            let tenThousands = number / 10000
            result += (tenThousands > 1 ? koreanSinoInKoreanToNine[tenThousands] : "") + "만"  // Omit "일" for 1만
            
            let remainder = number % 10000
            if remainder > 0 {
                result += convertToSinoKorean(remainder)
            }
        } else if number >= 1000 {  // Handle thousands
            let thousands = number / 1000
            result += (thousands > 1 ? koreanSinoInKoreanToNine[thousands] : "") + "천"  // Omit "일" for 1천
            
            let remainder = number % 1000
            if remainder > 0 {
                result += convertToSinoKorean(remainder)
            }
        } else if number >= 100 {  // Handle hundreds
            let hundreds = number / 100
            result += (hundreds > 1 ? koreanSinoInKoreanToNine[hundreds] : "") + "백"  // Omit "일" for 1백
            
            let remainder = number % 100
            if remainder > 0 {
                result += convertToSinoKorean(remainder)
            }
        } else if number >= 10 {  // Handle tens
            let tens = number / 10
            result += (tens > 1 ? koreanSinoInKoreanToNine[tens] : "") + "십"  // Omit "일" for 1십
            
            let remainder = number % 10
            if remainder > 0 {
                result += koreanSinoInKoreanToNine[remainder]
            }
        } else {  // Handle units (1 to 9)
            result = koreanSinoInKoreanToNine[number]
        }
        
        return result
    }
    
    func convertTwoDigitNumberToKorean(_ number: Int, omitOne: Bool = false) -> String {
        let koreanSinoInKoreanToNine = ["영", "일", "이", "삼", "사", "오", "육", "칠", "팔", "구"]
        
        var result = ""
        
        if number >= 10 {
            let tens = number / 10
            if !(tens == 1 && omitOne) {  // Omit "일" for tens when omitOne is true
                result += koreanSinoInKoreanToNine[tens]
            }
            result += "십"
        }
        
        let units = number % 10
        if units > 0 {
            result += koreanSinoInKoreanToNine[units]
        }
        
        return result
    }
    
    func convertToNativeKorean(_ number: Int) -> String {
        guard number <= 99 else {
            return "Unsupported"
        }
        
        if number <= 9 {
            return koreanNativeInKoreanToNine[number]
        } else {
            let tens = number / 10
            let units = number % 10
            let tensPart = tens > 1 ? koreanNativeInKoreanToNine[tens - 1] + " " + koreanTenner[0] : koreanTenner[0]
            let unitsPart = units > 0 ? " " + koreanNativeInKoreanToNine[units - 1] : ""
            return tensPart + unitsPart
        }
    }
    
    private func checkForAnswer() {
        let correctAnswer: String
        switch selectedNumberType {
        case .Sino:
            correctAnswer = convertToSinoKorean(givenNumber)
        case .Native:
            correctAnswer = convertToNativeKorean(givenNumber)
        }
        
        if userInput.trimmingCharacters(in: .whitespacesAndNewlines) == correctAnswer {
            userInput = ""
            nextNumber()
        }
    }
}

#Preview {
    KoreanNumberView()
}
