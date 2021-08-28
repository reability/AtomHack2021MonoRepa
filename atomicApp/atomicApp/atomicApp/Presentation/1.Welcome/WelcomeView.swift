//
//  WelcomeView.swift
//  atomicApp
//
//  Created by Ванурин Алексей Максимович on 28.08.2021.
//

import Foundation
import SwiftUI
import Combine


struct WelcomeView: View {
    @State private var userId: String = ""
    var body: some View {
        VStack(content: {
            Text("")
            TextField("Введите имя", text: $userId)
            Button("Hi", action: action)
        })
    }
    
    func action() {
        print(userId)
    }
    
}
