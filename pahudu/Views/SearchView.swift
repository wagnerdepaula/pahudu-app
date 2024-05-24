//
//  SearchView.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/27/24.
//

import SwiftUI
import UIKit

struct SearchBar: UIViewControllerRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search"
        searchBar.autocapitalizationType = .none

        viewController.view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
        ])

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if let searchBar = uiViewController.view.subviews.first(where: { $0 is UISearchBar }) as? UISearchBar {
            searchBar.text = text
        }
    }
}







import SwiftUI

struct SearchView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Spacer()
                    Text("SearchView")
                        .headline()
                        //.foregroundColor(.primary)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //.background(Color("BackgroundColor"))
            .navigationBarTitle("Search", displayMode: .inline)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            .scrollIndicators(.hidden)
        }
    }
}
