//
//  GroupDeleteRequest.swift
//  CoreNetworkInterface
//
//  Created by Greem on 8/16/25.
//

import Foundation

public struct GroupDeleteRequest: Encodable {
    public let groupID: String
    
    public init(groupID: String) {
        self.groupID = groupID
    }
}
