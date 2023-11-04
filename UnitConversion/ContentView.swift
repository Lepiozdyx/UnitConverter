//
//  ContentView.swift
//  UnitConversion
//
//  Created by Alex on 24.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var inputNumber = 36.6
    @State private var inputUnit = "Celsius"
    @State private var outputUnit = "Fahrenheit"
    @FocusState private var isFocused: Bool
    
    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    
    private var convertedUnits: Double {
        let baseUnit: Double
        
        switch inputUnit {
        case "Celsius":
            baseUnit = inputNumber + 273.15
        case "Fahrenheit":
            baseUnit = (inputNumber - 32) * 5/9 + 273.15
        default:
            baseUnit = inputNumber
        }
        
        switch outputUnit {
        case "Celsius":
            return baseUnit - 273.15
        case "Fahrenheit":
            return (baseUnit - 273.15) * 9/5 + 32
        default:
            return baseUnit
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input unit") {
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("Enter a number", value: $inputNumber, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                }
                
                Section("Output unit") {
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text("\(convertedUnits.formatted()) \(outputUnit)")
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                if isFocused {
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
