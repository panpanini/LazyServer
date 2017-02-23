//
//  Light.swift
//  LazyServer
//
//  Created by Matthew Vern on 2017/02/21.
//
//

import Vapor
import Fluent
import Foundation

final class Light: Model {

    var id: Node?
    var location: String
    var status: Bool

    // this is required by Fluent
    var exists: Bool = false

    init(location: String, status: Bool = false) {
        id = UUID().uuidString.makeNode()
        self.location = location
        self.status = status
    }

    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        location = try node.extract("location")
        status = try node.extract("status")
    }

    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "location": location,
            "status": status
            ])
    }


    class func from(json: Dictionary<String, Any>) throws -> Light {
        guard let location = json["location"] as? String, let status = json["status"] as? Bool else {
            throw Abort.badRequest
        }

        return Light(location: location, status: status)
    }

}

extension Light: Preparation {
    static func prepare(_ database: Database) throws {
      try database.create("lights") { lights in
          lights.id()
          lights.string("location")
          lights.bool("status")

      }
    }

    static func revert(_ database: Database) throws {
        // database.drop_table("lights")
    }
}
