//
//  MapViewController.swift
//  PDQ
//
//  Created by Sekaji Maynard on 2020/12/3.
//

import UIKit
import RealmSwift
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var factories = try! Realm().objects(Factory.self).sorted(byKeyPath: "name", ascending: true)
    var stores = try! Realm().objects(Store.self).sorted(byKeyPath: "name", ascending: true)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for factory in factories{
            let annotation = MKPointAnnotation()
            let nLat = Double(factory.lattitude)!
            let nLong = Double(factory.longitude)!
            annotation.coordinate = CLLocationCoordinate2D(latitude: nLat, longitude: nLong)
            annotation.title = factory.name
            annotation.subtitle = "Factory"
            mapView.addAnnotation(annotation)
        }
        
        for store in stores{
            let annotation = MKPointAnnotation()
            let nLat = Double(store.lattitude)!
            let nLong = Double(store.longitude)!
            annotation.coordinate = CLLocationCoordinate2D(latitude: nLat, longitude: nLong)
            annotation.title = store.name
            annotation.subtitle = "Store"
            mapView.addAnnotation(annotation)
        }
        let store = stores[1]
        let annotation = MKPointAnnotation()
        let nLat = Double(store.lattitude)!
        let nLong = Double(store.longitude)!
        annotation.coordinate = CLLocationCoordinate2D(latitude: nLat, longitude: nLong)
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 5500, longitudinalMeters: 5500)
        mapView.setRegion(region, animated: true)
    }


}
