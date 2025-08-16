//
//  AppGroupService.swift
//  DomainShared
//
//  Created by Greem on 7/28/25.
//

import Foundation
import FamilyControls
import Core

public protocol AppGroupProtocol {
    func getAppGroup() async throws -> AppGroup?
    func updateAppGroup(appGroup: AppGroup) async throws
    func createAppGroup(
        groupName: String,
        activitySelection: FamilyActivitySelection
    ) async throws -> AppGroup
    func deleteAppGroup(groupID: Int) async throws
    func deleteAllAppGroup() async throws
}

enum AppGroupServiceError: Error {
    case storageNotExist
}

public final class AppGroupService: AppGroupProtocol {
    
    private let appGroupStorage: AppGroupStorageProtocol?
    private let networkProvider = NetworkProvider(
        networkSession: NetworkSession(
            requestInterceptor: TokenInterceptor(tokenStorage: KeyChainTokenStorage()),
            urlSession: .shared
        ),
        urlComponentConfig: .default
    )
    
    public init(
        appGroupStorage: AppGroupStorageProtocol?
    ) {
        self.appGroupStorage = appGroupStorage
    }
    
    public func createAppGroup(
        groupName: String,
        activitySelection: FamilyActivitySelection
    ) async throws -> AppGroup {
        
        guard let appGroupStorage else {
            throw AppGroupServiceError.storageNotExist
        }
        
        let groupAppData = try JSONEncoder().encode(activitySelection)
        let createGroupRequest = GroupCreateRequest(name: groupName, groupApps: groupAppData)
        let endPoint = BrakeRouter.GroupsEndPoint<BrakeResponse<GroupInfoResponse>>.create(createGroupRequest)
        
        let createGroupResponse: BrakeResponse<GroupInfoResponse> = try await networkProvider.request(endPoint)
        
        let appGroup = AppGroup(
            name: createGroupResponse.data.name,
            groupID: createGroupResponse.data.groupId,
            selection: activitySelection
        )
        
//        let appGroupEntity = try AppGroupEntity(appGroup: appGroup)
//        try await appGroupStorage.appendAppGroupEntity(appGroupEntity)
        
        return appGroup
    }
    
    public func updateAppGroup(appGroup: AppGroup) async throws {
        guard let appGroupStorage else {
            throw AppGroupServiceError.storageNotExist
        }
        
        let groupAppData = try JSONEncoder().encode(appGroup.selection)
        
        let updateGroupRequest = GroupUpdateRequest(
            name: appGroup.name,
            groupApps: groupAppData
        )
        
        let endPoint = BrakeRouter.GroupsEndPoint<BrakeResponse<GroupInfoResponse>>.update(
            groupID: appGroup.groupID,
            updateGroupRequest
        )
        
        let updateResponse: BrakeResponse<GroupInfoResponse> = try await networkProvider.request(endPoint)
        
        
//        let appGroupEntity = try AppGroupEntity(appGroup: appGroup)
//        try await appGroupStorage.updateAppGroupEntity(appGroupEntity)
    }
    
    public func getAppGroup() async throws -> AppGroup? {
        guard let appGroupStorage else {
            throw AppGroupServiceError.storageNotExist
        }
        
        let endPoint = BrakeRouter.GroupsEndPoint<BrakeResponse<[GroupInfoResponse]>>.getGroups
        let getAppGroupsResponse: BrakeResponse<[GroupInfoResponse]> = try await networkProvider.request(endPoint)
        
        let appGroups = try getAppGroupsResponse.data.map { groupInfoResponse in
            let selection = try JSONDecoder().decode(FamilyActivitySelection.self, from: groupInfoResponse.groupApps)
            return AppGroup(
                name: groupInfoResponse.name,
                groupID: groupInfoResponse.groupId,
                selection: selection
            )
        }
        
        print(appGroups)
        
        return appGroups.first
        
//        let appGroupEntities = try await appGroupStorage.getAllAppGroupEntities()
//        guard let appGroupEntity = appGroupEntities.first else {
//            return nil
//        }
//        return try appGroupEntity.toAppGroup()
    }
    
    public func deleteAppGroup(groupID: Int) async throws {
        guard let appGroupStorage else {
            throw AppGroupServiceError.storageNotExist
        }
        let endPoint = BrakeRouter.GroupsEndPoint<EmptyData>.delete(groupID: groupID)
        
        
        
        try await appGroupStorage.deleteAppGroupEntity(groupID: groupID)
    }
    
    public func deleteAllAppGroup() async throws {
        guard let appGroupStorage else {
            throw AppGroupServiceError.storageNotExist
        }
        try await appGroupStorage.deleteAllAppGroupEntities()
    }
}
