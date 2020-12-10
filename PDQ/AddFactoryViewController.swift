//
//  AddFactoryViewController.swift
//  PDQ
//
//  Created by Sekaji Maynard on 2020/12/8.
//

import UIKit
import RealmSwift
import MapKit


class AddFactoryViewController: UIViewController {
    
    
    @IBOutlet weak var factoryName: UITextField!
    @IBOutlet weak var factoryLattitude: UITextField!
    @IBOutlet weak var factoryLongitude: UITextField!
    
    let realm = try! Realm()
    
    @IBAction func saveFactory(_ sender: Any) {
        print(" Name = \(String(describing: factoryName?.text!))\n Lattitude= \(String(describing: factoryLattitude?.text!))\n Longitude= \(String(describing: factoryLongitude?.text!))")
        let newFact = Factory(name: (factoryName?.text)!, lattitude: (factoryLattitude?.text)!, longitude: (factoryLongitude?.text)!, _id: "")
        try! self.realm.write{
            self.realm.add(newFact)
        }
        
        let annotation = MKPointAnnotation()
        let nLat = Double((factoryLattitude?.text)!)!
        let nLong = Double((factoryLongitude?.text)!)!
        annotation.coordinate = CLLocationCoordinate2D(latitude: nLat, longitude: nLong)
        annotation.title = factoryName?.text
        annotation.subtitle = "Newly Added!"
        addFactoryMap.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
        addFactoryMap.setRegion(region, animated: true)
        addFactoryMap.reloadInputViews()
        
    }
    
    
    @IBOutlet weak var addFactoryMap: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


