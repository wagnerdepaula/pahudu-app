//
//  DesignerDetailsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/7/24.
//

import SwiftUI

struct DesignerDetailsView: View {
    
    let item: Designer
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        ScrollView {
            
            VStack(spacing: 0) {
                
                GeometryReader { geometry in
                    let offsetY = geometry.frame(in: .global).minY
                    
                    ZStack (alignment: .bottomLeading) {
                        
//                        LinearGradient(gradient: Gradient(colors: [Colors.Primary.background, Colors.Tertiary.foreground]), startPoint: .top, endPoint: .bottom)
                        
                        Image(item.name)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width, height: max(width, width + offsetY))
                            
                        
                        
                        LinearGradient(gradient: Gradient(colors: [.clear, Colors.Secondary.background.opacity(0.9)]), startPoint: .top, endPoint: .bottom)
                        
                        Text(item.name)
                            .foregroundColor(Colors.Primary.foreground)
                            .font(.largeTitle)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: height, alignment: .bottom)
                    
                    
                }
                .frame(height: height)
                
                
                VStack(alignment: .leading, spacing: 5) {
                    
                   

                    
                    TypedText(text: item.about)
                        .foregroundColor(Colors.Primary.foreground)
                        .font(.body)
                        .lineSpacing(6)
                    
                    
                    Spacer(minLength: 10)
                    
                                        
                    VStack(alignment: .leading, spacing: 12) {
                        
                        HStack(alignment: .top) {
                            Text("Born")
                                .foregroundColor(Colors.Primary.foreground)
                                .frame(maxWidth: 100, alignment: .leading)
                            Text(item.dateOfBirth)
                                .foregroundColor(Colors.Secondary.foreground)
                                .lineSpacing(4)
                        }
                        
                        HStack(alignment: .top) {
                            Text("Founder")
                                .foregroundColor(Colors.Primary.foreground)
                                .frame(maxWidth: 100, alignment: .leading)
                            Text(item.founder)
                                .foregroundColor(Colors.Secondary.foreground)
                                .lineSpacing(4)
                        }
                        
                        HStack(alignment: .top) {
                            Text("Education")
                                .foregroundColor(Colors.Primary.foreground)
                                .frame(maxWidth: 100, alignment: .leading)
                            Text(item.education)
                                .foregroundColor(Colors.Secondary.foreground)
                                .lineSpacing(4)
                        }
                        
                        HStack(alignment: .top) {
                            Text("Years Active")
                                .foregroundColor(Colors.Primary.foreground)
                                .frame(maxWidth: 100, alignment: .leading)
                            Text(item.yearsActive)
                                .foregroundColor(Colors.Secondary.foreground)
                                .lineSpacing(4)
                        }
                        
                        HStack(alignment: .top) {
                            Text("Spouse")
                                .foregroundColor(Colors.Primary.foreground)
                                .frame(maxWidth: 100, alignment: .leading)
                            Text(item.spouse)
                                .foregroundColor(Colors.Secondary.foreground)
                                .lineSpacing(4)
                        }
                        
                        HStack(alignment: .top) {
                            Text("Nationality")
                                .foregroundColor(Colors.Primary.foreground)
                                .frame(maxWidth: 100, alignment: .leading)
                            Text(item.nationality)
                                .foregroundColor(Colors.Secondary.foreground)
                                .lineSpacing(4)
                        }
                        
                        HStack(alignment: .top) {
                            
                            Text("Website")
                                .foregroundColor(Colors.Primary.foreground)
                                .frame(maxWidth: 100, alignment: .leading)
                            
                            if (item.website != "N/A") {
                                Link(cleanURL(item.website), destination: URL(string: item.website)!)
                                    .foregroundColor(Colors.Primary.accent)
                                    .lineSpacing(4)
                            } else {
                                Text(item.nationality)
                                    .foregroundColor(Colors.Secondary.foreground)
                                    .lineSpacing(4)
                            }
                
                        }
                        
                    }
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 20)
                    .background(Colors.Secondary.background)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    
                    Spacer(minLength: 60)
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                
                Spacer(minLength: 100)
                
                
            }
            .padding(0)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .edgesIgnoringSafeArea(.all)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .background(Colors.Primary.background)
    }
}
