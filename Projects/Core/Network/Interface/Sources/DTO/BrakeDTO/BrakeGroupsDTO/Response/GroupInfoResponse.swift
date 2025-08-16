//
//  GroupsResponse.swift
//  CoreNetworkInterface
//
//  Created by Greem on 8/16/25.
//

import Foundation

public struct GroupInfoResponse: Decodable {
    public let groupId: Int
    public let name: String
    public let groupApps: Data
}
