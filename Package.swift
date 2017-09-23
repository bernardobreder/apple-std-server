//
//  Package.swift
//  StdServer
//
//

import PackageDescription

let package = Package(
	name: "StdServer",
	targets: [
		Target(name: "StdServer", dependencies: ["DataBuffer", "DataStream", "Server", "StdSocket"]),
		Target(name: "DataBuffer", dependencies: []),
		Target(name: "DataStream", dependencies: []),
		Target(name: "Server", dependencies: []),
		Target(name: "StdSocket", dependencies: []),
	]
)

