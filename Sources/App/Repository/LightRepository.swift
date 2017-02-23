//
//  LightRepository.swift
//  LazyServer
//
//  Created by Matthew Vern on 2017/02/21.
//
//

import Foundation

protocol LightRepository {
    
    func getLight(id: Int) -> Light?
    
    func getLights(by location: String) -> [Light]?
    
    func storeLight(light: Light)
    
    func deleteLight(id: Int)
}
