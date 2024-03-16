//
//  PhoneLoginView.swift
//  soda-music-swiftui
//
//  Created by 苏粤翔 on 2024/3/6.
//

import SwiftUI

struct PhoneLoginView: View {
    @Binding var phonLoginViewShow: Bool
    @Binding var agreeAgreement: Bool
    @State var verificationViewShow: Bool = false
    @State private var showProtocolAlert: Bool = false
    @State private var phoneNumberExceptionAlert: Bool = false
    @State private var phoneNumber: String = ""

    var body: some View {
        NavigationView(content: {
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
                    // TODO: 优化项
                    Text("+ 86")
                        .font(.title3)
                        .overlay(Rectangle().frame(height: 2).padding(.top, 5), alignment: .bottom)

                    TextField("请输入手机号", text: $phoneNumber)

                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textContentType(.telephoneNumber)
                        .keyboardType(.asciiCapableNumberPad)
                }
                .padding(.horizontal, 20.0)
                .padding(.vertical, 35.0)

                NavigationLink(destination: VerificationCodeView(phoneNumber: self.$phoneNumber), isActive: $verificationViewShow) {
                    EmptyView()
                }

                Button {
                    if !self.isValidPhoneNumber(self.phoneNumber) || self.phoneNumber.isEmpty {
                        self.phoneNumberExceptionAlert.toggle()
                    } else {
                        if self.agreeAgreement {
                            if self.sendPhoneCaptcha(self.phoneNumber) {
                                self.verificationViewShow.toggle()
                            }
                        } else {
                            self.showProtocolAlert.toggle()
                        }
                    }

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
        })
        .alert(isPresented: Binding<Bool>(
            get: { self.showProtocolAlert || self.phoneNumberExceptionAlert },
            set: { _ in })) {
                if phoneNumberExceptionAlert {
                    return Alert(title: Text("警告"), message: Text("请输入合法的手机号码"), dismissButton: .default(Text("确定")))
                } else {
                    return Alert(title: Text("提示"), message: Text("请同意服务协议后以获取短信验证码"), dismissButton: .default(Text("确定")))
                }
        }
    }

    private func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneRegex = "^1[3456789]\\d{9}$" // 匹配中国大陆手机号码
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: phoneNumber)
    }

    private func sendPhoneCaptcha(_ phoneNumber: String) -> Bool {
        NetworkManager.shared.request(module: .auth, api: AuthAPI.getVerificationCode, parameters: ["phone": self.phoneNumber]) { data, response, error in
            print(data as Any)
            print(response as Any)
            print(error as Any)
        }
        return true
    }
}

#Preview {
    LoginView(isLoginUser: .constant(false))
//    PhoneLoginView(phonLoginViewShow: .constant(false), agreeAgreement: .constant(false))
}
