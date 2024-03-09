//
//  VerificationCodeView.swift
//  soda-music-swiftui
//
//  Created by 苏粤翔 on 2024/3/10.
//

import SwiftUI

struct VerificationCodeView: View {
    @State private var Countdown: Int = 60
    @State var verificationCode: String = "0123"
    @Binding var phoneNumber: String
    @State private var timer: Timer?

    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("输入验证码")
                        .font(.largeTitle)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .padding(.horizontal, 0)
                    Text("验证码已发送至\(self.$phoneNumber.wrappedValue)")
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                        .foregroundColor(.gray)
                }
                .padding()
                Spacer()
            }
            Spacer()
                .frame(height: 150)

            TextField(text: $verificationCode) {
                Text("请输入验证码 （TODO 切换至开源组件）")
            }
            .padding()

            if self.Countdown == 0 {
                Button(action: {
                    // 接入后端
                    print("重新请求验证码")

                    self.Countdown += 60
                }, label: {
                    Text("重新获取验证码")
                })
            } else {
                Text("\(self.Countdown)秒后重新获取")
            }

            Spacer()
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
            timer = nil
        }
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if Countdown > 0 {
                Countdown -= 1
            }
        }
    }
}

#Preview {
    VerificationCodeView(phoneNumber: .constant("123213213"))
}
