//
//  RocketsDataSource.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 04/03/21.
//

import UIKit

class RocketsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var rockets: [Rocket] = []
    private var selectedCallback: ((IndexPath)->Void)?
    
    func selectedItemAtIndex(callback: @escaping (IndexPath) -> Void) {
        selectedCallback = callback
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rockets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RocketCell.reuseID) as! RocketCell
        let rocket = rockets[indexPath.row]
        
        cell.set(rocket: rocket)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let callback = selectedCallback {
            callback(indexPath)
        }
    }
}
