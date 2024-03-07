//
//  ContentView.swift
//  soda-music-swiftui
//
//  Created by 苏粤翔 on 2024/3/6.
//

import SwiftUI

struct ContentView: View {
    @State var isLoginUser: Bool = false

    var body: some View {
        VStack {
            VStack {
                Button(action: {
                    self.isLoginUser.toggle()
                }, label: {
                    Image(systemName: "music.note")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, Soda!")
                })
            }
            .padding()

            Spacer()

            Tabbar()
        }.sheet(isPresented: self.$isLoginUser, content: {
            LoginView(isLoginUser: $isLoginUser)
        })
    }
}

#Preview {
    ContentView()
}
