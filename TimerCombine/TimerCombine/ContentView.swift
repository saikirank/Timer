//
//  ContentView.swift
//  TimerCombine
//
//  Created by Saikiran K on 14/03/25.
//

import SwiftUI
import Combine
class TimerModel: ObservableObject {
    
    @Published var value: Int = 0
     var cancellable: Set<AnyCancellable> = []
    init() {
        Timer.publish(every: 1, on: .main, in: .default).autoconnect().map {  _  in
           self.value + 1
       }.assign(to: \.value, on: self)
            .store(in: &cancellable)
        //to cancel
       // cancellable.removeAll()
    }
}

struct ContentView: View {
    @StateObject private var model = TimerModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Timer started! \(model.value)")
        }
        .padding()
        .onDisappear(perform: {
            model.cancellable.removeAll()
        })
    }
}

#Preview {
    ContentView()
}
