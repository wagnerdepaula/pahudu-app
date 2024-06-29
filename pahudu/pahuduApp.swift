//
//  pahuduApp.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/3/24.
//

import SwiftUI

@main
struct PahuduApp: App {
    
    @State private var globalData = GlobalData()
    @State private var isDataLoaded = false
    
    init() {
        configureAppearance()
    }
    
    var body: some Scene {
        
        let eventModel = EventModel(globalData: globalData)
        
        WindowGroup {
            Group {
                if isDataLoaded {
                    ContentView()
                        .preferredColorScheme(.dark)
                        .accentColor(Colors.Primary.accent)
                        .environmentObject(globalData)
                        .environmentObject(eventModel)
                } else {
                    LaunchView()
                }
            }
            .task {
                await fetchData()
                isDataLoaded = true
            }
        }
    }
    
    
    private func fetchData() async {
        globalData.isLoading = true
        defer { globalData.isLoading = false }
        
        // Fetch shows
        async let showsTask = fetchShows()
        let fetchedShows = await showsTask
        globalData.shows = fetchedShows
        
        // Fetch brands
        async let brandsTask = fetchBrands()
        let fetchedBrands = await brandsTask
        globalData.brands = fetchedBrands
        
        // Fetch designers
        async let designersTask = fetchDesigners()
        let fetchedDesigners = await designersTask
        globalData.designers = fetchedDesigners
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
        configureSearchAppearance()
        //listFonts()
    }
    
    private func configureNavigationBarAppearance() {
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        navigationBarAppearance.backgroundColor = UIColor(Colors.Primary.background).withAlphaComponent(0.6)
        navigationBarAppearance.shadowColor = .clear
        
        navigationBarAppearance.backButtonAppearance.normal.titleTextAttributes = [
            .font: UIFont(name: "Inter-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17),
            .foregroundColor: UIColor.clear
        ]
        navigationBarAppearance.largeTitleTextAttributes = [
            .font: UIFont(name: "Inter-Regular", size: 34) ?? UIFont.systemFont(ofSize: 34),
            .kern: NSNumber(value: 0.3),
            .foregroundColor: UIColor(Colors.Primary.foreground)
        ]
        navigationBarAppearance.titleTextAttributes = [
            .font: UIFont(name: "Inter-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17),
            .kern: NSNumber(value: 0),
            .foregroundColor: UIColor(Colors.Primary.foreground)
        ]
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        //UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
    
    private func configureToolbarAppearance() {
        let toolbarAppearance = UIToolbarAppearance()
        toolbarAppearance.configureWithDefaultBackground()
        toolbarAppearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        toolbarAppearance.backgroundColor = UIColor(Colors.Primary.background).withAlphaComponent(0.6)
        toolbarAppearance.shadowColor = .clear
        
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
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        tabBarAppearance.backgroundColor = UIColor(Colors.Primary.background).withAlphaComponent(0.6)
        tabBarAppearance.shadowColor = .clear
        
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(Colors.Tertiary.foreground)
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.accentColor)
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .font: UIFont(name: "Inter-Medium", size: 10) ?? UIFont.systemFont(ofSize: 10),
            .foregroundColor: UIColor(Color.accentColor)
        ]
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .font: UIFont(name: "Inter-Medium", size: 10) ?? UIFont.systemFont(ofSize: 10),
            .foregroundColor: UIColor(Colors.Tertiary.foreground)
        ]
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        //UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
    }
    
    
    private func configureSearchAppearance() {
        let searchBarAppearance = UISearchBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        searchBarAppearance.setImage(UIImage(systemName: "magnifyingglass"), for: .search, state: .normal)
        searchBarAppearance.setImage(UIImage(systemName: "xmark.circle.fill"), for: .clear, state: .normal)
        searchBarAppearance.tintColor = UIColor(Colors.Primary.accent)
        
        let textFieldAppearance = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        
        if let customFont = UIFont(name: "Inter-Regular", size: 16) {
            textFieldAppearance.font = customFont
        }
        
        if #available(iOS 13.0, *) {
            let searchTextFieldAppearance = UISearchTextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
            
            let placeholderAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(Colors.Tertiary.foreground),
                .font: UIFont(name: "Inter-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
            ]
            searchTextFieldAppearance.attributedPlaceholder = NSAttributedString(string: "Search", attributes: placeholderAttributes)
            
            if let customFont = UIFont(name: "Inter-Regular", size: 16) {
                searchTextFieldAppearance.font = customFont
            }
        }
    }
    
    
    
    private func configureButtonAppearance() {
        UIButton.appearance().tintColor = UIColor(Color.accentColor)
    }
    
    
    
}

