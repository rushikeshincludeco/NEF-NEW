//
//  MapViewController.swift
//  
//
//  Created by include tech. on 27/12/16.
//
//

import UIKit
import CoreLocation
import MapKit


class MapViewController: UIViewController, CLLocationManagerDelegate, XMLParserDelegate, MKMapViewDelegate {

	@IBOutlet weak var mapView: MKMapView!
	var locationManager = CLLocationManager()
	var boundaries = [CLLocationCoordinate2D]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		zoomToRegion()
		mapView.snp.makeConstraints { (make) -> Void in
			make.top.equalTo(50)
			make.left.right.bottom.equalTo(view)
		}
		self.locationManager.requestAlwaysAuthorization()
		self.locationManager.requestWhenInUseAuthorization()
		
		if CLLocationManager.locationServicesEnabled() {
			locationManager.delegate = self
			locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
			locationManager.startUpdatingLocation()
		}
		
		var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
		let annotations = getMapAnnotations()
		mapView.delegate = self
//		mapView.addAnnotations(annotations)
		for annotation in annotations {
				points.append(annotation.coordinate)
		}
		let polyline = MKPolyline(coordinates: &points, count: points.count)
		mapView.add(polyline, level: MKOverlayLevel.aboveRoads)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
		if overlay is MKPolyline {
			let polylineRenderer = MKPolylineRenderer(overlay: overlay)
			polylineRenderer.strokeColor = UIColor.blue
			polylineRenderer.lineWidth = 5
			return polylineRenderer
		}
		return 0 as! MKOverlayRenderer
	}

	func getMapAnnotations() -> [Station] {
		var annotations:Array = [Station]()
		let fileName = "path"
		
		let filePath = getFilePath(fileName)
		let data = try? Data(contentsOf: URL(fileURLWithPath: filePath!))
		
		let parser = XMLParser(data: data!)
		parser.delegate = self
		
		let success = parser.parse()
		
		if !success {
			print ("Failed to parse the following file: path.gpx")
		}

		if boundaries.count > 0 {
			for index in 0...boundaries.count-1 {
				let lat = boundaries[index].latitude
				let long = boundaries[index].longitude
				let annotation = Station(latitude: lat, longitude: long)
				annotations.append(annotation)
			}
		}
		return annotations
	}
	
	func zoomToRegion() {
		let location = CLLocationCoordinate2D(latitude: 55.753572, longitude: 37.808250)
		let region = MKCoordinateRegionMakeWithDistance(location, 20000.0, 20000.0)
		mapView.setRegion(region, animated: true)
	}
	
	func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
		if elementName == "trkpt" || elementName == "wpt" {
			let lat = attributeDict["lat"]!
			let lon = attributeDict["lon"]!
			boundaries.append(CLLocationCoordinate2DMake(CLLocationDegrees(lat)!, CLLocationDegrees(lon)!))
		}
	}

	func getFilePath(_ fileName: String) -> String? {
		return Bundle.main.path(forResource: fileName, ofType: "gpx")
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

class Station: NSObject, MKAnnotation {
	var title: String?
	var subtitle: String?
	var latitude: Double
	var longitude:Double
 
	var coordinate: CLLocationCoordinate2D {
		return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
	}
 
	init(latitude: Double, longitude: Double) {
		self.latitude = latitude
		self.longitude = longitude
	}
}
