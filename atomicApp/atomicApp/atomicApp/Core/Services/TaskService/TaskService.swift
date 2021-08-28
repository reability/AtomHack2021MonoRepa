//
//  TaskService.swift
//  atomicApp
//
//  Created by Ванурин Алексей Максимович on 28.08.2021.
//

import Foundation
import Combine

class TaskService: ObservableObject {
    private var canncelable: AnyCancellable?
    
    let url: URL = URL(string: "https://d636-2a00-1370-8131-622b-da61-79ab-2-95af.ngrok.io/taskList?userId=1")!
    
    init() {
        print("here")
        self.canncelable = URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data }
            .decode(type: String.self, decoder: JSONDecoder())
            .replaceError(with: "")
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {
                print($0)
            })
    }
    
}
