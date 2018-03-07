//
//  ClassesViewController.swift
//  HackSprint
//
//  Created by Katie Cai on 3/2/18.
//  Copyright © 2018 Katie Cai. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ClassesViewController: UIViewController {

    @IBOutlet var mapView: GMSMapView?
    @IBOutlet weak var tableView: UITableView!
        
    var building: String!
    var geocoords: (Double, Double)!
    
    var option: Int!
    
    override func viewDidLoad() {
//        print(building)
//        print(geocoords)
//        print(option)
        
        super.viewDidLoad()
        
        let lat = geocoords.0
        let long = geocoords.1
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 18.0)
        mapView?.camera = camera
        let camera_update = GMSCameraUpdate.setCamera(camera)
        mapView?.moveCamera(camera_update)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.title = building
        marker.map = mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
