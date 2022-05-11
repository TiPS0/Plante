//
//  ContentView.swift
//  Plante
//
//  Created by Tipso on 15/4/2565 BE.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Welcome()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Welcome: View {
    @State var viewFinished: Bool = false
    
    var body: some View {
        
        ZStack() {
            Login()
            
            ZStack() {
                Color(red: 116/255, green: 143/255, blue: 93/255).ignoresSafeArea()
                
                VStack() {
                    Text("Planté")
                        .font(.custom("FredokaOne-Regular", size: 50))
                        .foregroundColor(Color.white)
                }
                
            }
            .opacity(viewFinished ? 0 : 1)
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeInOut(duration: 0.7)) {
                    viewFinished = true
                }
            }
        }
        
    }
}

