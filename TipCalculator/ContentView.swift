//
//  ContentView.swift
//  TipCalculator
//
//  Created by Adam Mekush on 17.12.23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State var value = 0.0
    let tips = [1, 2, 5, 10 , 15, 20]
    @State var selectedTip = 1
    
    @State var selectedPeople = 1
    
    @FocusState var isFocused
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Amount", value: $value, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .focused($isFocused)
                        #if os(macOS)
                            .padding()
                        #endif
                    } header: {
                        Text("Amount of money")
                    }
                    Picker("Tip", selection: $selectedTip) {
                        ForEach(tips, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.inline)
                    #if os(macOS)
                        .padding()
                    #endif
                    
                    Picker("Number of people", selection: $selectedPeople) {
                        ForEach(0..<101) {
                            Text("\($0)")
                        }
                    }
                    #if os(macOS)
                        .padding()
                    #endif
                    
                    Section {
                        Text(calculateTipPerPerson(value: value, tip: selectedTip, people: selectedPeople), format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        #if os(macOS)
                            .padding()
                        #endif
                    } header: {
                        Text("Tip per person")
                    }
                }
                .toolbar {
                    if isFocused {
                        Button("Done") {
                            isFocused = false
                        }
                    }
                }
            }
            .navigationTitle("Tip calculator")
        }
    }
    
    private func calculateTipPerPerson(value: Double, tip: Int, people: Int) -> Double {
        
        let result: Double = value/100.0*Double(tip)/Double(people)
        
        return result
    }
    
}

#Preview {
    ContentView()
}
