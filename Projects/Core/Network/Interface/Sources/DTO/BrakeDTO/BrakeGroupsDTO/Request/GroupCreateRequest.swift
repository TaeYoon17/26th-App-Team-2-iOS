//
//  GroupCreateRequest.swift
//  CoreNetworkInterface
//
//  Created by Greem on 8/16/25.
//


import Foundation

public struct GroupCreateRequest: Encodable {
    public let name: String
    public let groupApps: String
    
    public init(
        name: String,
        groupApps: String
    ) {
        self.name = name
        self.groupApps = groupApps
    }
}


