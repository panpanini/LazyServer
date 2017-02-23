//
//  ArrayLightRepository.swift
//  LazyServer
//
//  Created by Matthew Vern on 2017/02/21.
//
//

import Foundation

class ArrayLightRepository: LightRepository {
    
    var database = Dictionary<Int, Light>()
    
    func getLight(id: Int) -> Light? {
        guard let light = database[id] else {
            return nil
        }
        
        return light
    }
    
    func getLights(by location: String) -> [Light]? {
        return nil
    }
    
    func storeLight(light: Light) {
        
    }
    
    func deleteLight(id: Int) {
        
    }
    
}
