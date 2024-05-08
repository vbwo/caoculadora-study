//
//  ContentView.swift
//  Estudando Calculadora
//
//  Created by Vitória Beltrão Wenceslau do Ó on 07/05/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var textoAnos: Int?
    @State var textoMeses: Int?
    @State var textoPorte: Int?
    
    var body: some View {
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
                              padding: 20)
                TextModifiers(weight: false,
                              text: "Qual a idade do seu cão?",
                              size: 24,
                              padding: 16)
                TextModifiers(weight: false,
                              text: "Anos",
                              size: 16,
                              padding: 0)
                TextFieldModifiers(placeholder: "Anos", text: $textoAnos)
                TextModifiers(weight: false,
                              text: "Meses",
                              size: 16,
                              padding: 0)
                TextFieldModifiers(placeholder: "Meses", text: $textoMeses)
                TextModifiers(weight: false,
                              text: "Porte",
                              size: 16,
                              padding: 0)
            } .padding()
            
            Spacer()
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
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
            
        }.ignoresSafeArea()
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
        .padding(.bottom, 20.0)
        .textFieldStyle(.roundedBorder)
        .keyboardType(.numberPad)
    }
}


#Preview {
    ContentView()
}
