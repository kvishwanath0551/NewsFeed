//
//  RowsViewModel.swift
//  NewsFeed
//
//  Created by Vishwanath on 11/08/21.
//
import Foundation

class RowsViewModel {
    
//    MARK:- Objects & Variables
    var articelArray = [Articles]()
    weak var vc : ViewController!
    
//    MARK:- Get API Calls
    
    /// Get Facts API Call
    func getRowsInfoFromAPI() {
        
        Network.getApiCallWithRequestString(requestString: URLConstants.factsURL) { (response) in
            
            switch response {
            case .failure(let error):
                
                if let urlError = error as? URLError{
                    switch urlError {
                    case .dataNotFound:     print("Data not found")
                    case .unformatedURL:    print("Unformated url")
                    }
                } else {
                    print("Error:- \(error)")
                }
            
            case .success(let responseData):
                
                do {
                    let str = String(decoding: responseData, as: UTF8.self)
                    if let data = str.data(using: .utf8) {
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(Feed.self, from: data)
                        if let rows = responseModel.articles {
                            self.articelArray = rows
                        }
                        DispatchQueue.main.async {
                            self.vc.rowsTableView.reloadData()
                        }
                    }
                }
                
                catch(let error) {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
