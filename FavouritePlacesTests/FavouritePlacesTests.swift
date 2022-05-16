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
    ///  Getter and Setter
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
        
        
        

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
