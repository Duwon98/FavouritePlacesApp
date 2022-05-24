//
//  FavouritePlacesTests.swift
//  FavouritePlacesTests
//
//  Created by Duwon Ha on 1/5/2022.
//

import XCTest
import MapKit
@testable import FavouritePlaces

class FavouritePlacesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// <#description#>
    /// Test the CoordinateRegionViewModel
    func testCoordinateRegionViewModel() throws {
        ///Making CoordinateRegionViewModel element
        var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        
        /// when you get the values of it. it should be String
        XCTAssertEqual(region.latitudeString, "0.0")
        XCTAssertEqual(region.longitudeString, "0.0")
        
        /// changing the values
        region.latitudeString = "3.3"
        XCTAssertEqual(region.latitudeString, "3.3")
        
        /// if changed value is not convertable to Double, it will not be changed.
        region.latitudeString = "Cause the error"
        /// Case the error
        XCTAssertEqual(region.latitudeString, "Cause the error")
        
        // latitude range must be -90 <= latitude <= 90. Otherwise the value won't be changed
        region.latitudeString = "180"
        /// Cause the Error. because value didn't change
        XCTAssertEqual(region.latitudeString, "180.0")
        
        // longitude range must be -180 <= latitude <= 180. Otherwise the value won't be changed
        region.longitudeString = "-200"
        /// Cause the Error. because value didn't change
        XCTAssertEqual(region.longitudeString, "-200.0")
        
    }
    /// <#description#>
    /// Test the CLLocationViewModel
    func testCLLocationViewModel() throws {
        var location = LocationViewModel(location: CLLocation(latitude: 0, longitude: 0))
        /// when you get the values of it. it should be String
        location.latitudeString = "90"
        location.longitudeString = "90"
        XCTAssertEqual(location.latitudeString, "90.0")
        XCTAssertEqual(location.longitudeString, "90.0")
        
        /// changing value
        location.latitudeString = "45"
        location.longitudeString = "-45"
        XCTAssertEqual(location.latitudeString, "45.0")
        XCTAssertEqual(location.longitudeString, "-45.0")
        
        // latitude range must be -90 <= latitude <= 90. Otherwise the value won't be changed
        location.latitudeString = "180"
        /// Cause the Error. because value didn't change
        XCTAssertEqual(location.latitudeString, "180.0")
        
        // longitude range must be -180 <= latitude <= 180. Otherwise the value won't be changed
        location.longitudeString = "-200"
        /// Cause the Error. because value didn't change
        XCTAssertEqual(location.longitudeString, "-200.0")
        

        
        
        
        
        
        
        
        
        
        
        
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
