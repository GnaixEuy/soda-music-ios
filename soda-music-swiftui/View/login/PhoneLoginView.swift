//
//  PhoneLoginView.swift
//  soda-music-swiftui
//
//  Created by 苏粤翔 on 2024/3/6.
//

import SwiftUI

struct PhoneLoginView: View {
    @Binding var phonLoginViewShow: Bool

    @State private var agreeAgreement: Bool = false

    @State private var phoneNumber: String = ""

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.phonLoginViewShow.toggle()
                }, label: {
                    Image(systemName: "multiply")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .padding()
                })
                Spacer()
            }
            Spacer()
                .frame(height: 50)

            VStack {
                HStack {
                    Text("登陆抖音账号")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .padding(.bottom)
                        .padding(.leading)
                    Spacer()
                }
                HStack {
                    Text("登陆抖音账未注册的手机号验证通过后将自动注册")
                        .foregroundColor(.gray)
                        .font(.body)
                        .padding(.bottom)
                        .padding(.leading)
                    Spacer()
                }
            }
            .multilineTextAlignment(.leading)

            Spacer()
                .frame(height: 90)

            HStack {
                TextField("请输入手机号", text: $phoneNumber)
                    .padding(.horizontal, 20.0)
                    .padding(.vertical, 35.0)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            Button {
                print($phoneNumber)
            } label: {
                Text("获取短信验证码")
                    .foregroundColor(.white)
            }
            .padding()
            .frame(width: 350, height: 50)
            .background(.black)
            .cornerRadius(25)

            HStack {
                Button(action: {
                    self.agreeAgreement.toggle()
                }) {
                    let checkImagePath = self.agreeAgreement ?"checkmark.square.fill" : "square"
                    Image(systemName: checkImagePath)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.black)
                }

                Text("我们的服务依赖于使用抖音账号登录，请阅读并同意“用户登录指引协议")
            }
            .padding()

            Spacer()
        }
    }
}

#Preview {
    PhoneLoginView(phonLoginViewShow: .constant(false))
}
