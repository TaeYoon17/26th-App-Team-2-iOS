//
//  GroupsResponse.swift
//  CoreNetworkInterface
//
//  Created by Greem on 8/16/25.
//

import Foundation

public struct GroupInfoResponse: Decodable {
    let groupId: Int
    let name: String
    let groupApps: Data
}
