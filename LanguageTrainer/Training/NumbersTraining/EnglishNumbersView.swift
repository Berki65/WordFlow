import SwiftUI

struct EnglishNumberView: View {
    // MARK: - State Properties
    @State private var givenNumber = 0
    @State private var userInput = ""
    @State private var selectedNumberType: NumberType = .Cardinal
    @State private var friendlyNumberMode = false
    @State private var selectedMaxValue = 10000
    @State private var showAnswer = false

    // MARK: - Enum
    enum NumberType: String, CaseIterable {
        case Cardinal
        case Ordinal
    }

    let maxValueOptions = [10, 100, 1000, 10000, 100000, 1000000, 10000000]

    // MARK: - Body
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.green.opacity(0.2), Color.green.opacity(0.5)]),
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

    // MARK: - Controls Section
    private var controlsSection: some View {
        VStack(spacing: 15) {
            numberTypePicker

            Toggle("Friendly Mode", isOn: $friendlyNumberMode)
                .toggleStyle(SwitchToggleStyle(tint: Color.purple))

            Toggle("Show Answer", isOn: $showAnswer)
                .toggleStyle(SwitchToggleStyle(tint: Color.blue))

            maxValuePicker
        }
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
                .background(Color.white.opacity(0.3))
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
                Text("\(value)").tag(value)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }

    // MARK: - Methods
    private func convertedNumberText() -> String {
        switch selectedNumberType {
        case .Cardinal:
            return numberToWords(givenNumber)
        case .Ordinal:
            return numberToOrdinalWords(givenNumber)
        }
    }

    private func randomNumberGenerator() -> Int {
        let rawNumber = Int.random(in: 0..<selectedMaxValue)
        if friendlyNumberMode && rawNumber >= 1000 {
            return (rawNumber / 1000) * 1000
        }
        return rawNumber
    }

    private func nextNumber() {
        givenNumber = randomNumberGenerator()
    }

    private func numberToWords(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }

    private func numberToOrdinalWords(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }

    private func checkForAnswer() {
        let correctAnswer = convertedNumberText().trimmingCharacters(in: .whitespacesAndNewlines)
        if userInput.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == correctAnswer.lowercased() {
            userInput = ""
            nextNumber()
        }
    }
}

#Preview {
    EnglishNumberView()
}
