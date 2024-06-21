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
    var shows: [Show]
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
    
    @Published var selectedDesigner: Designer?
    @Published var selectedBrand: Brand?
    @Published var selectedShow: ShowItem?
    @Published var events: [Event] = []
    @Published var designers: [Designer] = []

    
    init() {
        loadEvents()
        
        Task {
            await loadDesigners()
        }
    }
    
    
    
    private func loadDesigners() async {
        designers = await fetchDesigners()
    }
    
    
    private func loadEvents() {
        
        // Dummy data for Milan Fashion Week with two shows
        
        events = [
            Event(
                id: UUID(),
                acronym: "NYFW",
                name: "New York Fashion Week",
                location: "New York, USA",
                startDate: Date(), // Assume actual date values here
                endDate: Date(), // Assume actual date values here
                logoURL: URL(string: "https://example.com/nyfw_logo.png"),
                description: "A premier event in the fashion world, New York Fashion Week features the latest collections from top designers and innovative newcomers, setting trends for the upcoming season.",
                socialMediaLinks: [
                    "Instagram": URL(string: "https://www.instagram.com/nyfw"),
                    "Twitter": URL(string: "https://twitter.com/nyfw"),
                    "Facebook": URL(string: "https://www.facebook.com/nyfw")
                ],
                shows: [
                    Show(
                        id: UUID(),
                        hour: 12,
                        venue: Venue(
                            id: UUID(),
                            name: "Spring Studios",
                            location: "New York, USA",
                            mapLink: URL(string: "https://maps.google.com?q=Spring+Studios+New+York"),
                            capacity: 600,
                            amenities: ["VIP Lounge", "Catering Services", "High-Speed Wi-Fi"]
                        ),
                        date: Date(),
                        description: "Tom Ford presents his latest collection, showcasing a blend of timeless elegance and modern luxury, with a focus on bold designs and glamorous styles.",
                        ticketLink: URL(string: "https://fashionweektickets.com/tomford")
                    )
                ]
            ),
            Event(
                id: UUID(),
                acronym: "LFW",
                name: "London Fashion Week",
                location: "London, UK",
                startDate: Date(), // Assume actual date values here
                endDate: Date(), // Assume actual date values here
                logoURL: URL(string: "https://example.com/lfw_logo.png"),
                description: "London Fashion Week is a highlight in the global fashion calendar, featuring cutting-edge designs and trendsetting collections from both established and emerging designers.",
                socialMediaLinks: [
                    "Instagram": URL(string: "https://www.instagram.com/lfw"),
                    "Twitter": URL(string: "https://twitter.com/lfw"),
                    "Facebook": URL(string: "https://www.facebook.com/lfw")
                ],
                shows: [
                    Show(
                        id: UUID(),
                        hour: 15,
                        venue: Venue(
                            id: UUID(),
                            name: "The Royal Exchange",
                            location: "London, UK",
                            mapLink: URL(string: "https://maps.google.com?q=The+Royal+Exchange+London"),
                            capacity: 700,
                            amenities: ["VIP Lounge", "Parking", "Catering Services"]
                        ),
                        date: Date(),
                        description: "Burberry's latest collection is showcased, blending the brand's classic British heritage with Riccardo Tisci's modern and innovative designs.",
                        ticketLink: URL(string: "https://fashionweektickets.com/burberry")
                    )
                ]
            ),
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
                    )
                ]
            ),
            Event(
                id: UUID(),
                acronym: "PFW",
                name: "Paris Fashion Week",
                location: "Paris, France",
                startDate: Date(), // Assume actual date values here
                endDate: Date(), // Assume actual date values here
                logoURL: URL(string: "https://example.com/pfw_logo.png"),
                description: "The grand finale of the global fashion month, Paris Fashion Week features the most prestigious and iconic fashion houses, presenting their latest collections in a showcase of elegance and creativity.",
                socialMediaLinks: [
                    "Instagram": URL(string: "https://www.instagram.com/pfw"),
                    "Twitter": URL(string: "https://twitter.com/pfw"),
                    "Facebook": URL(string: "https://www.facebook.com/pfw")
                ],
                shows: [
                    Show(
                        id: UUID(),
                        hour: 17,
                        venue: Venue(
                            id: UUID(),
                            name: "Grand Palais",
                            location: "Paris, France",
                            mapLink: URL(string: "https://maps.google.com?q=Grand+Palais+Paris"),
                            capacity: 1200,
                            amenities: ["Exclusive Seating", "VIP Lounge", "Catering Services", "Champagne Service"]
                        ),
                        date: Date(),
                        description: "Chanel's show is a highlight of Paris Fashion Week, featuring Virginie Viard's latest collection that blends timeless elegance with modern sophistication.",
                        ticketLink: URL(string: "https://fashionweektickets.com/chanel")
                    )
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
    
    func eventsForDate(_ date: Date) -> [Event] {
        return events.filter { event in
            event.shows.contains { show in
                Calendar.current.isDate(show.date, inSameDayAs: date)
            }
        }
    }
    
    
    func showsForDate(_ date: Date) -> [Show] {
        return events.flatMap { event in
            event.shows.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
        }
    }
    
    
}
