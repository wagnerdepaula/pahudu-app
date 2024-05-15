//
//  dataModel.swift
//  pahudu
//
//  Created by Wagner De Paula on 3/26/24.
//

import Foundation

// MARK: - Models

struct Show {
    let id: UUID
    let hour: Int
    let brand: Brand
    let designer: Designer
    let venue: Venue
    let date: Date
    let description: String
    let ticketLink: URL?
}

struct Event {
    let id: UUID
    let acronym: String
    let name: String
    let location: String
    let startDate: Date
    let endDate: Date
    let logoURL: URL?
    let description: String
    let socialMediaLinks: [String: URL?]
    var shows: [Show] // Events can contain multiple shows
}

struct Brand {
    let id: UUID
    let name: String
    let history: String
    let logoURL: URL?
    let websiteURL: URL?
    let socialMediaLinks: [String: URL?]
}

struct Designer {
    let id: UUID
    let name: String
    let bio: String
    let profilePictureURL: URL?
    let signatureStyles: [String]
    let socialMediaLinks: [String: URL?]
}

struct Venue {
    let id: UUID
    let name: String
    let location: String
    let mapLink: URL?
    let capacity: Int
    let amenities: [String]
}

class EventModel: ObservableObject {
    
    @Published var events: [Event] = []
    
    init() {
        loadEvents()
    }
    
    private func loadEvents() {
        
        // Dummy data for Milan Fashion Week with two shows
        
        events = [
            Event(
                id: UUID(),
                acronym: "MFW",
                name: "Milan Fashion Week",
                location: "Milan, Italy",
                startDate: Date(), // Assume actual date values here
                endDate: Date(), // Assume actual date values here
                logoURL: URL(string: "https://example.com/mfw_logo.png"),
                description: "A cornerstone event in the global fashion calendar, Milan Fashion Week showcases innovation and talent from the world's leading fashion houses and emerging designers.",
                socialMediaLinks: [
                    "Instagram": URL(string: "https://www.instagram.com/milanfashionweek"),
                    "Twitter": URL(string: "https://twitter.com/milanfashionwk"),
                    "Facebook": URL(string: "https://www.facebook.com/MilanFashionWeekOfficial")
                ],
                shows: [
                    Show(
                        id: UUID(),
                        hour: 11,
                        brand: Brand(
                            id: UUID(),
                            name: "Dolce & Gabbana",
                            history: "Founded in 1985 by Italian designers Domenico Dolce and Stefano Gabbana in Milan. Known for its innovative and bold designs, it has become a symbol of luxury and sophistication in the fashion industry.",
                            logoURL: URL(string: "https://www.dolcegabbana.com/path/to/logo.png"),
                            websiteURL: URL(string: "https://www.dolcegabbana.com"),
                            socialMediaLinks: [
                                "Instagram": URL(string: "https://www.instagram.com/dolcegabbana"),
                                "Twitter": URL(string: "https://twitter.com/dolcegabbana"),
                                "Facebook": URL(string: "https://www.facebook.com/DolceGabbana")
                            ]
                        ),
                        designer: Designer(
                            id: UUID(),
                            name: "Domenico Dolce & Stefano Gabbana",
                            bio: "Italian designers who founded the Dolce & Gabbana brand. They are known for their glamorous styles, with a strong emphasis on luxury and detailed craftsmanship.",
                            profilePictureURL: URL(string: "https://example.com/path/to/designer/profile.jpg"),
                            signatureStyles: ["Baroque", "Animal Print", "Floral Patterns"],
                            socialMediaLinks: [
                                "Instagram": URL(string: "https://www.instagram.com/domenico.dolce")
                            ]
                        ),
                        venue: Venue(
                            id: UUID(),
                            name: "VIALE PIAVE, 24",
                            location: "Milan, Italy",
                            mapLink: URL(string: "https://maps.google.com?q=VIALE+PIAVE,+24+Milan"),
                            capacity: 800,
                            amenities: ["VIP Lounge", "Parking", "Catering Services", "High-Speed Wi-Fi"]
                        ),
                        date: Date(),
                        description: "Dolce & Gabbana unveils their latest collection in a celebration of Italian craftsmanship, with a special focus on intricate designs and innovative fashion technology.",
                        ticketLink: URL(string: "https://fashionweektickets.com/dolcegabbana")
                    ),
                    
                    
                    Show(
                        id: UUID(),
                        hour: 14,
                        brand: Brand(
                            id: UUID(),
                            name: "Prada",
                            history: "Founded in 1913 by Mario Prada, Prada is an Italian luxury fashion house specializing in leather handbags, travel accessories, shoes, ready-to-wear, perfumes, and other fashion accessories.",
                            logoURL: URL(string: "https://www.prada.com/path/to/logo.png"),
                            websiteURL: URL(string: "https://www.prada.com"),
                            socialMediaLinks: [
                                "Instagram": URL(string: "https://www.instagram.com/prada"),
                                "Twitter": URL(string: "https://twitter.com/prada"),
                                "Facebook": URL(string: "https://www.facebook.com/Prada")
                            ]
                        ),
                        designer: Designer(
                            id: UUID(),
                            name: "Miuccia Prada",
                            bio: "Miuccia Prada, granddaughter of Mario Prada, has led the company's creative direction since the late 1970s, transforming it into a brand synonymous with cutting-edge style and modern luxury.",
                            profilePictureURL: URL(string: "https://example.com/path/to/miuccia/profile.jpg"),
                            signatureStyles: ["Minimalist", "Sophisticated", "Innovative Textiles"],
                            socialMediaLinks: [
                                "Instagram": URL(string: "https://www.instagram.com/miuccia.prada")
                            ]
                        ),
                        venue: Venue(
                            id: UUID(),
                            name: "GALLERIA VITTORIO EMANUELE II",
                            location: "Milan, Italy",
                            mapLink: URL(string: "https://maps.google.com?q=GALLERIA+VITTORIO+EMANUELE+II+Milan"),
                            capacity: 500,
                            amenities: ["Exclusive Seating", "Champagne Service", "Private Showings"]
                        ),
                        date: Date(),
                        description: "Prada presents its latest collection, showcasing a fusion of timeless elegance with modern innovation, emphasizing sustainability and forward-thinking fashion.",
                        ticketLink: URL(string: "https://fashionweektickets.com/prada")
                    ),
                    
                ]
                
            )
        ]
        
    }
    
    func eventForHour(_ hour: Int) -> Show? {
        for event in events {
            if let show = event.shows.first(where: { $0.hour == hour }) {
                return show
            }
        }
        return nil
    }
    
    func eventForShow(hour: Int) -> (event: Event, show: Show)? {
        for event in events {
            if let show = event.shows.first(where: { $0.hour == hour }) {
                return (event, show)
            }
        }
        return nil
    }
    
    func showsForDate(_ date: Date) -> [Show] {
        // Filtering shows by date
        return events.flatMap { event in
            event.shows.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
        }
    }
    
}
