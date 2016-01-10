//
//  Quake.swift
//  QuakeApp
//
//  Created by onix on 1/10/16.
//  Copyright © 2016 francisca. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON
import RealmSwift

class Quake : Object {

  dynamic var quakeId : String = ""
  dynamic var magnitude : Double = 0
  dynamic var place : String = ""
  dynamic var date : NSDate = NSDate()
  dynamic var urlInfoStr : String = ""
  dynamic var latitude : Double = 0
  dynamic var longitude : Double = 0

  override static func primaryKey() -> String? {
    return "quakeId"
  }

  func getLocation() -> CLLocation {
    return CLLocation(latitude: latitude, longitude: longitude)
  }

  class func quakeFromJSON(json : JSON) -> Quake {
    let quake = Quake()

    quake.quakeId = json["id"].stringValue
    quake.magnitude = json["properties"]["mag"].doubleValue
    quake.place = json["properties"]["place"].stringValue
    let time = json["properties"]["time"].doubleValue
    quake.date = NSDate(timeIntervalSince1970: time / 1000)

    quake.urlInfoStr = json["properties"]["url"].stringValue

    let longitude = json["geometry"]["coordinates"][0].doubleValue
    let latitude = json["geometry"]["coordinates"][1].doubleValue

    quake.longitude = longitude
    quake.latitude = latitude

    return quake
  }

  class func quakesFromJSON(json : JSON) -> [Quake] {
    var quakes = [Quake]()
    for dic in json.arrayValue {
      let quake = Quake.quakeFromJSON(dic)
      quakes.append(quake)
    }
    return quakes
  }

}
