//
//  Weather.swift
//  Michael_Weather
//
//  Created by Michael Kempe on 2021-11-06.
//  Student number: 991566501
//

import Foundation

struct Weather: Codable, Identifiable{
    var id : String
    var temp : Float
    var feelsLike : Float
    var windSpd : Float
    var windDir: String
    var humidity: Float
    var uv: Float
    var vis: Float
    var condition: String
    
    enum CodingKeys: String, CodingKey{
        case location = "location"
        case current = "current"
        case error = "error"
    }
    
    enum locKeys: String, CodingKey {
        case id = "tz_id"
    }
    
    enum curKeys: String, CodingKey {
        case temp = "temp_c"
        case feelsLike = "feelslike_c"
        case windSpd = "wind_kph"
        case windDir = "wind_dir"
        case humidity = "humidity"
        case uv = "uv"
        case vis = "vis_km"
        case condition = "condition"
    }
    
    enum conKeys: String, CodingKey {
        case condition = "text"
    }
    
    init() {
        id = ""
        temp = 0.0
        feelsLike = 0.0
        windSpd = 0.0
        windDir = ""
        humidity = 0.0
        uv = 0.0
        vis = 0.0
        condition = ""
    }
    
    init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try response.nestedContainer(keyedBy: locKeys.self, forKey: .location).decode(String.self, forKey: .id)
        
        let current = try response.nestedContainer(keyedBy: curKeys.self, forKey: .current)
        
        self.temp = try current.decode(Float.self, forKey: .temp)
        self.feelsLike = try current.decode(Float.self, forKey: .feelsLike)
        self.windSpd = try current.decode(Float.self, forKey: .windSpd)
        self.windDir = try current.decode(String.self, forKey: .windDir)
        self.humidity = try current.decode(Float.self, forKey: .humidity)
        self.uv = try current.decode(Float.self, forKey: .uv)
        self.vis = try current.decode(Float.self, forKey: .vis)
        
        self.condition = try current.nestedContainer(keyedBy: conKeys.self, forKey: .condition).decode(String.self, forKey: .condition)
        
        /*if (!self.success){
            let failureContainer = try response.decodeIfPresent([Failure].self,forKey: .failures)
            self.failureReason = failureContainer?.first?.reason ?? "Unavailable"
        }else{
            self.failureReason = "Unavailable"
        }*/
    }
    
    func encode(to encoder: Encoder) throws {
        // nothing to encode
    }
    
}

struct Failure : Codable {
    let reason : String
    
    enum CodingKeys: String, CodingKey {
        case reason = "reason"
    }
    
    init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: CodingKeys.self)
        self.reason = try response.decodeIfPresent(String.self, forKey: .reason) ?? "Unavailable"
    }
    
    func encode(to encoder: Encoder) throws {
        //nothing to encode
    }
}
