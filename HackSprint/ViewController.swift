//
//  ViewController.swift
//  HackSprint
//
//  Created by Katie Cai on 2/14/18.
//  Copyright © 2018 Katie Cai. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet var mapView: GMSMapView?
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    let buildings = ["Powell Library", "Royce Hall"]
    
    var filteredBuildings: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 34.0689, longitude: -118.4452, zoom: 15.0)
        mapView?.camera = camera
        let camera_update = GMSCameraUpdate.setCamera(camera)
        mapView?.moveCamera(camera_update)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 34.0689, longitude: -118.4452)
        marker.title = "UCLA"
        marker.map = mapView
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        filteredBuildings = buildings
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        tableView.isHidden = false
        return true
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredBuildings = searchText.isEmpty ? buildings : buildings.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let tappedBuilding = filteredBuildings[indexPath.row]
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = filteredBuildings[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBuildings.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
