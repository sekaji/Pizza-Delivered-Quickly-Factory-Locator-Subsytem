//
//  StoreList.swift
//  PDQ
//
//  Created by Sekaji Maynard on 2020/12/9.
//

import UIKit
import RealmSwift

class StoreList: UIViewController {
    
    @IBOutlet weak var storeList: UITableView!
    let stores = try! Realm().objects(Store.self).sorted(byKeyPath: "name", ascending: true)
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeList.delegate = self
        storeList.dataSource = self
    }
}
extension StoreList: UITableViewDelegate{
    
}

extension StoreList: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath)
        cell.textLabel?.text = stores[indexPath.row].name
        cell.detailTextLabel?.text = "Lattitude = \(stores[indexPath.row].lattitude), Longitude= \(stores[indexPath.row].longitude)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "editStore", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EditStoreViewController {
            destination.store = stores[(storeList.indexPathForSelectedRow?.row)!]
            destination.tableView = storeList
        }
        storeList.deselectRow(at: storeList.indexPathForSelectedRow!, animated: true)
    }
}
