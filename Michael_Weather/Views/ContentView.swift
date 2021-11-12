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
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 75, longitude: 75), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    var body: some View {
        VStack
        {
            Text(fetcher.weather.id)
            if (self.locationHelper.currentLocation != nil){
                //MyMap(location: self.locationHelper.currentLocation!)
                Map(coordinateRegion: $region)
                    .frame(width: 400, height: 300)
            }
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
            self.region.center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }else{
            print("Can't access location")
        }
        
        //fetcher.fetchDataFromAPI(coordinates: "76,76")
        
        //CLLocation.init().coordinate.latitude.magnitude
    }
}

/*struct MyMap: UIViewRepresentable{
    typealias UIViewType = MKMapView
    
    @EnvironmentObject var locationHelper : LocationHelper
    private var location: CLLocation
    let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    
    init(location: CLLocation){
        self.location = location
        //print ("User's current location is \(location)")
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        //print ("User's current location is \(location)")
        
        let sourceCoordinates : CLLocationCoordinate2D
        let region : MKCoordinateRegion
        
        if (self.locationHelper.currentLocation != nil){
            sourceCoordinates = self.locationHelper.currentLocation!.coordinate
        }else{
            sourceCoordinates = CLLocationCoordinate2D(latitude: 43.642567, longitude: -79.387054)
        }
        
        region = MKCoordinateRegion(center: sourceCoordinates, span: span)
        
        let map = MKMapView(frame: .infinite)
        
        map.mapType = MKMapType.standard
        map.showsUserLocation = true
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.isUserInteractionEnabled = true
        map.setRegion(region, animated: true)
        self.locationHelper.addPinToMapView(mapView: map, coordinates: sourceCoordinates, title: "You're Here")
        
        //print ("made map")
        
        return map
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //print ("updating view")
        
        let sourceCoordinates : CLLocationCoordinate2D
        let region : MKCoordinateRegion
        
        if (self.locationHelper.currentLocation != nil){
            sourceCoordinates = self.locationHelper.currentLocation!.coordinate
        }else{
            sourceCoordinates = CLLocationCoordinate2D(latitude: 43.642567, longitude: -79.387054)
        }
        
        region = MKCoordinateRegion(center: sourceCoordinates, span: span)
        
        uiView.setRegion(region, animated: true)
        self.locationHelper.addPinToMapView(mapView: uiView, coordinates: sourceCoordinates, title: "You're Here")
    }
}*/

/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}*/
