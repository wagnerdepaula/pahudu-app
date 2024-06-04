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
        navigationBarAppearance.configureWithTransparentBackground()
        navigationBarAppearance.backgroundColor = UIColor(Color("PrimaryBackground"))
        navigationBarAppearance.shadowColor = UIColor(Color("PrimaryDivider"))
        //navigationBarAppearance.backgroundImage = Self.navigationBarBackground(size: CGSize(width: 100, height: 50))

        
        navigationBarAppearance.backButtonAppearance.normal.titleTextAttributes = [
            .font: UIFont(name: "Geist-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17),
            .foregroundColor: UIColor.clear
        ]
        navigationBarAppearance.largeTitleTextAttributes = [
            .font: UIFont(name: "Geist-Regular", size: 35) ?? UIFont.systemFont(ofSize: 35),
            .kern: NSNumber(value: 0.3),
            .foregroundColor: UIColor(Color("PrimaryText"))
        ]
        navigationBarAppearance.titleTextAttributes = [
            .font: UIFont(name: "Geist-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17),
            .kern: NSNumber(value: 0.3),
            .foregroundColor: UIColor(Color("PrimaryText"))
        ]
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
    
    private func configureToolbarAppearance() {
        let toolbarAppearance = UIToolbarAppearance()
        toolbarAppearance.configureWithOpaqueBackground()
        toolbarAppearance.backgroundColor = UIColor(Color("PrimaryBackground"))
        toolbarAppearance.shadowColor = UIColor(Color("PrimaryDivider"))
        
        let barButtonItemAppearance = UIBarButtonItemAppearance()
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color.accentColor)]
        toolbarAppearance.buttonAppearance = barButtonItemAppearance
        toolbarAppearance.doneButtonAppearance = barButtonItemAppearance
        
        UIToolbar.appearance().tintColor = UIColor(Color.accentColor)
        UIToolbar.appearance().standardAppearance = toolbarAppearance
        UIToolbar.appearance().scrollEdgeAppearance = toolbarAppearance
    }
    
    private func configureTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.backgroundColor = UIColor(Color("PrimaryBackground"))
        tabBarAppearance.shadowColor = UIColor(Color("PrimaryDivider"))
        //tabBarAppearance.backgroundImage = Self.tabBarBackground(size: CGSize(width: 100, height: 50))
        
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color("TertiaryBackground"))
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color("TertiaryBackground"))]
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.accentColor)
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(Color.accentColor)]
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    
    private func configureButtonAppearance() {
        UIButton.appearance().tintColor = UIColor(Color.accentColor)
    }
    
    
    static func navigationBarBackground(size: CGSize) -> UIImage {
        let colors: [CGColor] = [
            UIColor(Color("PrimaryBackground")).cgColor,
            UIColor(Color("PrimaryBackground")).cgColor,
            UIColor(Color("PrimaryBackground")).withAlphaComponent(0).cgColor
        ]
        let renderer = UIGraphicsImageRenderer(size: size)
        let gradient = CGGradient(
            colorsSpace: CGColorSpaceCreateDeviceRGB(),
            colors: colors as CFArray,
            locations: [0, 0.5, 1]
        )
        
        return renderer.image { context in
            if let gradient = gradient {
                context.cgContext.drawLinearGradient(
                    gradient,
                    start: CGPoint(x: 0, y: 0),
                    end: CGPoint(x: 0, y: size.height),
                    options: []
                )
            }
        }
    }
    
    static func tabBarBackground(size: CGSize) -> UIImage {
        let colors: [CGColor] = [
            UIColor(Color("PrimaryBackground")).withAlphaComponent(0).cgColor,
            UIColor(Color("PrimaryBackground")).cgColor,
            UIColor(Color("PrimaryBackground")).cgColor
        ]
        let renderer = UIGraphicsImageRenderer(size: size)
        let gradient = CGGradient(
            colorsSpace: CGColorSpaceCreateDeviceRGB(),
            colors: colors as CFArray,
            locations: [0, 0.5, 1]
        )
        
        return renderer.image { context in
            if let gradient = gradient {
                context.cgContext.drawLinearGradient(
                    gradient,
                    start: CGPoint(x: 0, y: 0),
                    end: CGPoint(x: 0, y: size.height),
                    options: []
                )
            }
        }
    }
    
    
    
}

