//
//  ContentView.swift
//  Estudando Calculadora
//
//  Created by Vitória Beltrão Wenceslau do Ó on 07/05/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var years: Int?
    @State var months: Int?
    @State var result: Int?
    @State var portesSelected = Portes.pequeno
    @State var showAlert = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack{
                    ZStack{
                        Image("header")
                        Text("Cãoculadora")
                            .foregroundStyle(.white)
                            .font(.custom("SignikaNegative-Medium", size: 34))
                    }
                    
                    VStack(alignment: .leading) {
                        TextModifiers(weight: true,
                                      text: "Olá!",
                                      size: 36,
                                      padding: 12)
                        TextModifiers(weight: false,
                                      text: "Saiba a idade humana do seu cão!",
                                      size: 22,
                                      padding: 16)
                        TextModifiers(weight: false,
                                      text: "Quantos anos ele tem?",
                                      size: 16,
                                      padding: 0)
                        TextFieldModifiers(placeholder: "Anos", text: $years)
                        TextModifiers(weight: false,
                                      text: "E quantos meses?",
                                      size: 16,
                                      padding: 0)
                        TextFieldModifiers(placeholder: "Meses", text: $months)
                        TextModifiers(weight: false,
                                      text: "Qual o porte do seu pet?",
                                      size: 16,
                                      padding: 0)
                        
                        Picker("Portes", selection: $portesSelected) {
                            ForEach(Portes.allCases, id:\.self) { porte in
                                Text(porte.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        
                        if let result {
                            VStack(alignment: .center, spacing: 20) {
                                Spacer()
                                TextModifiers(weight: false,
                                              text: "Seu cachorro tem, em idade humana:",
                                              size: 20,
                                              padding: 0)
                                
                                TextModifiers(weight: true,
                                              text: "\(result) anos!",
                                              size: 36,
                                              padding: 0)
                                Spacer()
                            } .frame(maxWidth: .infinity)
                                .frame(height: 160)
                                .contentTransition(.numericText())
                            
                            
                        } else {
                            Image("dog")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 120)
                                .frame(maxWidth: .infinity)
                                .shadow(radius: 5)
                                .padding(20)
                        }
                        
                        Spacer()
                        
                        
                        Button(action: processYears,
                               label: {
                            ZStack {
                                Rectangle()
                                    .foregroundStyle(.indigo)
                                    .frame(width: 345, height: 50)
                                    .clipShape(.rect(cornerRadius: 12))
                                
                                Text("Cãocular")
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                            } .padding(.leading, 8)
                        })
                    } .padding()
                }
                .background(Color.background)
                
            } .background(
                VStack {
                    Color.darkindigo
                    Color.background
                }
            )
            .ignoresSafeArea()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Campos obrigatórios"), message: Text("Preencha todos os campos para calcular."), dismissButton: .default(Text("OK")))
               }
    }
    
    func processYears() {
        
        guard let years, let months else {
            showAlert = true
            return
        }
        
        guard months > 0 || months > 0 else {
            
            return
        }
        
        let multiplicador: Int
        switch portesSelected {
        case .pequeno:
            multiplicador = 6
        case .medio:
            multiplicador = 7
        case .grande:
            multiplicador = 8
        }
        
        withAnimation{
            result = years * multiplicador + months * multiplicador / 12
        }
    }
}

struct TextModifiers: View {
    
    var weight: Bool
    var text: String
    var size: CGFloat
    var padding: CGFloat
    
    init(weight: Bool, text: String, size: CGFloat, padding: CGFloat) {
        self.weight = weight
        self.text = text
        self.size = size
        self.padding = padding
    }
    
    var body: some View {
        Text(text)
            .fontWeight(weight ? .bold : .semibold)
            .font(.system(size: size))
            .foregroundColor(Color.indigo)
            .padding(.bottom, padding)
        
    }
}

struct TextFieldModifiers: View {
    
    var placeholder: String
    @Binding var text: Int?
    
    init(placeholder: String, text: Binding<Int?>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    var body: some View {
        TextField(placeholder,
                  value: $text,
                  format: .number)
        .textFieldStyle(.roundedBorder)
        .keyboardType(.numberPad)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.indigo)
                .opacity(0.4)
            
        )
        .padding(.bottom, 20.0)
        
    }
}

enum Portes: String, CaseIterable {
    case pequeno = "Pequeno"
    case medio = "Médio"
    case grande = "Grande"
    
    
}



#Preview {
    ContentView()
}
