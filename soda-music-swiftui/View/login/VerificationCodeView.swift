//
//  VerificationCodeView.swift
//  soda-music-swiftui
//
//  Created by 苏粤翔 on 2024/3/10.
//

import SwiftUI

struct VerificationCodeView: View {
    @State private var timer: Timer?
    @State private var Countdown: Int = 60
    @Binding var phoneNumber: String
    @State private var verificationCode: String = ""
    @FocusState private var isKeyboardShowing: Bool

    var body: some View {
        ScrollView {
            VStack(spacing: 50.0) {
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("输入验证码")
                        .font(.title2.bold())
                        .foregroundStyle(.primary)

                    Text("验证码已发送至 +86 \(self.phoneNumber)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 10.0) {
                    ForEach(0 ..< 6, id: \.self) { index in
                        OTPTextView(index)
                    }
                }
                .background {
                    TextField(text: $verificationCode) {
                        Text("请输入验证码")
                    }
                    .frame(width: 0, height: 0)
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .focused($isKeyboardShowing)
                    .onChange(of: verificationCode) { _, newValue in
                        if newValue.count > 6 {
                            verificationCode = String(newValue.prefix(6))
                        }
                    }
                }
                .onTapGesture {
                    isKeyboardShowing = true
                }

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

                Button {
                } label: {
                    Text("登录")
                        .foregroundStyle(.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(.blue, in: .capsule)
                }
            }
            .padding()
        }
        .scrollDismissesKeyboard(.immediately)
        .onAppear {
            startTimer()
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if Countdown > 0 {
                Countdown -= 1
            }
        }
    }

    @ViewBuilder
    func OTPTextView(_ index: Int) -> some View {
        let status = (isKeyboardShowing && verificationCode.count == index)

        ZStack {
            Group {
                if verificationCode.count > index {
                    let charIndex = verificationCode.index(verificationCode.startIndex, offsetBy: index)
                    let str = String(verificationCode[charIndex])
                    Text(str)
                } else {
                    Text(" ")
                }
            }
            .font(.title.bold())
        }
        .frame(width: 45, height: 45)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(status ? Color.black : Color.gray)
                .frame(height: 2)
        }
    }
}

#Preview {
    VerificationCodeView(phoneNumber: .constant("123213213"))
}
