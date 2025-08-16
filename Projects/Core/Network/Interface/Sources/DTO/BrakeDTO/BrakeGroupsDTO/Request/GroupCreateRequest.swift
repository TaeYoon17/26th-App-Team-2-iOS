//
//  GroupCreateRequest.swift
//  CoreNetworkInterface
//
//  Created by Greem on 8/16/25.
//


import Foundation

public struct GroupCreateRequest: Encodable {
    public let name: String
    public let groupApps: Data
    
    public init(
        name: String,
        groupApps: Data
    ) {
        self.name = name
        self.groupApps = groupApps
    }
}


