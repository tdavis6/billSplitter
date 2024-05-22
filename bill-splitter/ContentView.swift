//
//  ContentView.swift
//  bill-splitter
//
//  Created by Tyler Davis on 5/22/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var tipPercentage = 20
    @State private var numberOfPeople: Int = 1
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 18, 20, 22, 25, 0]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("What is the total bill amount?") {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                Section("How many people are splitting the bill?") {
                    TextField("Number of people", value: $numberOfPeople, format: .number)
                        .keyboardType(.numberPad)
                        .focused($amountIsFocused)
                }
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                var totalPerPerson: Double {
                    let peopleCount = Double(numberOfPeople + 2)
                    let tipSelection = Double(tipPercentage)
                    
                    let tipValue = tipSelection / 100 * checkAmount
                    let grandTotal = checkAmount + tipValue
                    let amountPerPerson = grandTotal / peopleCount
                    
                    return amountPerPerson
                }
                Section("Total Per Person:") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Subtotal:") {
                    Text(checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("Bill Splitter")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
