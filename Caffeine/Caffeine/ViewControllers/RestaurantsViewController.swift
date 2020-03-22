//
//  RestaurantsViewController.swift
//  Caffeine
//
//  Created by Dovydas Kiriliauskas on 2020-03-11.
//  Copyright © 2020 Dovydas Kiriliauskas. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class RestaurantsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
	private lazy var headerView: UIStackView = self.initHeaderView()
	private lazy var titleLabel: UILabel = self.initTitleLabel()
	private lazy var mapView: MKMapView = self.initMapView()
	private lazy var mapViewCoordinates: [MKPointAnnotation] = self.initMapPoints()
	let viewModel: RestaurantsViewModel = RestaurantsViewModel()
	fileprivate let locationManager: CLLocationManager = CLLocationManager()
	var initialStatusBarStyle : UIStatusBarStyle?
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .darkContent
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.navigationBar.isHidden = true
		
		self.view.addSubview(self.headerView)
		self.headerView.addArrangedSubview(self.titleLabel)
		self.view.addSubview(self.mapView)
		self.mapView.delegate = self
		
		locationManager.requestAlwaysAuthorization()
		locationManager.requestWhenInUseAuthorization()
		if CLLocationManager.locationServicesEnabled() {
			locationManager.delegate = self
			locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
			locationManager.startUpdatingLocation()
		}
		
		self.mapView.showsUserLocation = true
				let regionRadius: CLLocationDistance = 5200
		let coordinates = CLLocationCoordinate2D(latitude: 54.724288, longitude: 25.333273)
				let coordinateRegion = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
		self.mapView.setRegion(coordinateRegion, animated: true)
		
		self.stackViewConstraints()
		self.titleLabelConstraints()
		self.mapViewConstraints()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		UIApplication.shared.setStatusBarStyle(.default, animated: animated)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		UIApplication.shared.setStatusBarStyle(.darkContent, animated: animated)
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
		print("locations = \(locValue.latitude) \(locValue.longitude)")
	}
}

extension RestaurantsViewController {
	private func initHeaderView() -> UIStackView {
		let header = UIStackView()
		header.translatesAutoresizingMaskIntoConstraints = false
		header.backgroundColor = .white
		return header
	}
	
	private func initTitleLabel() -> UILabel {
		let titleLabel = UILabel()
		titleLabel.text = "CAFFEINE"
		titleLabel.font = UIFont(name: "Rubik-Bold", size: 40)
		titleLabel.textColor = UIColor(named: "orangeMain")
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.textAlignment = .left
		titleLabel.contentMode = .scaleAspectFit
		return titleLabel
	}
	
	private func initMapView() -> MKMapView {
		let mapView = MKMapView()
		mapView.translatesAutoresizingMaskIntoConstraints = false
		mapView.addAnnotations(self.mapViewCoordinates)
		return mapView
	}
	
	private func initMapPoints() -> [MKPointAnnotation] {
		var mapViewArray = [MKPointAnnotation]()
		for index in self.viewModel.coordinatesArray {
			let annotation = MKPointAnnotation()
			annotation.coordinate = CLLocationCoordinate2D(latitude: index[0], longitude: index[1])
			mapViewArray.append(annotation)
		}
		
		return mapViewArray
	}
}

extension RestaurantsViewController {
	private func stackViewConstraints() {
		NSLayoutConstraint.activate(
			[
				self.headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12.0),
				self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
				self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
				self.headerView.heightAnchor.constraint(equalToConstant: 30)
			]
		)
	}
	
	private func titleLabelConstraints() {
		NSLayoutConstraint.activate(
			[
				self.titleLabel.topAnchor.constraint(equalTo: self.headerView.topAnchor),
				self.titleLabel.leadingAnchor.constraint(equalTo: self.headerView.leadingAnchor),
				self.titleLabel.trailingAnchor.constraint(equalTo: self.headerView.trailingAnchor),
				self.titleLabel.bottomAnchor.constraint(equalTo: self.headerView.bottomAnchor)
			]
		)
	}
	
	private func mapViewConstraints() {
		NSLayoutConstraint.activate([
			self.mapView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: 12.0),
			self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			self.mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
		])
	}
}

extension RestaurantsViewController {
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		
		let identifier = "Pin"
		let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
		
		if annotation is MKUserLocation {
			return nil
		} else {
			annotationView.isEnabled = true
			annotationView.canShowCallout = true
			annotationView.image =  UIImage(imageLiteralResourceName: "coffeePin")
			annotationView.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(tap))]
			return annotationView
		}
	}
	
	@objc func tap() {
		let propertyVC = PropertyCardViewController(image: self.viewModel.image, address: self.viewModel.address, workingHours: self.viewModel.workingHours)
		UIView.transition(with: self.view, duration: 0.5, options: [.curveEaseIn], animations: {
		  self.view.addSubview(propertyVC)
		}, completion: nil)
		propertyVC.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			propertyVC.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16.0),
		propertyVC.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
		propertyVC.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0),
		propertyVC.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -150.0)
		])
	}
}

