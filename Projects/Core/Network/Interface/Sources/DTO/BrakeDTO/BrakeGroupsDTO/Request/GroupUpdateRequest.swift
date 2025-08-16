//
//  GroupUpdateRequest.swift
//  CoreNetworkInterface
//
//  Created by Greem on 8/16/25.
//

import Foundation

public struct GroupUpdateRequest: Encodable {
    public let groupID: String
    
    public init(groupID: String) {
        self.groupID = groupID
    }
    
}


