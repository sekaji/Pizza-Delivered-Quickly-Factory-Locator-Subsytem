//
//  ProposedFactoryViewController.swift
//  PDQ
//
//  Created by Sekaji Maynard on 2020/12/9.
//

import UIKit
import RealmSwift
import MapKit

class ProposedFactoryViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var store : Store!
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        let annotation = MKPointAnnotation()
        let nLat = Double(store.lattitude)!
        let nLong = Double(store.longitude)!
        annotation.coordinate = CLLocationCoordinate2D(latitude: nLat, longitude: nLong)
        annotation.title = store.name
        annotation.subtitle = "Newly Added!"
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
        mapView.setRegion(region, animated: true)
        mapView.reloadInputViews()
        
     
        
    }
}
