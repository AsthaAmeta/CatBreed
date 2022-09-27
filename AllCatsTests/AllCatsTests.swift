//
//  AllCatsTests.swift
//  AllCatsTests
//
//  Created by Astha Ameta on 15/09/22.
//

import XCTest
@testable import AllCats

class AllCatsTests: XCTestCase {

    var sut: CatBreedViewModel!
    var testData: Data!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let data = loadStub(name: "catData", extension: "json")
        let decoder = JSONDecoder()
        let catData = try decoder.decode(Cat.self, from: data)
        sut = CatBreedViewModel()
        print("Data:\(getData(name: catData.name))")
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        UserDefaults.standard.removeObject(forKey: "name")
    }

    func getData(name: String, withExtension: String = "json") -> Data {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
        let data = try! Data(contentsOf: fileUrl!)
        //print("Data:\(data)")
        return data
    }
    
    func testName() throws {
        let name: String = "bengal"
        UserDefaults.standard.set(name, forKey: "name")
        XCTAssertEqual(sut.cat.first?.name, name)
    }
    
    func testExample() throws {
        var mockContentData: Data {
            return getData(name: "catData")
        }
    }
}

extension XCTestCase {
    func loadStub(name: String, extension: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: name, withExtension: `extension`)
        return try! Data(contentsOf: url!)
    }
}
