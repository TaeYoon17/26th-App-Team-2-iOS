//
//  GroupsEndPoint.swift
//  CoreNetworkInterface
//
//  Created by Greem on 8/16/25.
//

import Foundation

public extension BrakeRouter {
    enum GroupsEndPoint<Response: Decodable> : HTTPNetworkProtocol {
        
        public typealias Item = Response
        case getGroups
        case create(GroupCreateRequest)
        case delete(groupID: Int)
        case update(groupID: Int, GroupUpdateRequest)
        
        public var path: String {
            switch self {
            case .getGroups, .create: "/groups/ios"
            case .update(let groupID, _): "groups/ios/\(groupID)"
            case .delete(let groupID): "/groups/\(groupID)"
            }
        }
        
        public var httpMethod: HTTPMethod {
            switch self {
            case .create: return .post
            case .delete: return .delete
            case .getGroups: return .get
            case .update: return .put
            }
        }
        
        public var queryParameters: Encodable? {
            switch self {
            case .getGroups: nil
            case .create: nil
            case .delete: nil
            case .update: nil
            }
        }
        
        public var bodyParameters: Encodable? {
            switch self {
            case .create(let createRequest): return createRequest
            case .delete: return nil
            case .getGroups: return nil
            case .update: return  nil
            }
        }
        
        public var headers: [String : String]? {
            let defaultHeader = ["Content-Type": "application/json"]
            switch self {
            default: return defaultHeader
            }
        }
    }
}
