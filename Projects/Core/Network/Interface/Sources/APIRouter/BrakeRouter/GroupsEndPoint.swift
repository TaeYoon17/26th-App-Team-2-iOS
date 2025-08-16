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
        case delete(GroupDeleteRequest)
        case update(GroupUpdateRequest)
        
        public var path: String {
            switch self {
            case .getGroups, .create: "/groups/ios"
            case .update(let updateRequest): "groups/ios/\(updateRequest.groupID)"
            case .delete(let deleteRequest): "/groups/\(deleteRequest.groupID)"
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
        
        public var queryParameters:  Encodable? {
            switch self {
            case .getGroups: nil
            case .create: nil
            case .delete: nil
            case .update: nil
            }
        }
        
        public var bodyParameters: Encodable? {
            switch self {
            case .create: nil
            case .delete: nil
            case .getGroups: nil
            case .update: nil
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
