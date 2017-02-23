//
//  LightController.swift
//  LazyServer
//
//  Created by Matthew Vern on 2017/02/21.
//
//

import Foundation
import Vapor
import HTTP

class LightController: ResourceRepresentable {

    func index(request: Request) throws -> ResponseRepresentable {

        if let location = request.query?["location"]?.string {
          return try Light.query().filter("location", location).all().makeNode().converted(to: JSON.self)
        }
        return try Light.all().makeNode().converted(to: JSON.self)
    }

    func create(request: Request) throws -> ResponseRepresentable {
        var light = try request.light()
        try light.save()
        return light
    }

    func show(request: Request, light: Light) throws -> ResponseRepresentable {
        return light
    }

    func delete(request: Request, light: Light) throws -> ResponseRepresentable {
        try light.delete()
        return light
    }

    func clear(request: Request) throws -> ResponseRepresentable {
        // don't let users delete everything
        throw Abort.badRequest
        // try Light.query().delete()
        // return JSON([])
    }

    func update(request: Request, light: Light) throws -> ResponseRepresentable {
        var light = light
        light.location = request.data["location"]?.string ?? light.location
        light.status = request.data["status"]?.bool ?? light.status
        try light.save()
        return light
    }

    func replace(request: Request, light: Light) throws -> ResponseRepresentable {
        try light.delete()
        return try create(request: request)
    }


    func makeResource() -> Resource<Light> {
        return Resource(index: index,
                        store: create,
                        show: show,
                        replace: replace,
                        modify: update,
                        destroy: delete,
                        clear: clear)
    }
}

extension Request {
    func light() throws -> Light {
        guard let json = json else { throw Abort.badRequest }
        return try Light(node: json)
    }
}
