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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 34.0689, longitude: -118.4452, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 34.0689, longitude: -118.4452)
        marker.title = "UCLA"
        marker.map = mapView
        
    }

}

