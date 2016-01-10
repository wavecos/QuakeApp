//
//  MapViewController.swift
//  QuakeApp
//
//  Created by onix on 1/10/16.
//  Copyright © 2016 francisca. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class MapViewController: UIViewController {

  // conexiones
  @IBOutlet weak var mapView: MKMapView!

  var quakeUrl : String?
  var quakes = [Quake]()

  override func viewDidLoad() {
    super.viewDidLoad()

    setupMap()
    loadQuakes()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // Setup Map
  func setupMap() {
    let generalCoordinate = CLLocationCoordinate2DMake(6.958058, -87.151538) // En algun lugar por centro america

    let region : MKCoordinateRegion = MKCoordinateRegionMakeWithDistance (generalCoordinate, 10000000, 10000000)
    self.mapView.setRegion(region, animated: true)
  }

  func loadQuakes() {
    Alamofire.request(.GET, self.quakeUrl!, parameters: nil)
      .responseJSON { response in

        if response.result.error == nil {
          debugPrint("respuesta server : \(response.result.value)")
          let json = JSON(response.result.value!)
          self.quakes = Quake.quakesFromJSON(json["features"])


          var quakeAnnotations = [MKPointAnnotation]()

          for q in self.quakes {

            let annotation = MKPointAnnotation()

            annotation.title = q.place
            annotation.subtitle = "\(q.magnitude) - \(q.date.description)"
            annotation.coordinate = q.getLocation().coordinate

            quakeAnnotations.append(annotation)
          }
          
          self.mapView.addAnnotations(quakeAnnotations)

        }
        
    }
  }


}
