//
//  MKMapView.swift
//  DayCareFinder
//
//  Created by Jared Payne on 11/27/18.
//  Copyright © 2018 Jared Payne. All rights reserved.
//

import MapKit

extension MKMapView {
    
    public func setAddress(_ fullAddress: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(fullAddress) { placemarks, error in
            guard let clPlacemark = placemarks?.first else { return }
            let placemark = MKPlacemark(placemark: clPlacemark)
            var region = self.region
            region.center = placemark.location!.coordinate
            region.span.longitudeDelta = 0.010
            region.span.latitudeDelta = 0.005
            self.setRegion(region, animated: true)
            self.addAnnotation(placemark)
        }
    }
}
