//
//  EditStoreViewController.swift
//  PDQ
//
//  Created by Sekaji Maynard on 2020/12/9.
//

import UIKit
import RealmSwift

class EditStoreViewController: UIViewController {
    
    let realm = try! Realm()
    var store :  Store!
    var tableView : UITableView!
    
    @IBOutlet weak var editStoreName: UITextField!
    @IBOutlet weak var editStoreLattitude: UITextField!
    @IBOutlet weak var editStoreLongitude: UITextField!
    
    
    @IBAction func updateStore(_ sender: Any) {
        let stores = realm.objects(Store.self).filter("name = '\(store.name)'")
        if let store = stores.first{
            try! self.realm.write{
                store.name = (editStoreName?.text)!
                store.lattitude = (editStoreLattitude?.text)!
                store.longitude = (editStoreLongitude?.text)!
            }
        }
        tableView.reloadData()
    }
    
    
    @IBAction func deleteStore(_ sender: Any) {
        let stores = realm.objects(Store.self).filter("name = '\(store.name)'")
        if stores.count > 0{
            for store in stores{
                try! self.realm.write{
                    self.realm.delete(store)
                }
            }
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editStoreName.text = store.name
        editStoreLattitude.text = store.lattitude
        editStoreLongitude.text = store.longitude
    }
}
