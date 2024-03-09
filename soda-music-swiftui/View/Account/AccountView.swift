//
//  AccountView.swift
//  soda-music-swiftui
//
//  Created by 苏粤翔 on 2024/3/6.
//

import SwiftUI

struct AccountView: View {
    @State private var tmpAlertView: Bool = false

    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color("SecondaryColor"))
                            .frame(width: 50, height: 50) // 设置圆圈的大小
                        Image(systemName: "bell")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30) // 设置图案的大小
                            .foregroundColor(.white)
                    }

                    Button(action: {
                        self.tmpAlertView.toggle()
                    }, label: {
                        ZStack {
                            Circle()
                                .fill(Color("SecondaryColor"))
                                .frame(width: 50, height: 50) // 设置圆圈的大小
                            Image(systemName: "octagon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30) // 设置图案的大小
                                .foregroundColor(.white)
                            Image(systemName: "circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 10, height: 10) // 设置图案的大小
                                .foregroundColor(.white)
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        }
                        .padding(.trailing, 25)
                    })
                    .alert(isPresented: $tmpAlertView, content: {
                        Alert(title: Text("点击了设置"))
                    })
                }

                Spacer()
                    .frame(height: UIScreen.main.bounds.height / 25)

                Image("avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 125, height: 125) // 设置头像大小
                    .clipShape(Circle()) // 将头像裁剪成圆形
                    .overlay(Circle().stroke(Color.white, lineWidth: 2)) // 可选：添加白色边框
                    .shadow(radius: 5) // 可选：添加阴影效果
                    .padding() // 可选：添加一些内边距

                HStack {
                    Text("永不失眠！")
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(.white)

                    Button(action: {
                    }, label: {
                        Text("开通 VIP >")
                            .bold()
                            .foregroundColor(.white)
                            .padding(6)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black]), startPoint: .top, endPoint: .bottom))
                            .clipShape(Capsule())

                    })
                }

                Text("安道尔")
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                HStack {
                    Text("497关注")
                    Text("33 粉丝")
                    Text("1 获赞")
                }

                HStack(spacing: 0) {
                    Text("歌单")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width / 4)

                    Text("下载")
                        .frame(width: UIScreen.main.bounds.width / 4)

                    Text("历史播放")
                        .frame(width: UIScreen.main.bounds.width / 4)

                    Text("视频")
                        .frame(width: UIScreen.main.bounds.width / 4)
                }
                .bold()
                .font(.title3)
                .padding()

                VStack(alignment: .leading) {
                    Text("创建的歌单")
                        .bold()
                        .font(.title3)
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray)
                                .frame(width: 75, height: 75)
                            Image(systemName: "heart.fill")
                                .foregroundColor(.white)
                                .scaleEffect(2)
                        }

                        VStack(alignment: .leading) {
                            Text("我喜欢的音乐")
                                .bold()
                                .foregroundColor(.white)
                            Text("159首")
                        }
                        .padding(.leading)
                    }
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray)
                                .frame(width: 75, height: 75)
                            Image(systemName: "heart.fill")
                                .foregroundColor(.white)
                                .scaleEffect(2)
                        }

                        VStack(alignment: .leading) {
                            Text("我喜欢的音乐")
                                .bold()
                                .foregroundColor(.white)
                            Text("159首")
                        }
                    }
                }
            }
        }
        .foregroundColor(.gray)
    }
}

#Preview {
    ContentView(selectPageView: .constant(SelectPageEnum.account))
}
