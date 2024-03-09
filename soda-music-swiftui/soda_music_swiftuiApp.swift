//
//  soda_music_swiftuiApp.swift
//  soda-music-swiftui
//
//  Created by 苏粤翔 on 2024/3/6.
//

import SwiftUI

@main
struct soda_music_swiftuiApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(selectPageView: .constant(SelectPageEnum.account))
        }
    }
}
