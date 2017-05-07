//
//  ViewController.swift
//  MKAnnotationViewAutoLayoutExample
//
//  Created by Simon Fairbairn on 07/05/2017.
//  Copyright © 2017 Voyage Travel Apps. All rights reserved.
//

import UIKit
import MapKit

class ExampleAnnotation : NSObject, MKAnnotation {
	
	let coordinate : CLLocationCoordinate2D
	let number : Int
	
	init(location : CLLocationCoordinate2D, number : Int) {
		self.coordinate = location
		self.number = number
	}
	
}


class ViewController: UIViewController {
	
	@IBOutlet weak var mapView : MKMapView!
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(addNewPin(_:)))
		self.view.addGestureRecognizer(tapGestureRecogniser)
		
		mapView.delegate = self
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func addNewPin( _ recogniser : UITapGestureRecognizer ) {
		let firstTouch = recogniser.location(ofTouch: 0, in: self.mapView)
		let coordinate = mapView.convert(firstTouch, toCoordinateFrom: mapView)
		
		let annotation = ExampleAnnotation(location: coordinate, number: mapView.annotations.count + 1)
		mapView.addAnnotation(annotation)
		
	}
}

extension ViewController : MKMapViewDelegate {
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		
		guard let annotation = annotation as? ExampleAnnotation else {
			return nil
		}
		
		let identifier = "pin"
		var view: ExampleAnnotationView
		if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? ExampleAnnotationView {
			dequeuedView.annotation = annotation
			view = dequeuedView
		} else {
			// 3
			view = ExampleAnnotationView(annotation: annotation, reuseIdentifier: identifier)
		}
		
		view.titleLabel?.text = "Pin \(annotation.number)"
		return view
	}
}
