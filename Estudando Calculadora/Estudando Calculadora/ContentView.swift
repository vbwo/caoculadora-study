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
    
    let portes = ["Pequeno", "Médio", "Grande"]
    @State var porte = "Pequeno"
    
    var body: some View {
        ZStack {
            Color.background
            VStack{
                
                ZStack{
                    Image("header")
                    Text("Cãoculadora")
                        .foregroundStyle(.white)
                        .font(.custom("SignikaNegative-Medium", size: 34))
                } .padding(.bottom, -2)
                
                VStack(alignment: .leading) {
                    TextModifiers(weight: true,
                                  text: "Olá!",
                                  size: 36,
                                  padding: 12)
                    TextModifiers(weight: false,
                                  text: "Qual a idade do seu cão?",
                                  size: 24,
                                  padding: 16)
                    TextModifiers(weight: false,
                                  text: "Anos",
                                  size: 16,
                                  padding: 0)
                    TextFieldModifiers(placeholder: "Anos", text: $years)
                    TextModifiers(weight: false,
                                  text: "Meses",
                                  size: 16,
                                  padding: 0)
                    TextFieldModifiers(placeholder: "Meses", text: $months)
                    TextModifiers(weight: false,
                                  text: "Porte",
                                  size: 16,
                                  padding: 0)
                    
                    Picker("Portes", selection: $porte) {
                        ForEach(portes, id: \.self) { cadaPorte in
                            Text(cadaPorte)
                        }
                    } .pickerStyle(.segmented)
                    
                } .padding()
                
                
                Spacer()
                
                if let result {
                    VStack (spacing: 20) {
                        TextModifiers(weight: false,
                                      text: "Seu cachorro tem, em idade humana:",
                                      size: 20,
                                      padding: 0)
                        TextModifiers(weight: true,
                                      text: "\(result) anos!",
                                      size: 36,
                                      padding: 0)
                    }
                } else {
                    Image("dog")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 150)
                        .frame(maxWidth: .infinity)
                        .shadow(radius: 5)
                }
                
                Spacer()
                
                Button(action: processYears,
                       label: {
                    ZStack{
                        Rectangle()
                            .foregroundStyle(.indigo)
                            .frame(width: 345, height: 50)
                            .clipShape(.rect(cornerRadius: 12))
                        
                        Text("Cãocular")
                            .foregroundStyle(.white)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                })
                
                Spacer()
                
            }
        } .ignoresSafeArea()
    }
    
    func processYears() {
        
        guard let years, let months else {
            print("Preencha os campos acima para calcular.")
            return
        }
        
        guard months > 0 || months > 0 else {
            
            return
        }
        
        let multiplicador: Int
        
        switch porte {
        case "Pequeno":
            multiplicador = 6
        case "Médio":
            multiplicador = 7
        case "Grande":
            multiplicador = 8
        default:
            multiplicador = 0
        }
        
        result = years * multiplicador + months * multiplicador / 12
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


#Preview {
    ContentView()
}
