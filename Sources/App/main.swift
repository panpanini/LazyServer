import Vapor
import VaporPostgreSQL

let drop = Droplet(preparations: [Light.self],
    providers: [VaporPostgreSQL.Provider.self])



drop.resource("lights", LightController())



drop.run()
