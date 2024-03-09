//
//  LoginView.swift
//  soda-music-swiftui
//
//  Created by 苏粤翔 on 2024/3/6.
//

import SwiftUI

struct LoginView: View {
    @Binding var isLoginUser: Bool

    @State private var phoneLoginViewShow: Bool = false

    @State private var agreeAgreement: Bool = false

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.isLoginUser.toggle()
                }, label: {
                    Image(systemName: "multiply")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .padding()
                })

                Spacer()

                Text("帮助与设置")
                    .padding()
            }

            Spacer()
            Image("LoginLogo")
                .font(.largeTitle)
                .frame(width: 300, height: 300)

            Spacer()

            VStack {
                Button {
                    print("")
                } label: {
                    Text("一键登录抖音账号")
                        .foregroundColor(.white)
                }
                .padding()
                .frame(width: 350, height: 50)
                .background(.black)
                .cornerRadius(25)

                Spacer()
                    .frame(height: 20)

                Button {
                    self.phoneLoginViewShow.toggle()
                } label: {
                    Text("手机号登录")
                        .foregroundColor(.white)
                }
                .padding()
                .frame(width: 350, height: 50)
                .background(.gray)
                .cornerRadius(25)

                HStack {
                    Button(action: {
                        self.agreeAgreement.toggle()
                    }) {
                        let checkImagePath = self.agreeAgreement ?"checkmark.circle.fill" : "circle"
                        Image(systemName: checkImagePath)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.black)
                    }

                    Text("我们的服务依赖于抖音账号登录，请阅读并同意“用户登录指引协议")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 70)
            }
        }
        .sheet(isPresented: self.$phoneLoginViewShow, content: {
            PhoneLoginView(phonLoginViewShow: self.$phoneLoginViewShow)
        })
    }
}

#Preview {
    LoginView(isLoginUser: .constant(false))
}
