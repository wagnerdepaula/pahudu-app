//
//  ShowDetailsView.swift
//  pahudu
//
//  Created by Wagner De Paula on 6/10/24.
//

import SwiftUI



struct ShowDetailsView: View {
    
    let show: Show
    let size: CGFloat = UIScreen.main.bounds.width
    let imageSize: CGFloat = UIScreen.main.bounds.width - 55
    @State private var itemOpacity: Double = 0.0
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    
                    let offsetY = geometry.frame(in: .global).minY
                    
                    ZStack(alignment: .bottom) {
                        
                        LinearGradient(gradient: Gradient(colors: [Colors.Primary.background, Colors.Secondary.background]), startPoint: .top, endPoint: .bottom)
                        
                        
                        AsyncCachedImage(url: URL(string: "\(Path.shows)/lg/\(show.imageName)")!) { image in
                            image
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(Colors.Primary.foreground)
                                .frame(width: imageSize, height: max(imageSize, imageSize + offsetY))
                                .opacity(itemOpacity)
                                .onAppear {
                                    withAnimation(.easeOut(duration: 0.5)) {
                                        itemOpacity = 1.0
                                    }
                                }
                        } placeholder: {
                            Colors.Secondary.background
                        }
                    }
                    .frame(maxWidth: size, maxHeight: size, alignment: .bottom)
                }
                .frame(height: size)
                
                
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    
                    // Table
                    VStack(spacing: 0) {
                        
                        if show.acronym != "N/A" {
                            DetailsSectionView(title: "Acronym", detail: show.acronym)
                        }
                        
                        if show.location != "N/A" {
                            DetailsSectionView(title: "Location", detail: show.location)
                        }
                        
                        if show.founder != "N/A" {
                            DetailsSectionView(title: "Founded by", detail: show.founder)
                        }
                        
                        if show.established != "N/A" {
                            DetailsSectionView(title: "Established", detail: show.established)
                        }
                        
                        if show.organizer != "N/A" {
                            DetailsSectionView(title: "Organizer", detail: show.organizer)
                        }
                        
                        if show.startDate != "N/A" {
                            DetailsSectionView(title: "Start date", detail: show.startDate)
                        }
                        
                        if show.endDate != "N/A" {
                            DetailsSectionView(title: "End date", detail: show.endDate)
                        }
                        
                        if show.frequency != "N/A" {
                            DetailsSectionView(title: "Frequency", detail: show.frequency)
                        }
                        
                        if show.website != "N/A" {
                            DetailsLinkSectionView(title: "Website", link: show.website)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(Colors.Secondary.background)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                    
                    
                    TypedText(text: "\(show.about) \(show.keyHighlights)")
                        .foregroundColor(Colors.Primary.foreground)
                        .font(.body)
                        .lineSpacing(6)
                    
                    
                    
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(Array(show.history.enumerated()), id: \.element) { index, item in
                            HStack(alignment: .top, spacing: 0) {
                                Text("\(index + 1).")
                                    .foregroundColor(Colors.Quaternary.foreground)
                                    .font(.body)
                                    .frame(width: 25, alignment: .leading)
                                Text(item)
                                    .foregroundColor(Colors.Primary.foreground)
                                    .font(.body)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineSpacing(6)
                            }
                        }
                    }
                    
                    Spacer(minLength:50)
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                
            }
        }
        .edgesIgnoringSafeArea(.top)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .background(Colors.Primary.background)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    UIApplication.triggerHapticFeedback()
                } label: {
                    ZStack {
                        Circle()
                            .fill(Colors.Tertiary.background)
                            .frame(width: 30, height: 30)
                        Image(systemName: "plus")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(Colors.Primary.accent)
                    }
                }
            }
        }
    }
}
