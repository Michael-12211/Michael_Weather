//
//  WeatherFetcher.swift
//  Michael_Weather
//
//  Created by Michael Kempe on 2021-11-10.
//  Student number: 991566501
//

import Foundation

class WeatherFetcher : ObservableObject{
    var apiURL = "https://api.weatherapi.com/v1/current.json?key=697acd8deab64fc681e225355210411&q="//75,75&aqi=no"
    var apiURL2 = "&aqi=no"
    
    //@Published var weatherList = [Weather]()
    @Published var weather = Weather()
    
    init(){
        fetchDataFromAPI(coordinates: "75,75")
    }
    
    func fetchDataFromAPI(coordinates: String){
        
        guard let api = URL(string: (apiURL + coordinates + apiURL2)) else {
            return
        }
        
        URLSession.shared.dataTask(with: api){(data: Data?, response: URLResponse?, error: Error?) in
            
            if let err = error{
                print(#function, err)
            }else{
                //received data or response
                DispatchQueue.global().async {
                    do{
                        if let jsonData = data{
                            let decoder = JSONDecoder()
                            
                            let decodedWeatherList = try decoder.decode(Weather.self, from: jsonData)
                            
                            DispatchQueue.main.async {
                                self.weather = decodedWeatherList
                            }
                            
                        }else{
                            print(#function, "No JSON data received")
                        }
                    }catch let error{
                        print(#function, error)
                    }
                }
            }
        }.resume()
    }
}
