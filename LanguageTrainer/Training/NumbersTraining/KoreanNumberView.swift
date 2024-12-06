import SwiftUI

struct KoreanNumberView: View {
    @State private var givenNumber = 0
    @State private var userInput = ""
    @State private var selectedNumberType: NumberType = .Sino
    @State private var friendlyNumberMode = false
    @State private var maxValue = 10000001
    @State private var selectedMaxValue = 10000
    @State private var showAnswer = false
    
    var koreanSinoInEnglishToNine = ["yeong", "il", "i", "sam", "sa", "o", "yuk", "chil", "pal", "gu"]
    var koreanSinoInKoreanToNine = ["영", "일", "이", "삼", "사", "오", "육", "칠", "팔", "구"]
    var koreanNativeInKoreanToNine = ["공", "하나", "둘", "셋", "넷", "다섯", "여섯", "일곱", "여덟", "아홉"]
    var koreanTenner = ["십", "백", "천", "만", "십만", "백만", "천만", "억", "조"]
    
    enum NumberType: String, CaseIterable {
        case Sino
        case Native
    }
    
    let maxValueOptions = [10, 100, 1000, 10000, 100000, 1000000, 10000000]
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Picker("Number Type", selection: $selectedNumberType) {
                    ForEach(NumberType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Toggle("Friendly Mode", isOn: $friendlyNumberMode)
                Toggle("Show Answer", isOn: $showAnswer)
                
                Picker("Select Max Value", selection: $selectedMaxValue) {
                    ForEach(maxValueOptions, id: \.self) { value in
                        if !(selectedNumberType == .Native && value > 100) {  // Disable values above 100 for Native numbers
                            Text("\(value)").tag(value)
                        }
                    }
                }
                .pickerStyle(.menu)
                .padding(.horizontal)
            }
            .padding()
            
            Spacer()
            
            VStack {
                Text("\(givenNumber)")
                    .font(.largeTitle)
                    .padding()
                
                if(showAnswer && selectedNumberType == .Sino) {
                    Text("\(convertToSinoKorean(givenNumber))")
                }
                else if(showAnswer && selectedNumberType == .Native) {
                    Text("\(convertToNativeKorean(givenNumber))")
                }
                
                TextField("Input", text: $userInput)
                    .keyboardType(.default)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: userInput) {
                        checkForAnswer()
                    }
                
                Button("SKIP") {
                    nextNumber()
                }
                .padding()
            }
            Spacer()
        }
        .onAppear {
            nextNumber()
        }
    }
    
    func randomNumberGenerator() {
        maxValue = selectedMaxValue
        
        // Ensure Native Korean doesn't generate numbers above 99
        if selectedNumberType == .Native {
            maxValue = min(maxValue, 100)
        }
        
        givenNumber = Int.random(in: 0..<maxValue)
        if friendlyNumberMode && givenNumber >= 1000 {
            givenNumber = (givenNumber / 1000) * 1000
        }
    }
    
    func nextNumber() {
        randomNumberGenerator()
    }
    
//    func convertToSinoKorean(_ number: Int) -> String {
//        guard number > 0 else {
//            return koreanSinoInKoreanToNine[0]
//        }
//        
//        var result = ""
//        var num = number
//        var unitIndex = 0
//        
//        let units = ["", "십", "백", "천", "만", "십만", "백만", "천만", "억", "조"]
//        
//        while num > 0 {
//            let part = num % 10
//            if part != 0 {
//                let partString = (part > 1 || unitIndex == 0 || unitIndex >= 4) ? koreanSinoInKoreanToNine[part] + units[unitIndex] : units[unitIndex]
//                result = partString + result
//            }
//            num /= 10
//            unitIndex += 1
//        }
//        
//        return result
//    }
    
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
    
    func checkForAnswer() {
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
