//
//  ContentView.swift
//  Michael_Weather
//
//  Created by Michael Kempe on 2021-11-04.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @EnvironmentObject var locationHelper : LocationHelper
    @EnvironmentObject var fetcher : WeatherFetcher
    //@State var updates = 0
    
    var body: some View {
        VStack
        {
            Text(fetcher.weather.id)
            Text("Temperature: \(fetcher.weather.temp, specifier: "%.2f")c")
            Text("Feels like \(fetcher.weather.feelsLike, specifier: "%.2f")c")
            Text("Wind speed: \(fetcher.weather.windSpd, specifier: "%.2f")kph, \(fetcher.weather.windDir)")
            Text("Humidity: \(fetcher.weather.humidity, specifier: "%.2f")")
            Text("UV: \(fetcher.weather.uv, specifier: "%.2f")")
            Text("Visibility: \(fetcher.weather.vis, specifier: "%.2f")")
            Text(fetcher.weather.condition)
            //Text("\(updates)")
            //Text("\(locationHelper.test)")
        }
        .onAppear(){
            self.locationHelper.checkPermission()
            accessAPI()
        }
        .onChange(of: locationHelper.currentLocation, perform: { value in
            accessAPI()
        })
    }
    
    private func accessAPI(){
        if (self.locationHelper.currentLocation != nil){
            let loc = self.locationHelper.currentLocation!
            print(loc)
            let lat = loc.coordinate.latitude
            let lon = loc.coordinate.longitude
            let convCor = "\(lat),\(lon)"
            print (convCor)
            fetcher.fetchDataFromAPI(coordinates: convCor)
            //updates = updates + 1
            //print ("ran\n\n")
        }else{
            print("Can't access location")
        }
        
        //fetcher.fetchDataFromAPI(coordinates: "76,76")
        
        //CLLocation.init().coordinate.latitude.magnitude
    }
}

/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}*/
