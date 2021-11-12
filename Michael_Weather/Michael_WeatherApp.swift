//
//  Michael_WeatherApp.swift
//  Michael_Weather
//
//  Created by Michael Kempe on 2021-11-04.
//

import SwiftUI
import CoreLocation

@main
struct Michael_WeatherApp: App {
    let locationHelper = LocationHelper()
    
    var fetcher = WeatherFetcher()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationHelper)
                .environmentObject(fetcher)
        }
    }
}
