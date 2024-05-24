//
//  DetailsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/22/24.
//

import SwiftUI
import Combine

struct DetailsView: View {
    
    let show: Show
    @State private var displayedText: String = ""
    
    private var textPublisher: AnyPublisher<String, Never> {
        show.brand.history.publisher
            .zip(Timer.publish(every: 0.005, on: .main, in: .common).autoconnect())
            .map { $0.0 }
            .scan("") { $0 + String($1) }
            .eraseToAnyPublisher()
    }
    
    
    @State private var cancellable: AnyCancellable?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                Text(show.brand.name)
                    .headline()
                
                Text(show.description)
                    .body()
     
                Text("\(show.venue.name),")
                    //.foregroundColor(.gray)
                
                Text("\(show.venue.location)")
                    //.foregroundColor(.gray)
                
                
                
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .edgesIgnoringSafeArea(.horizontal)
        .navigationBarTitle(show.brand.name, displayMode: .inline)
    }
}
