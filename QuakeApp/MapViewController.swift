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

class MapViewController: UIViewController, MKMapViewDelegate {

  // conexiones
  @IBOutlet weak var mapView: MKMapView!

  var quakeUrl : String?
  var quakeSelected : Quake?
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


    self.mapView.delegate = self

    self.mapView.setRegion(region, animated: true)



  }

  func loadQuakes() {
    Alamofire.request(.GET, self.quakeUrl!, parameters: nil)
      .responseJSON { response in

        if response.result.error == nil {
          debugPrint("API terremotos : \(response.result.value)")
          let json = JSON(response.result.value!)
          self.quakes = Quake.quakesFromJSON(json["features"])

          var quakeAnnotations = [MKPointAnnotation]()

          for q in self.quakes {
            let annotation = QuakeAnnotation()

            annotation.title = q.place
            annotation.subtitle = "\(q.magnitude) - \(q.date.description)"
            annotation.coordinate = q.getLocation().coordinate
            annotation.quake = q

            quakeAnnotations.append(annotation)
          }
          
          self.mapView.addAnnotations(quakeAnnotations)
        }
        
    }
  }

  // Map delegate methods

  func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {

    if annotation.isKindOfClass(MKUserLocation.self) {
      return nil
    }

    let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "loc")
    annotationView.canShowCallout = true
    annotationView.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)

    return annotationView
  }


  func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

    if let quakeAnnotation = view.annotation as? QuakeAnnotation {
      debugPrint("se ha presionado : \(quakeAnnotation.quake?.place)")
      self.quakeSelected = quakeAnnotation.quake
      self.performSegueWithIdentifier("quakeDetailSegue", sender: nil)
    }

  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "quakeDetailSegue" {
      let detailVC = segue.destinationViewController as! QuakeViewController
      detailVC.quake = quakeSelected
    }
  }


}
