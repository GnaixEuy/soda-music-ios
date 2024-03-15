//
//  Tabbar.swift
//  soda-music-swiftui
//
//  Created by 苏粤翔 on 2024/3/6.
//

import SwiftUI

enum SelectPageEnum {
    case home
    case find
    case account
}

struct Tabbar: View {
    @Binding var selectPageView: SelectPageEnum

    var body: some View {
        HStack {
            Spacer()
                .frame(width: 30)

            Button(action: {
                self.selectPageView = SelectPageEnum.find
            }, label: {
                VStack {
                    Image(systemName: "headphones.circle")
                        .foregroundStyle(.white)
                        .imageScale(.large)
                    Text("发现")
                }
            })

            Spacer()

            Image(systemName: "play.circle")
                .imageScale(.large)
                .foregroundStyle(.white)
                .font(.system(size: 30)) // 调整图标大小

            Spacer()

            Button(action: {
                self.selectPageView = SelectPageEnum.account
            }, label: {
                VStack {
                    Image(systemName: "person")
                        .foregroundStyle(.white)
                        .imageScale(.large)
                    Text("我的")
                }
            })

            Spacer()
                .frame(width: 30)
        }
        .foregroundColor(.gray)
        .padding()
        .background(Color("SecondaryColor"))
    }
}

#Preview {
    Tabbar(selectPageView: .constant(SelectPageEnum.account))
}
