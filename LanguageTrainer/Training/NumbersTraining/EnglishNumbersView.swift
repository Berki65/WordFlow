import SwiftUI

struct EnglishNumberView: View {
    @State private var givenNumber = 0
    @State private var userInput = ""
    @State private var selectedNumberType: NumberType = .Ordinal
    @State private var friendlyNumberMode = false
    @State private var selectedMaxValue = 10000
    @State private var showAnswer = false
    @State private var feedbackMessage = ""
    @State private var feedbackColor = Color.primary

    enum NumberType: String, CaseIterable {
        case Cardinal
        case Ordinal
    }

    let maxValueOptions = [10, 100, 1000, 10000, 100000, 1000000, 10000000]

    var body: some View {
        VStack {
            // Settings
            VStack(spacing: 20) {
                Picker("Number Type", selection: $selectedNumberType) {
                    ForEach(NumberType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                Toggle("Friendly Mode", isOn: $friendlyNumberMode)
                Toggle("Show Answer", isOn: $showAnswer)

                Picker("Max Value", selection: $selectedMaxValue) {
                    ForEach(maxValueOptions, id: \.self) { value in
                        Text("\(value)").tag(value)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            .padding()

            Spacer()

            // Question Section
            VStack(spacing: 20) {
                Text("\(givenNumber)")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                if showAnswer {
                    Text("Answer: \(convertToEnglish(givenNumber))")
                        .foregroundColor(.blue)
                }

                TextField("Type your answer here...", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onSubmit {
                        checkForAnswer()
                    }
            }

            // Feedback
            Text(feedbackMessage)
                .font(.headline)
                .foregroundColor(feedbackColor)
                .padding()

            // Actions
            Button("Skip") {
                nextNumber()
                userInput = ""
                feedbackMessage = ""
            }
            .padding()
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
        .onAppear {
            nextNumber()
        }
    }

    // Generate next random number
    func randomNumberGenerator() -> Int {
        let rawNumber = Int.random(in: 1..<selectedMaxValue)
        if friendlyNumberMode && rawNumber >= 1000 {
            return (rawNumber / 1000) * 1000
        }
        return rawNumber
    }

    func nextNumber() {
        givenNumber = randomNumberGenerator()
    }

    // Convert to English representation
    func convertToEnglish(_ number: Int) -> String {
        switch selectedNumberType {
        case .Cardinal:
            return numberToWords(number)
        case .Ordinal:
            return numberToOrdinalWords(number)
        }
    }

    // Convert number to cardinal words
    func numberToWords(_ number: Int) -> String {
        guard number > 0 else { return "zero" }

        let belowTwenty = ["", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten",
                           "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
        let tens = ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
        let units = ["", "thousand", "million", "billion"]

        var num = number
        var result = ""
        var unitIndex = 0

        while num > 0 {
            let part = num % 1000
            if part > 0 {
                let partWords = convertBelowThousand(part)
                result = partWords + (unitIndex > 0 ? " \(units[unitIndex]) " : "") + result
            }
            num /= 1000
            unitIndex += 1
        }

        return result.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func convertBelowThousand(_ number: Int) -> String {
        let belowTwenty = ["", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten",
                           "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
        let tens = ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]

        var num = number
        var result = ""

        if num >= 100 {
            let hundreds = num / 100
            result += belowTwenty[hundreds] + " hundred"
            num %= 100
            if num > 0 {
                result += " and "
            }
        }

        if num >= 20 {
            let tensPlace = num / 10
            result += tens[tensPlace]
            num %= 10
            if num > 0 {
                result += "-"
            }
        }

        if num > 0 {
            result += belowTwenty[num]
        }

        return result
    }

    // Convert number to ordinal words
    func numberToOrdinalWords(_ number: Int) -> String {
        let cardinal = numberToWords(number)
        if cardinal.hasSuffix("one") {
            return cardinal.replacingOccurrences(of: "one", with: "first")
        } else if cardinal.hasSuffix("two") {
            return cardinal.replacingOccurrences(of: "two", with: "second")
        } else if cardinal.hasSuffix("three") {
            return cardinal.replacingOccurrences(of: "three", with: "third")
        } else if cardinal.hasSuffix("ve") {
            return cardinal.replacingOccurrences(of: "ve", with: "fth")
        } else {
            return cardinal + "th"
        }
    }

    func checkForAnswer() {
        let correctAnswer = convertToEnglish(givenNumber).trimmingCharacters(in: .whitespacesAndNewlines)
        if userInput.trimmingCharacters(in: .whitespacesAndNewlines) == correctAnswer {
            feedbackMessage = "Correct! 🎉"
            feedbackColor = .green
            userInput = ""
            nextNumber()
        } else {
            feedbackMessage = "Try again! ❌"
            feedbackColor = .red
        }
    }
}

#Preview {
    EnglishNumberView()
}
