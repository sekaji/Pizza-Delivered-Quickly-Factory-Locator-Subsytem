//
//  EditFactoryViewController.swift
//  PDQ
//
//  Created by Sekaji Maynard on 2020/12/9.
//

import UIKit
import RealmSwift

class EditFactoryViewController: UIViewController {
    
    @IBOutlet weak var editFactoryName: UITextField!
    @IBOutlet weak var editfactoryLattitude: UITextField!
    @IBOutlet weak var editFactoryLongitude: UITextField!
    let realm = try! Realm()
    
    @IBAction func editFactory(_ sender: Any) {
        let facts = realm.objects(Factory.self).filter("name = '\(factory.name)'")
        if let fact = facts.first{
            try! self.realm.write{
                fact.name = (editFactoryName?.text)!
                fact.lattitude = (editfactoryLattitude?.text)!
                fact.longitude = (editFactoryLongitude?.text)!
            }
        }
        tableView.reloadData()
    }
    
    @IBAction func deleteFactory(_ sender: Any) {
        let facts = realm.objects(Factory.self).filter("name = '\(factory.name)'")
        if facts.count > 0{
            for fact in facts{
                try! self.realm.write{
                    self.realm.delete(fact)
                }
            }
        }
        tableView.reloadData()
    }
    
    
    var factory : Factory!
    var tableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        editFactoryName.text = factory.name
        editfactoryLattitude.text = factory.lattitude
        editFactoryLongitude.text = factory.longitude
    }
}
