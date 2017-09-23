//
//  StdClientServer.swift
//  server
//
//  Created by Bernardo Breder on 30/10/16.
//  Copyright © 2016 Bernardo Breder. All rights reserved.
//

import Foundation

#if SWIFT_PACKAGE
    import Server
    import StdSocket
    import DataStream
#endif

open class StdClientServer: Client {
    
    public private(set) var stdFd: Int32
    
    public private(set) var closed: Bool = false
    
    public var timeout: Int = 60
    
    internal let inStream: DataInStream
    
    public init(fd: Int32) {
        self.stdFd = fd
        let timeout = 60
        self.timeout = timeout
        self.inStream = DataInStream(reader: {try StdSocket.receive(fd, count: min(1024, try StdSocket.waitAvaliable(fd, timeout: timeout)))})
    }
    
    public func read() throws -> UInt8 {
        return try inStream.read()
    }
    
    public func write(data: Data) throws {
        try StdSocket.send(stdFd, data: data)
    }
    
    public func close() {
        if !closed {
            closed = true
            StdSocket.socketClose(stdFd)
        }
    }
    
}
