//
//  AddStoreViewController.swift
//  PDQ
//
//  Created by Sekaji Maynard on 2020/12/9.
//

import UIKit
import RealmSwift
import MapKit

class Store: Object {
    @objc dynamic var name = ""
    @objc dynamic var lattitude = ""
    @objc dynamic var longitude = ""
    @objc dynamic var _id: ObjectId = ObjectId.generate()
    convenience init(name: String, lattitude: String, longitude: String, _id: String){
        self.init()
        self.name = name
        self.lattitude = lattitude
        self.longitude = longitude
    }
    override static func primaryKey() -> String? {
        return "_id"
    }
    
}

class AddStoreViewController: UIViewController {
    
    @IBOutlet weak var storeName: UITextField!
    @IBOutlet weak var storeLattitude: UITextField!
    @IBOutlet weak var storeLongitude: UITextField!
    let realm = try! Realm()
    
    @IBOutlet weak var addStoreMap: MKMapView!
    
    @IBAction func addStoreLocation(_ sender: Any) {
        let newFact = Store(name: (storeName?.text)!, lattitude: (storeLattitude?.text)!, longitude: (storeLongitude?.text)!, _id: "")
        try! self.realm.write{
            self.realm.add(newFact)
            print("added successfully")
            
            let annotation = MKPointAnnotation()
            let nLat = Double((storeLattitude?.text)!)!
            let nLong = Double((storeLongitude?.text)!)!
            annotation.coordinate = CLLocationCoordinate2D(latitude: nLat, longitude: nLong)
            annotation.title = storeName?.text
            annotation.subtitle = "Newly Added!"
            addStoreMap.addAnnotation(annotation)
            let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
            addStoreMap.setRegion(region, animated: true)
            addStoreMap.reloadInputViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
