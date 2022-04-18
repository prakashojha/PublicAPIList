//
//  PublicAPIListPresentorTests.swift
//  PublicAPIListTests
//
//  Created by Saumya Prakash on 14/04/22.
//

import XCTest
@testable import PublicAPIList

class PublicAPIListPresentorTests: XCTestCase {
    
    var presentor: (PresentorProtocol & TableViewModelProtocol)?
    var apiList: [APIDetail] = []
    
    override func setUpWithError() throws {
        presentor = PublicAPIListPresentor()
        
        apiList =   [APIDetail(api: "OGC", description: "None", auth: "APC", https: true, cors: "cors", link: "https//", category: "Animal"),APIDetail(api: "OGC", description: "None", auth: "APC", https: true, cors: "cors", link: "https//", category: "Animal"),APIDetail(api: "OGC", description: "None", auth: "APC", https: true, cors: "cors", link: "https//", category: "Development"),APIDetail(api: "OGC", description: "None", auth: "APC", https: true, cors: "cors", link: "https//", category: "Crypto"),APIDetail(api: "OGC", description: "None", auth: "APC", https: true, cors: "cors", link: "https//", category: "Animal")]
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_didLoadTableEntries(){
        
        presentor?.didLoadTableEntries(data: apiList)
        XCTAssertEqual(5, presentor?.numberOfRowsInSection)
        
    }
    
    
    func test_removeAtIndexPath(){
        presentor?.didLoadTableEntries(data: apiList)
        presentor?.remove(at: 0)
        XCTAssertEqual(4, presentor?.numberOfRowsInSection)
        
    }
    
    
    func test_inseetItemAtindexPath(){
        let item = APIDetail(api: "OGC", description: "None", auth: "APC", https: true, cors: "cors", link: "https//", category: "Animal")
        presentor?.didLoadTableEntries(data: apiList)
        presentor?.insert(item: item, at: 1)
        XCTAssertEqual(6, presentor?.numberOfRowsInSection)
    }
    
    
    
    func test_updateSearchResults_searchText(){
        presentor?.didLoadTableEntries(data: apiList)
        presentor?.updateSearchResults(searchText: "Animal")
        XCTAssertEqual(3, presentor?.numberOfRowsInSection)
    }
    
    
    
    func test_sort_ascending(){
        presentor?.didLoadTableEntries(data: apiList)
        presentor?.sort()
        
        XCTAssertEqual("Animal", presentor?.cellForRow(at: 0)?.category)
        XCTAssertEqual("Animal", presentor?.cellForRow(at: 1)?.category)
        XCTAssertEqual("Animal", presentor?.cellForRow(at: 2)?.category)
        
        
    }
    
    func test_sort_descending(){
        presentor?.didLoadTableEntries(data: apiList)
        presentor?.sort()
        
        presentor?.sort()
        XCTAssertEqual("Animal", presentor?.cellForRow(at: 2)?.category)
        XCTAssertEqual("Animal", presentor?.cellForRow(at: 3)?.category)
        XCTAssertEqual("Animal", presentor?.cellForRow(at: 4)?.category)
        
    }
    
    func test_numberOfRowsInSection(){
        presentor?.didLoadTableEntries(data: apiList)
        XCTAssertEqual(5, presentor?.numberOfRowsInSection)
    }
    
    func test_cellForRowAtindexPath(){
        presentor?.didLoadTableEntries(data: apiList)
        let item = presentor?.cellForRow(at: 0)
        XCTAssertEqual("Animal", item?.category)
    }
    
    
}
