//
//  HomeViewModel.swift
//  PharmEasy_Assgn
//
//  Created by Ashutosh Lasod on 08/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import UIKit

fileprivate let DATA_PER_PAGE : Int = 3

class HomeViewModel: NSObject {
    
    var results : ServiceModel?
    var datasource : [DataModel] = [DataModel]()
    
    func fetchAndStoreDataFromResults(){
        if let dataArr = results?.data{
            datasource.append(contentsOf: dataArr)
        }
    }
    
    func getCountLabelText(forFirstRow firstRow : Int) -> String{
        return "Page \(Int(floor(Double(firstRow/DATA_PER_PAGE))) + 1) of \(self.results?.totalPages ?? 0)"
    }

}

//MARK: GET ONLY
extension HomeViewModel{
    
    var numberOfRows : Int {
        get { return datasource.count}
    }
    
    var heightForHeader : CGFloat {
        get { return 30.0 }
    }
    
}

//MARK: NETWORK RELATED
extension HomeViewModel{
    
    func hitServiceToFetchData(forPageNo pageNo : Int, withCompletionHandler completion: @escaping (_ success : Bool)->()){
        let urlString = UrlConstant.getBaseURL(forPage: pageNo, andDataPerPage: DATA_PER_PAGE)
        SessionServiceManager.sharedSessionServiceManger.sendRequest(forUrl: urlString, dataToSend: nil, cookies: false, requestType: "GET", contentType: .eRequestJsonType, withCompletionHandler: { [weak self] (data) in
            Loader.shared.stopLoader()
            do{
                self?.results = try JSONDecoder().decode(ServiceModel.self, from: data!)
                self?.fetchAndStoreDataFromResults()
                completion(true)
            }catch{
               completion(false)
            }
        }) { (error) in
           completion(false)
        }
    }
    
}
