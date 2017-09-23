//
//  StdServer.swift
//  server
//
//  Created by Bernardo Breder on 30/10/16.
//  Copyright © 2016 Bernardo Breder. All rights reserved.
//

import Foundation
import Dispatch

#if SWIFT_PACKAGE
    import Server
    import StdSocket
#endif

open class StdServer: Server {
    
    public let config: StdSocketConfig
    
    internal let fd: Int32
    
    public internal(set) var closed: Bool = false
    
    public init(config: StdSocketConfig) throws {
        self.config = config
        self.fd = try StdSocket.socket(port: config.port, queueSize: config.queueSize)
    }
    
    open func accept(timeout: Int?) throws -> Client {
        try StdSocket.wait(fd, timeout: timeout)
        return StdClientServer(fd: try StdSocket.socketAccept(fd))
    }
    
    open func close() {
        if !closed {
            closed = true
            StdSocket.socketClose(fd)
        }
    }
    
}
