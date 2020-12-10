//
//  FactoryList.swift
//  PDQ
//
//  Created by Sekaji Maynard on 2020/12/8.
//

import UIKit
import RealmSwift

class Factory: Object {
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

class FactoryList: UIViewController{
    
    
    @IBOutlet weak var factoryList: UITableView!
    
    let hongli = Factory(name: "Honli Road Factory", lattitude:"22.54850", longitude: "114.06563", _id: "0")
//    var factories = [Factory]()
    var factories = try! Realm().objects(Factory.self).sorted(byKeyPath: "name", ascending: true)
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = realm.configuration.fileURL?.path
        print("Realm Path: \(String(describing: path))")
        factoryList.delegate = self
        factoryList.dataSource = self
        if realm.isEmpty {
            try! realm.write {
                realm.add(hongli)
            }
        }
    }
}

extension FactoryList: UITableViewDelegate{
    
}

extension FactoryList: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = factories[indexPath.row].name
        cell.detailTextLabel?.text = "Lattitude = \(factories[indexPath.row].lattitude), Longitude= \(factories[indexPath.row].longitude)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "editFactory", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EditFactoryViewController {
            destination.factory = factories[(factoryList.indexPathForSelectedRow?.row)!]
            destination.tableView = factoryList
        }
        factoryList.deselectRow(at: factoryList.indexPathForSelectedRow!, animated: true)
    }
}
