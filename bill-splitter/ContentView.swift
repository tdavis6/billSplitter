//
//  ContentView.swift
//  bill-splitter
//
//  Created by Tyler Davis on 5/22/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.00
    @State private var tipPercentage = 20
    @State private var numberOfPeople: Int = 2
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 10, 15, 18, 20, 22, 25]
    
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
                    let peopleCount = Double(numberOfPeople)
                    let tipSelection = Double(tipPercentage)
                    
                    let tipValue = tipSelection / 100 * checkAmount
                    let grandTotal = checkAmount + tipValue
                    let amountPerPerson = grandTotal / peopleCount
                    
                    return amountPerPerson
                }
                let tipValue = Double(tipPercentage) / 100 * checkAmount
                let grandTotal = tipValue + checkAmount
                /*Section("Tip Total") {
                    Text(tipValue, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Grand Total") {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Total Per Person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }*/
                Section("") {
                    Text("Tip Total: \(tipValue, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                    Text("Grand Total: \(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                    Text("Total Per Person: \(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                }
                Section("") {
                    ShareLink(item: "Tip Total: \(tipValue.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))\nGrand Total: \(grandTotal.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))\nTotal Per Person: \(totalPerPerson.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))")
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
