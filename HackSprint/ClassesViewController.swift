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
    
    // Dictionary mapping DevX API building names to GeoCoordinates
    
    var building: String!
    var option: Int!
    
    override func viewDidLoad() {
        print(building)
        print(option)
        
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 34.0689, longitude: -118.4452, zoom: 15.0)
        mapView?.camera = camera
        let camera_update = GMSCameraUpdate.setCamera(camera)
        mapView?.moveCamera(camera_update)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 34.0689, longitude: -118.4452)
        marker.title = "UCLA"
        marker.map = mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
