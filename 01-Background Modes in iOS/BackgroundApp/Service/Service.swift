//
//  Service.swift
//  BackgroundApp
//
//  Created by AikOganisyan on 26/11/2019.
//  Copyright © 2019 icos. All rights reserved.
//

import Foundation

struct SomeModel {
    var name = ""
}

enum Result {
    case succes(SomeModel)
    case noNewData
    case error
}

class Service {
    static let shared = Service()
    private init() { }
    
    var model = SomeModel()
    
    func fetchData(completion: (Result) -> ()) {
        //load data from you server
        let loadedModel = SomeModel(name: "New loaded model name")
        let result = Result.succes(loadedModel) //also result may have no data
        
        completion(result)
    }
}
