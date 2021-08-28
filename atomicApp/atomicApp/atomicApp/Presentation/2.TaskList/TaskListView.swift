//
//  TaskListView.swift
//  atomicApp
//
//  Created by Ванурин Алексей Максимович on 28.08.2021.
//

import Foundation
import SwiftUI
import Combine


struct TaskListView: View {
    @ObservedObject var service = TaskService()
    @State private var userId: String = ""
    var body: some View {
        VStack(content: {
            Text("Тут заголовок")
            Text("Мои задачи")
            HStack(alignment: .firstTextBaseline, spacing: 10.0, content: {
                //
            })
            
        })
    }
    
    func action() {
        print(userId)
    }
}
