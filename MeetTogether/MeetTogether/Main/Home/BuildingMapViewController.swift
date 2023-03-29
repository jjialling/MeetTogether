//
//  BuildingMapViewController.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/7.
//

import UIKit
import GoogleMaps
//import GooglePlaces

class BuildingMapViewController: UIViewController {
    
    private lazy var closeBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        btn.makeCloseStyle()
        btn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var mapView: GMSMapView = {
        let mapView = GMSMapView()
//        mapView.delegate = self
        return mapView
    }()
    
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    var isPermissionAllow: Bool?
//    var placesClient: GMSPlacesClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocation()
        setMap()
        setUI()
    }
     
    func setUI() {
        view.addSubviews([mapView, closeBtn])
        mapView.snp.makeConstraints({
            $0.top.leading.trailing.bottom.equalToSuperview()
        })
        closeBtn.snp.makeConstraints({
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(56)
            $0.width.height.equalTo(32)
        })
    }
    
    func setLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    func setMap() {
//        placesClient = GMSPlacesClient.shared() /// direct to google map

        if locationManager.location == nil {
            let camera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: 35.53659756176731, longitude:  -98.70791365120796), zoom: 16)
            mapView.camera = camera
        }
        
        setMarkers()
        

        do {
          // Set the map style by passing the URL of the local file.
          if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
            mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
          } else {
            print("Unable to find style.json")
          }
        } catch {
          print("One or more of the map styles failed to load. \(error)")
        }
    }
    
    func setMarkers() {
        let marker = CustomMarker(labelText: "\(BuildingLocationType.stafford.title)")
        marker.position = CLLocationCoordinate2D(latitude: BuildingLocationType.stafford.latitude, longitude: BuildingLocationType.stafford.longitude)
        marker.map = mapView
        
        let marker2 = CustomMarker(labelText: "\(BuildingLocationType.oklahomaHall.title)")
        marker2.position = CLLocationCoordinate2D(latitude: BuildingLocationType.oklahomaHall.latitude, longitude: BuildingLocationType.oklahomaHall.longitude)
        marker2.map = mapView
        
        let marker3 = CustomMarker(labelText: "\(BuildingLocationType.campbell.title)")
        marker3.position = CLLocationCoordinate2D(latitude: BuildingLocationType.campbell.latitude, longitude: BuildingLocationType.campbell.longitude)
        marker3.map = mapView
        
        let marker4 = CustomMarker(labelText: "\(BuildingLocationType.technologyStone.title)")
        marker4.position = CLLocationCoordinate2D(latitude: BuildingLocationType.technologyStone.latitude, longitude: BuildingLocationType.technologyStone.longitude)
        marker4.map = mapView
        
        let marker5 = CustomMarker(labelText: "\(BuildingLocationType.technologyBrick.title)")
        marker5.position = CLLocationCoordinate2D(latitude: BuildingLocationType.technologyBrick.latitude, longitude: BuildingLocationType.technologyBrick.longitude)
        marker5.map = mapView
        
        let marker6 = CustomMarker(labelText: "\(BuildingLocationType.science.title)")
        marker6.position = CLLocationCoordinate2D(latitude: BuildingLocationType.science.latitude, longitude: BuildingLocationType.science.longitude)
        marker6.map = mapView
        
        let marker7 = CustomMarker(labelText: "\(BuildingLocationType.johnHaysAdministration.title)")
        marker7.position = CLLocationCoordinate2D(latitude: BuildingLocationType.johnHaysAdministration.latitude, longitude: BuildingLocationType.johnHaysAdministration.longitude)
        marker7.map = mapView
        
        let marker8 = CustomMarker(labelText: "\(BuildingLocationType.art.title)")
        marker8.position = CLLocationCoordinate2D(latitude: BuildingLocationType.art.latitude, longitude: BuildingLocationType.art.longitude)
        marker8.map = mapView

        let marker9 = CustomMarker(labelText: "\(BuildingLocationType.wellness.title)")
        marker9.position = CLLocationCoordinate2D(latitude: BuildingLocationType.wellness.latitude, longitude: BuildingLocationType.wellness.longitude)
        marker9.map = mapView
    
    }
    
    @objc func closeAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
extension BuildingMapViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations.last!
        let long = userLocation.coordinate.longitude
        let lat = userLocation.coordinate.latitude
        let newCamera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15)
        self.currentLocation = userLocation
        mapView.camera = newCamera
        self.locationManager.stopUpdatingLocation()
        
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        // Handle authorization status
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            let alertController = UIAlertController(title: "定位權限已關閉", message:"如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .default, handler:nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            self.isPermissionAllow = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
            manager.startUpdatingLocation() // Start location
            mapView.isMyLocationEnabled = true
            self.isPermissionAllow = true
            
        @unknown default:
            fatalError()
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}
