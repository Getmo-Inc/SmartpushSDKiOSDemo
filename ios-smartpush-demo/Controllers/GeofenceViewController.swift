//
//  GeofenceViewController.swift
//  ios-smartpush-demo
//
//  Created by Carlos Correa on 08/01/19.
//  Copyright © 2019 Getmo. All rights reserved.
//

import UIKit
import GoogleMaps

class GeofenceViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var lbLong: UILabel!
    @IBOutlet weak var lbLat: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var viewMap: UIView!
    @IBOutlet weak var viewLatLng: UIView!
    @IBOutlet weak var tfLat: UITextField!
    @IBOutlet weak var tfLng: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    
    var mapView : GMSMapView?
    let locationManager: CLLocationManager = CLLocationManager()
    var geofence = Geofence()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.distanceFilter = 10
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        self.mapView?.isMyLocationEnabled = true
        self.mapView?.delegate = self
        
        tfLat.delegate = self
        tfLng.delegate = self

        let camera = GMSCameraPosition.camera(withLatitude: AppUtils.shared.latitude, longitude: AppUtils.shared.longitude, zoom: 13.0)
        mapView = GMSMapView.map(withFrame: UIScreen.main.bounds, camera: camera)
        mapView?.isMyLocationEnabled = true
        
        let location = CLLocationCoordinate2D(latitude: AppUtils.shared.latitude, longitude: AppUtils.shared.longitude)
        let marker = GMSMarker.init(position: location)
        marker.isFlat = false
        marker.map = self.mapView
        
        mapView?.center = self.view.center
        
        self.view.addSubview(mapView!)
        
        
        let locationGeo = CLLocationCoordinate2D(latitude: AppUtils.shared.latitude, longitude: AppUtils.shared.longitude)
        let geoFenceRegion:CLCircularRegion = CLCircularRegion(center: locationGeo, radius: 500, identifier: "Push")
        locationManager.startMonitoring(for: geoFenceRegion)
        
        let cirlce = GMSCircle(position: location, radius: 500)
        cirlce.fillColor = UIColor.blue.withAlphaComponent(0.5)
        cirlce.map = self.mapView!
        
        self.view.addSubview(self.viewLatLng!)
        self.viewLatLng.addSubview(tfLat!)
        self.viewLatLng.addSubview(tfLng!)
        self.viewLatLng.addSubview(lbLocation!)
        self.viewLatLng.addSubview(lbLat!)
        self.viewLatLng.addSubview(lbLong!)
        self.viewLatLng.addSubview(btnSend!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil);

        //Set TECNOPUC location
        tfLat.text = "-30.059047"
        tfLng.text = "-51.171546"

    }
    
    @IBAction func sendLatLng(_ sender: UIButton) {
        guard let lat = Double(tfLat.text ?? "") else {
            showError()
            return
        }
        guard let lng = Double(tfLng.text ?? "") else {
            showError()
            return
        }
        
        AppUtils.shared.latitude = lat
        AppUtils.shared.longitude = lng
        
        self.centralizeMap()
        
        SmartpushSDK.sharedInstance().nearestZone(withLatitude: lat, andLongitude: lng)
        
        showSuccess()
    }

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("didEnter \(region.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("didExit \(region.identifier)")
    }
    
    private func showError(){
        UIAlertView(title: "Erro", message: "Ocorreu um erro", delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    private func showSuccess(){
        UIAlertView(title: "Success", message: "Solicitação enviada", delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    func centralizeMap() {
        let camera = GMSCameraPosition.camera(withLatitude: AppUtils.shared.latitude, longitude: AppUtils.shared.longitude, zoom: 13.0)
        mapView?.animate(to: camera)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: AppUtils.shared.latitude, longitude: AppUtils.shared.longitude, zoom: 13.0)
        
        //let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        mapView?.animate(to: camera)
        
        
    }
    
    @objc func keyboardWillShow() {
        self.view.frame.origin.y = -230 // Move view 150 points upward
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
}
