//
//  UserInteractor.swift
//  BFY
//
//  Created by Анастасия Московчук on 10.12.2021.
//

//import Foundation
//
//struct UserSignin: Encodable {
//   let email: String
//   let password: String
//}
//
//struct UserSignup: Encodable {
//   let nickname: String
//   let email: String
//   let password: String
//   let repeated_password: String
//}
//
//struct UserName: Encodable {
//   let nickname: String
//   let email: String
//}
//
//struct UserPassword: Encodable {
//   let new_password: String
//   let old_password: String
//   let repeated_new_password: String
//}
//
//final class UserInteractor: BaseInteractor {
//    
//    struct UserResponse: Decodable {
//        let user: APIUser
//    }
//    
//    private func changeData<T>(user: T, method: String, success: @escaping (APIResponse<UserResponse>) -> Void, failure: @escaping (Error) -> Void) where T: Encodable {
//        
//        guard let data = try? encoder.encode(user) else {
//            failure(InteractorError.invalidEncode)
//            return
//        }
//        let request = HermesRequest(
//            method: .put,
//            path: method,
//            body: data,
//            headers: ["X-Csrf-Token" : CSRFStorage.shared.token ?? ""]
//        )
//        request.successHandler = { response in
//            guard let data = response.data.decode(type: APIResponse<UserResponse>.self) else {
//                failure(InteractorError.emptyData)
//                return
//            }
//            success(data)
//        }
//        request.errorHandler = { error in
//            failure(error)
//        }
//        client.run(with: request)
//    }
//    
//    func changeName(data: UserName, success: @escaping (APIResponse<UserResponse>) -> Void, failure: @escaping (Error) -> Void) {
//        changeData(user: data, method: "/user/profile", success: success, failure: failure)
//    }
//    
//    func changePassword(data: UserPassword, success: @escaping (APIResponse<UserResponse>) -> Void, failure: @escaping (Error) -> Void) {
//        changeData(user: data, method: "/user/password", success: success, failure: failure)
//    }
//    
//    func signup(user: UserSignup, success: @escaping (APIResponse<UserResponse>) -> Void, failure: @escaping (Error) -> Void) {
//        sign(user: user, method: "/user/register", success: success, failure: failure)
//    }
//
//    
//    func signin(user: UserSignin, success: @escaping (APIResponse<UserResponse>) -> Void, failure: @escaping (Error) -> Void) {
//        sign(user: user, method: "/session", success: success, failure: failure)
//    }
//    
//    private func sign<T>(user: T, method: String, success: @escaping (APIResponse<UserResponse>) -> Void, failure: @escaping (Error) -> Void) where T: Encodable {
//        guard let data = try? encoder.encode(user) else {
//            failure(InteractorError.invalidEncode)
//            return
//        }
//        let request = HermesRequest(method: .post, path: method, body: data)
//        request.successHandler = { response in
//            guard let data = response.data.decode(type: APIResponse<UserResponse>.self) else {
//                failure(InteractorError.emptyData)
//                return
//            }
//            if let token = response.headers["x-csrf-token"] as? String {
//                CSRFStorage.shared.token = token
//            }
//            success(data)
//        }
//        request.errorHandler = { error in
//            failure(error)
//        }
//        client.run(with: request)
//    }
//    
//    func profile(success: @escaping (APIResponse<UserResponse>) -> Void, failure: @escaping (Error) -> Void) {
//        let request = HermesRequest(method: .get, path: "/user/profile")
//        request.successHandler = { response in
//            guard let data = response.data.decode(type: APIResponse<UserResponse>.self) else {
//                failure(InteractorError.emptyData)
//                return
//            }
//            success(data)
//        }
//        request.errorHandler = { error in
//            failure(error)
//        }
//        client.run(with: request)
//    }
//}
