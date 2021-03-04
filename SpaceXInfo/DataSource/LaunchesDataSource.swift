//
//  ObjectDataSource.swift
//  SpaceXInfo
//
//  Created by Gustavo Tiecker on 09/02/21.
//

import UIKit

class LaunchesDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var upcomingLaunches: [Launch] = []
    private var selectedCallback: ((IndexPath)->Void)?
    
    func selectedItemAtIndex(callback: @escaping (IndexPath) -> Void) {
        selectedCallback = callback
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingLaunches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchCell.reuseID) as! LaunchCell
        let launch = upcomingLaunches[indexPath.row]
        
        cell.set(launch: launch)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let callback = selectedCallback {
               callback(indexPath)
        }
    }
}
