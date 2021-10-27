//
//  APITestes.swift
//  iOSTakeHomeChallengeTests
//
//  Created by dejaWorks on 27/10/2021.
//

import XCTest

class APITestes: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    // API Tests
    // These API test are very basic level tests.
    // They are checking only ability to create Book, Character, House objects from API requests.
    func testBookApiRequest() throws {
        let expectation = self.expectation(description: "ApiRequest")
        
        var books:[Book]?
        
        
        DataService().read(endpoint: .books) { result in
            switch result{
            case .success(let data):
                if let data = data {
                    do{
                        books = try JSONDecoder().decode([Book].self, from: data)
                        expectation.fulfill()
                    }catch{
                        XCTAssert(true, "JSONDecoder Book is not succesful.")
                    }
                }else{
                    XCTAssertNil(data, "data is NIL")
                }
                
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
        
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertNotNil(books)
    }

    func testHouseApiRequest() throws {
        let expectation = self.expectation(description: "ApiRequest")
        
        var houses:[House]?
        
        
        DataService().read(endpoint: .houses) { result in
            switch result{
            case .success(let data):
                if let data = data {
                    do{
                        houses = try JSONDecoder().decode([House].self, from: data)
                        expectation.fulfill()
                    }catch{
                        XCTAssert(true, "JSONDecoder House is not succesful.")
                    }
                }else{
                    XCTAssertNil(data, "data is NIL")
                }
                
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
        
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertNotNil(houses)
    }
    
    func testCharacterApiRequest() throws {
        let expectation = self.expectation(description: "ApiRequest")
        
        var characters:[Character]?
        
        
        DataService().read(endpoint: .characters) { result in
            switch result{
            case .success(let data):
                if let data = data {
                    do{
                        characters = try JSONDecoder().decode([Character].self, from: data)
                        expectation.fulfill()
                    }catch{
                        XCTAssert(true, "JSONDecoder Character is not succesful.")
                    }
                }else{
                    XCTAssertNil(data, "data is NIL")
                }
                
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
        
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertNotNil(characters)
    }
}
