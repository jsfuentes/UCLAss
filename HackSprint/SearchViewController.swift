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
    
    let buildings = ["700 Westwood Plaza": (34.0667059, -118.4447794),"Ackerman Student Union": (34.0739537, -118.4430523),"Biomedical Sciences Research Building": (34.066651, -118.442417),"Brain Mapping Center": (34.0667788, -118.4443802),"Boelter Hall": (34.068987, -118.442659),"Botany Building": (34.0668079, -118.44110999999998),"Boyer Hall": (34.0680878, -118.4416559),"Bradley Hall": (34.0697176, -118.4494047),"Brain Research Institute": (34.0673111, -118.4448319),"Broad Art Center": (34.075885, -118.44099690000002),"Bunche Hall": (34.07425169999999, -118.44011109999997),"Campbell Hall": (34.07367170000001, -118.44130239999998),"Carnesale Commons": (34.0721215, -118.44973370000002),"William Andrews Clark Memorial Library": (34.0333271, -118.31441419999999),"California NanoSystems Institute": (34.06820029999999, 118.44232640000001),"Collins Center for Executive Education": (34.0738081, -118.4436508),"Cornell Hall": (34.0740033, -118.44336279999999),"Covel Commons": (34.0730094, -118.44998809999998),"De Neve Plaza Commons Building": (34.0708126, -118.450173),"School of Dentistry": (34.0661004, -118.44196599999998),"Dodd Hall": (34.0726629, -118.43927589999998),"Engineering IV": (34.0687994, 118.4440275),"Engineering V": (34.06945350000001, -118.44378240000003),"Entrepreneurs Hall": (34.0736256, -118.44344189999998),"Factor Health Sciences Building": (34.063718, 118.44251009999999),"Fernald Center": (34.0763567, -118.443828),"Field": (34.07218819999999, -118.44685179999999),"Fowler Museum at UCLA": (34.0729274, -118.44298300000003),"Franz Hall": (34.0696422, -118.4412792),"Geology Building": (34.0692226, -118.44178499999998),"Gold Hall": (34.0736262, -118.44387710000001),"Gonda  Neuroscience and Genetics Research Center": (34.0673704, -118.44468240000003),"Graduate School of Education and Information Studies Building": (34.0750904, -118.44212419999997),"Haines Hall": (34.07287850000001, -118.4411359),"Hedrick Hall": (34.0731836, 118.45231519999999),"Hershey Hall": (34.0668431, -118.43981309999998),"Center for the Health Sciences": (34.0658571, -118.44481530000002),"Humanities Building": (34.0713898, -118.44117990000001),"Kaufman Hall": (34.0728633, -118.44406140000001),"Kerckhoff Hall": (34.0704371, 118.44360039999998),"Kinsey Science Teaching Pavilion": (34.0701066, -118.4412542),"Knudsen Hall": (34.0705889, -118.44109709999998),"Korn Convocation Hall": (34.0739537, -118.44305229999998),"La Kretz Hall": (34.0651472, -118.44235789999999),"Law Building": (34.0730485, -118.43843219999997),"Life Sciences": (34.0672324, -118.44219399999997),"Lu Valle Commons": (34.0736624, 118.43924340000001),"MacDonald Medical Research Laboratories": (34.06737389999999, 118.44400280000002),"Macgowan Hall": (34.07588150000001, -118.43968130000002),"Macgowan Hall East": (34.07610699999999, -118.43932430000001),"Marion Davies Children's Center": (34.06522710000001, -118.44238860000002),"Melnitz Hall": (34.0764333, -118.44000979999998),"Molecular Sciences Building": (34.0680479, -118.4407827),"Moore Hall": (34.0704197, -118.4426416),"Morton Medical Building": (34.06505, 118.44603890000002),"Medical Plaza 100": (34.06505, 118.44603890000002),"Medical Plaza 300": (34.0644164, -118.44605309999997),"Mathematical Sciences": (34.0696014, -118.44287429999997),"Murphy Hall": (34.07160909999999, -118.4387084),"Neuroscience Research Building": (34.0671168, -118.44361750000002),"No facility": (34.0689, 118.4452),"Northwest Campus Auditorium": (34.07194400000001, -118.45051669999998),"Off campus": (34.0522, 118.2437),"Ostin Music Center": (34.0702448, -118.4403208),"Physics and Astronomy Building": (34.0706955,-118.44157999999999),"Perloff Hall": (34.073456,-118.4401909),"Portola Plaza Building": (34.07215650000001,-118.44078439999998),"Powell Library Building": (34.07161260000001,-118.44218089999998),"Public Affairs Building": (34.0744024,-118.43908650000003),"Public Health": (34.0665992,-118.44305229999998),"Ueberroth Building": (34.0640108,-118.44695339999998),"Reed Neurological Research Center": (34.0659028,-118.4434435),"Rieber Hall": (34.0716799,-118.45149879999997),"Rolfe Hall": (34.0737012,-118.44207),"Royce Hall": (34.0728088,-118.44215919999999),"Student Activities Center": (34.0715644,-118.44408629999998),"Semel Institute for Neuroscience and HumanBehavior": (34.0658662,-118.4446615),"Slichter Hall": (34.0689305,-118.44078050000002),"Schoenberg Music Building": (34.0707483,-118.44012609999999),"Sproul Hall": (34.0724491,-118.4501209),"Terasaki Life Sciences Building": (34.0671903,-118.44037270000001),"UCLA Lab School": (34.0671903, -118.44037270000001),"Young Hall": (34.0685828,-118.44151139999997),"Wooden Recreation and Sports Center": (34.0704818,-118.4468023),"Young Research Library": (34.0749691,-118.44146599999999)]
    
    var tappedBuilding: String!
    var buildingsArray: [String]!
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
                destination.geocoords = buildings[tappedBuilding]
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self as CLLocationManagerDelegate
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//        }
//        
//        currentLatitude = locationManager.location?.coordinate.latitude
//        currentLongitude = locationManager.location?.coordinate.longitude
//        
//        let camera = GMSCameraPosition.camera(withLatitude: currentLatitude, longitude: currentLongitude, zoom: 15.0)
//        mapView?.camera = camera
//        let camera_update = GMSCameraUpdate.setCamera(camera)
//        mapView?.moveCamera(camera_update)
        
        let camera = GMSCameraPosition.camera(withLatitude: 34.0689, longitude: -118.4452, zoom: 16.0)
        mapView?.camera = camera
        let camera_update = GMSCameraUpdate.setCamera(camera)
        mapView?.moveCamera(camera_update)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 34.0689, longitude: -118.4452)
        marker.title = "You are here"
        marker.map = mapView
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        buildingsArray = Array(buildings.keys)
        buildingsArray.sort { $0.compare($1, options: .numeric) == .orderedAscending }
        filteredBuildings = buildingsArray
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
        filteredBuildings = searchText.isEmpty ? buildingsArray : buildingsArray.filter { (item: String) -> Bool in
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
