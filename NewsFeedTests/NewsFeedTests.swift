//
//  NewsFeedTests.swift
//  NewsFeedTests
//
//  Created by Vishwanath on 11/08/21.
//

import XCTest
@testable import NewsFeed

class NewsFeedTests: XCTestCase {

    var urlSession: URLSession!
override func setUp() {
  
    urlSession = URLSession(configuration: .default)
}

override func tearDown() {
  
    urlSession = nil
}

func testValidCallToGetsHTTPStatusCode200() {
      let url = URL(string: URLConstants.factsURL)
      let promise = expectation(description: "Status code: 200")
      let dataTask = urlSession.dataTask(with: url!) { data, response, error in
          if let error = error {
              XCTFail("Error: \(error.localizedDescription)")
              return
          } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
              if statusCode == 200 {
              promise.fulfill()
                  
              } else {
                  XCTFail("Status code: \(statusCode)")
              }
          }
      }
      dataTask.resume()
      wait(for: [promise], timeout: 5)
  }
}
