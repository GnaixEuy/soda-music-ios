//
//  ContentView.swift
//  soda-music-swiftui
//
//  Created by 苏粤翔 on 2024/3/6.
//

import SwiftUI

struct ContentView: View {
    @State var isLoginUser: Bool = false
    @Binding var selectPageView: SelectPageEnum

    var body: some View {
        VStack {
            switch selectPageView {
            case SelectPageEnum.home:
                EmptyView()
            case SelectPageEnum.find:
                EmptyView()
            case SelectPageEnum.account:
                AccountView()
            }

            Spacer()

            Tabbar(selectPageView: self.$selectPageView)
        }
        .background(Color("AccentColor"))
        .sheet(isPresented: .constant(!self.isLoginUser), content: {
            LoginView(isLoginUser: $isLoginUser)
        })
    }
}

#Preview {
    ContentView(selectPageView: .constant(SelectPageEnum.account))
}
