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
                .accentColor(Colors.Primary.accent)
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
        navigationBarAppearance.configureWithTransparentBackground()
        navigationBarAppearance.backgroundColor = UIColor(Colors.Primary.background)
        navigationBarAppearance.shadowColor = UIColor(Colors.Primary.divider)
        
        navigationBarAppearance.backButtonAppearance.normal.titleTextAttributes = [
            .font: UIFont(name: "Geist-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17),
            .foregroundColor: UIColor.clear
        ]
        navigationBarAppearance.largeTitleTextAttributes = [
            .font: UIFont(name: "Geist-Regular", size: 35) ?? UIFont.systemFont(ofSize: 35),
            .kern: NSNumber(value: 0),
            .foregroundColor: UIColor(Colors.Primary.foreground)
        ]
        navigationBarAppearance.titleTextAttributes = [
            .font: UIFont(name: "Geist-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17),
            .kern: NSNumber(value: 0),
            .foregroundColor: UIColor(Colors.Primary.foreground)
        ]
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        //UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
    
    private func configureToolbarAppearance() {
        let toolbarAppearance = UIToolbarAppearance()
        toolbarAppearance.configureWithOpaqueBackground()
        toolbarAppearance.backgroundColor = UIColor(Colors.Primary.background)
        toolbarAppearance.shadowColor = UIColor(Colors.Primary.divider)
        
        let barButtonItemAppearance = UIBarButtonItemAppearance()
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color.accentColor)]
        toolbarAppearance.buttonAppearance = barButtonItemAppearance
        toolbarAppearance.doneButtonAppearance = barButtonItemAppearance
        
        UIToolbar.appearance().tintColor = UIColor(Color.accentColor)
        UIToolbar.appearance().standardAppearance = toolbarAppearance
        //UIToolbar.appearance().scrollEdgeAppearance = toolbarAppearance
    }
    
    private func configureTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.backgroundColor = UIColor(Colors.Primary.background)
        tabBarAppearance.shadowColor = UIColor(Colors.Primary.divider)
        
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(Colors.Tertiary.foreground)
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Colors.Secondary.foreground)]
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.accentColor)
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(Color.accentColor)]
        UITabBar.appearance().standardAppearance = tabBarAppearance
        //UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    
    private func configureButtonAppearance() {
        UIButton.appearance().tintColor = UIColor(Color.accentColor)
    }
    
    
}

