//
//  MapViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 31/03/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import MapKit
import Nuke

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    var sightViewModel: SightViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        navigationController?.isNavigationBarHidden = false;
        
        for place in (sightViewModel?.diplaySights)! {
            let annotation = PinAnnotation()
            annotation.coordinate = place.coordinate
            annotation.title = place.name
            annotation.image = UIImageView()
            
            let request = Request(url: URL(string: place.imagesURL.first!)!)
            Nuke.Manager.shared.loadImage(with: request, into: annotation.image!)
            mapView.addAnnotation(annotation)
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        if !annotation.isKind(of: PinAnnotation.self) {
            var pinAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "PinView")
            if pinAnnotationView == nil {
                pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PinView")
            }
            return pinAnnotationView
        }
        
        var view: AnnotationImageView? = mapView.dequeueReusableAnnotationView(withIdentifier: "imageAnnotation") as? AnnotationImageView
        if view == nil {
            view = AnnotationImageView(annotation: annotation, reuseIdentifier: "imageAnnotation")
        }
        
        let annotation = annotation as! PinAnnotation
        view?.image = annotation.image?.image
        view?.annotation = annotation
        //view?.canShowCallout = true
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view:  MKAnnotationView){
        
    }
}
