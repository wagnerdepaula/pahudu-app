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
                .accentColor(Color("PrimaryAccent"))
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
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterialDark)
        navigationBarAppearance.backgroundColor = UIColor(Color("PrimaryBackground")).withAlphaComponent(0.65)
        
        navigationBarAppearance.backButtonAppearance.normal.titleTextAttributes = [
            .font: UIFont(name: "Geist-Regular", size: 18) ?? UIFont.systemFont(ofSize: 18),
            .foregroundColor: UIColor.clear]
        navigationBarAppearance.shadowColor = UIColor(Color("PrimaryDivider"))
        navigationBarAppearance.largeTitleTextAttributes = [
            .font: UIFont(name: "Geist-Regular", size: 34) ?? UIFont.systemFont(ofSize: 34),
            .kern: NSNumber(value: 0.3),
            .foregroundColor: UIColor(Color("PrimaryText"))
        ]
        navigationBarAppearance.titleTextAttributes = [
            .font: UIFont(name: "Geist-Regular", size: 18) ?? UIFont.systemFont(ofSize: 18),
            .kern: NSNumber(value: 0.3),
            .foregroundColor: UIColor(Color("PrimaryText"))
        ]
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
    
    private func configureToolbarAppearance() {
        let toolbarAppearance = UIToolbarAppearance()
        toolbarAppearance.configureWithOpaqueBackground()
        toolbarAppearance.shadowColor = UIColor.clear
        let barButtonItemAppearance = UIBarButtonItemAppearance()
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color.accentColor)]
        toolbarAppearance.buttonAppearance = barButtonItemAppearance
        toolbarAppearance.doneButtonAppearance = barButtonItemAppearance
        UIToolbar.appearance().standardAppearance = toolbarAppearance
        UIToolbar.appearance().scrollEdgeAppearance = toolbarAppearance
        UIToolbar.appearance().tintColor = UIColor(Color.accentColor)
    }
    
    private func configureTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.shadowColor = UIColor.clear
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color("PrimaryTaupe"))
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color("PrimaryTaupe"))]
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.accentColor)
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(Color.accentColor)]
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    
    private func configureButtonAppearance() {
        UIButton.appearance().tintColor = UIColor(Color.accentColor)
    }
    
}
