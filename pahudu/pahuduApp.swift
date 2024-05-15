//
//  pahuduApp.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/3/24.
//

import SwiftUI

@main
struct PahuduApp: App {
    
    // MARK: - Initialization
    init() {
        configureNavigationBarAppearance()
        
//                for familyName in UIFont.familyNames.sorted() {
//                    print("Family: \(familyName)")
//                    for fontName in UIFont.fontNames(forFamilyName: familyName).sorted() {
//                        print(" - \(fontName)")
//                    }
//                }
        
    }
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            ContentView()
                .accentColor(Color("AccentColor")) // Set accent color for the app
        }
    }
    
    // MARK: - Private Methods
    private func configureNavigationBarAppearance() {
        
        // Create an instance of UINavigationBarAppearance
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        navigationBarAppearance.backgroundColor = UIColor(Color("BackgroundColor"))
        navigationBarAppearance.shadowColor = UIColor(Color.clear)
        //UIColor(Color("DividerColor"))
        
        let toolbarAppearance = UIToolbarAppearance()
        toolbarAppearance.configureWithOpaqueBackground()
        toolbarAppearance.backgroundColor = UIColor(Color("BackgroundColor"))
        toolbarAppearance.shadowColor = UIColor(Color.clear)
        //UIColor(Color("DividerColor"))
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(Color("BackgroundColor"))
        tabBarAppearance.shadowColor = UIColor(Color.clear)
        
        
        // Set large title attributes with a custom font and kerning
        navigationBarAppearance.largeTitleTextAttributes = [
            .font: UIFont(name: "SuisseBPIntl-Regular", size: 34) ?? UIFont.systemFont(ofSize: 34),
//            .font: UIFont.systemFont(ofSize: 34, weight: .semibold, width: .standard),
            .kern: NSNumber(value: 0)
            //.font: UIFont.monospacedSystemFont(ofSize: 32, weight: .light),
            //.kern: NSNumber(value: -1)
        ]
        
        // Set title attributes with a custom font and kerning
        navigationBarAppearance.titleTextAttributes = [
            .font: UIFont(name: "SuisseBPIntl-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17),
//            .font: UIFont.systemFont(ofSize: 18, weight: .medium, width: .standard),
            //.font: UIFont.monospacedSystemFont(ofSize: 18, weight: .regular),
            .kern: NSNumber(value: 0)
        ]
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        UIToolbar.appearance().standardAppearance = toolbarAppearance
        UIToolbar.appearance().scrollEdgeAppearance = toolbarAppearance
    }
}
