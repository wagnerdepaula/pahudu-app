//
//  pahuduApp.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/3/24.
//

import SwiftUI

@main
struct PahuduApp: App {
    
    init() {
        configureAppearance()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .accentColor(Color("AccentColor"))
            
            
        }
    }
    
    private func listFonts() {
        for familyName in UIFont.familyNames.sorted() {
            print("Family: \(familyName)")
            for fontName in UIFont.fontNames(forFamilyName: familyName).sorted() {
                print(" - \(fontName)")
            }
        }
    }
    
    private func configureAppearance() {
        configureNavigationBarAppearance()
        configureToolbarAppearance()
        configureTabBarAppearance()
        configureButtonAppearance()
    }
    
    private func configureNavigationBarAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        navigationBarAppearance.shadowColor = UIColor(Color.clear)
        navigationBarAppearance.largeTitleTextAttributes = [
            .font: UIFont(name: "Geist-Regular", size: 34) ?? UIFont.systemFont(ofSize: 34),
            .kern: NSNumber(value: 0.3),
            //.foregroundColor: UIColor(Color("AccentColor"))
        ]
        navigationBarAppearance.titleTextAttributes = [
            .font: UIFont(name: "Geist-Regular", size: 18) ?? UIFont.systemFont(ofSize: 18),
            .kern: NSNumber(value: 0.3),
            //.foregroundColor: UIColor(Color("AccentColor"))
        ]
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
    
    private func configureToolbarAppearance() {
        let toolbarAppearance = UIToolbarAppearance()
        toolbarAppearance.configureWithOpaqueBackground()
        toolbarAppearance.shadowColor = UIColor(Color.clear)
        let barButtonItemAppearance = UIBarButtonItemAppearance()
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color.accentColor)]
        toolbarAppearance.buttonAppearance = barButtonItemAppearance
        toolbarAppearance.doneButtonAppearance = barButtonItemAppearance
        UIToolbar.appearance().standardAppearance = toolbarAppearance
        UIToolbar.appearance().scrollEdgeAppearance = toolbarAppearance
        //UIToolbar.appearance().tintColor = UIColor(Color("AccentColor"))
    }
    
    private func configureTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.shadowColor = UIColor(Color.clear)
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color("QuaternaryColor"))
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color("QuaternaryColor"))]
        //tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color("AccentColor"))
        //tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(Color("AccentColor"))]
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    
    private func configureButtonAppearance() {
        UIButton.appearance().tintColor = UIColor(Color("AccentColor"))
    }
    
}
