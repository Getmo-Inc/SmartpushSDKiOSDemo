//
//  GeofenceViewController.swift
//  ios-smartpush-demo
//
//  Created by Carlos Correa on 08/01/19.
//  Copyright © 2019 Getmo. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class GeofenceViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var lbLong: UILabel!
    @IBOutlet weak var lbLat: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var viewMap: UIView!
    @IBOutlet weak var viewLatLng: UIView!
    @IBOutlet weak var tfLat: UITextField!
    @IBOutlet weak var tfLng: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    let zoom: Float = 14.0;
    
    var mapView : GMSMapView?
    var circleRed: GMSCircle!
    var marker:GMSMarker!
    var latitude:Double=0
    var longitude:Double=0
    let locationManager: CLLocationManager = CLLocationManager()
    var geofence = Geofence()
    var centerMapCoordinate:CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.distanceFilter = 10
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters

        let camera = GMSCameraPosition.camera(withLatitude: AppUtils.shared.latitude, longitude: AppUtils.shared.longitude, zoom: zoom)
        mapView = GMSMapView.map(withFrame: UIScreen.main.bounds, camera: camera)
        mapView?.isMyLocationEnabled = false
        mapView?.isUserInteractionEnabled = true
        
        let location = CLLocationCoordinate2D(latitude: AppUtils.shared.latitude, longitude: AppUtils.shared.longitude)
        let marker = GMSMarker.init(position: location)
        marker.isFlat = false
        marker.map = self.mapView
        
        mapView?.center = self.view.center
        self.mapView?.delegate = self
        self.view.addSubview(mapView!)
        
        let locationGeo = CLLocationCoordinate2D(latitude: AppUtils.shared.latitude, longitude: AppUtils.shared.longitude)
        let geoFenceRegion:CLCircularRegion = CLCircularRegion(center: locationGeo, radius: 500, identifier: "Push")
        locationManager.startMonitoring(for: geoFenceRegion)
        
        let cirlce = GMSCircle(position: location, radius: 500)
        cirlce.fillColor = UIColor.blue.withAlphaComponent(0.5)
        cirlce.map = self.mapView!
        
        self.view.addSubview(self.viewLatLng!)
        self.viewLatLng.addSubview(btnSend!)
    }
    
    @IBAction func sendLatLng(_ sender: UIButton) {
//        guard let lat = Double(tfLat.text ?? "") else {
//            showError()
//            return
//        }
//        guard let lng = Double(tfLng.text ?? "") else {
//            showError()
//            return
//        }
        
//        AppUtils.shared.latitude = latitude
//        AppUtils.shared.longitude = longitude
        
//        self.centralizeMap()
        
        SmartpushSDK.sharedInstance().nearestZone(withLatitude: latitude, andLongitude: longitude)
        
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
        
        let message = "Solicitação enviada lat: \(latitude) longitude:\(longitude) "
        
        UIAlertView(title: "Success", message: message, delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    func centralizeMap() {
        let camera = GMSCameraPosition.camera(withLatitude: AppUtils.shared.latitude, longitude: AppUtils.shared.longitude, zoom: zoom)
        mapView?.animate(to: camera)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let camera = GMSCameraPosition.camera(withLatitude: AppUtils.shared.latitude, longitude: AppUtils.shared.longitude, zoom: zoom)
        mapView?.animate(to: camera)
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let latitude = mapView.camera.target.latitude
        let longitude = mapView.camera.target.longitude
        self.latitude = latitude
        self.longitude = longitude
        centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.placeMarkerOnCenter(centerMapCoordinate:centerMapCoordinate)
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
    }
    
    func placeMarkerOnCenter(centerMapCoordinate:CLLocationCoordinate2D) {
        if marker == nil {
            marker = GMSMarker()
        }
        marker.position = centerMapCoordinate
        let imageIcon =  UIImage.init(named: "man")
        marker.icon = self.image(imageIcon!, scaledToSize: CGSize(width: 30, height: 30))
        marker.map = self.mapView
    }
    
    fileprivate func image(_ originalImage:UIImage, scaledToSize:CGSize) -> UIImage {
        if originalImage.size.equalTo(scaledToSize) {
            return originalImage
        }
        UIGraphicsBeginImageContextWithOptions(scaledToSize, false, 0.0)
        originalImage.draw(in: CGRect(x: 0, y: 0, width: scaledToSize.width, height: scaledToSize.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
