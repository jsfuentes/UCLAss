//
//  SearchViewController.swift
//  HackSprint
//
//  Created by Katie Cai on 2/14/18.
//  Copyright © 2018 Katie Cai. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class SearchViewController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: GMSMapView?
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    
    let buildings = ["700 Westwood Plaza","Ackerman Student Union","Biomedical Sciences Research Building","Brain Mapping Center","Boelter Hall","Botany Building","Boyer Hall","Bradley Hall","Brain Research Institute","Broad Art Center","Bunche Hall","Campbell Hall","Carnesale Commons","William Andrews Clark Memorial Library","California NanoSystems Institute","Collins Center for Executive Education","Cornell Hall","Covel Commons","De Neve Plaza Commons Building","School of Dentistry","Dodd Hall","Engineering IV","Engineering V","Entrepreneurs Hall","Factor Health Sciences Building","Fernald Center","Field","Fowler Museum at UCLA","Franz Hall","Geology Building","Gold Hall","Gonda  Neuroscience and Genetics Research Center","Graduate School of Education and Information Studies Building","Haines Hall","Hedrick Hall","Hershey Hall","Center for the Health Sciences","Humanities Building","Kaufman Hall","Kerckhoff Hall","Kinsey Science Teaching Pavilion","Knudsen Hall","Korn Convocation Hall","La Kretz Hall","Law Building","Life Sciences","Lu Valle Commons","MacDonald Medical Research Laboratories","Macgowan Hall","Macgowan Hall East","Marion Davies Children's Center","Melnitz Hall","Molecular Sciences Building","Moore Hall","Morton Medical Building","Medical Plaza 100","Medical Plaza 300","Mathematical Sciences","Murphy Hall","Neuroscience Research Building","No facility","Northwest Campus Auditorium","Off campus","Ostin Music Center","Physics and Astronomy Building","Perloff Hall","Portola Plaza Building","Powell Library Building","Public Affairs Building","Public Health","Ueberroth Building","Reed Neurological Research Center","Rieber Hall","Rolfe Hall","Royce Hall","Student Activities Center","Semel Institute for Neuroscience and HumanBehavior","Slichter Hall","Schoenberg Music Building","Sproul Hall","Terasaki Life Sciences Building","UCLA Lab School","Young Hall","Wooden Recreation and Sports Center","Young Research Library"]
    
    var tappedBuilding: String!
    var filteredBuildings: [String]!
    var option: Int!
    var currentLatitude: Double!
    var currentLongitude: Double!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let destination = segue.destination as? ClassesViewController {
            destination.option = option
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let tappedBuilding = filteredBuildings[indexPath.row]
                destination.building = tappedBuilding
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        currentLatitude = locationManager.location?.coordinate.latitude
        currentLongitude = locationManager.location?.coordinate.longitude
    
        
        let camera = GMSCameraPosition.camera(withLatitude: currentLatitude, longitude: currentLongitude, zoom: 15.0)
        mapView?.camera = camera
        let camera_update = GMSCameraUpdate.setCamera(camera)
        mapView?.moveCamera(camera_update)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude)
        marker.title = "You are here"
        marker.map = mapView
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        filteredBuildings = buildings
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let locValue:CLLocationCoordinate2D = manager.location!.coordinate
            currentLatitude = locValue.latitude
            currentLongitude = locValue.longitude
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        tableView.isHidden = false
        return true
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
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

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
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
