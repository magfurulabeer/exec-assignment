//
//  Provider.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/4/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import Foundation
import Moya
import KeychainAccess

// MARK: - Target
enum ExecOnlineAPI {
  // MARK: - Tokens
  case requestToken(email: String, password: String)
  
  // MARK: - User
  case getUser(userToken: String)
  case getUserCourses(userToken: String)
  
  // MARK: - Courses
  case getCourse(id: Int)
  case getCourseLectureSegments(courseId: String, id: String)
}

// MARK: - TargetType Protocol Implementation
extension ExecOnlineAPI: TargetType {
  var baseURL: URL {
    guard let urlString = ProcessInfo.processInfo.environment[Constants.Params.baseUrl] else {
      fatalError("Invalid Base Url for API!")
    }
    return URL(string: urlString)!
  }
  
  var path: String {
    switch self {
    case .requestToken:
      return "/v1/tokens"
    case .getUser:
      return "/v1/user"
    case .getUserCourses:
      return "/v1/user/courses"
    case .getCourse(let id):
      return "/v1/courses/\(id)"
    case .getCourseLectureSegments(let ids):
      return "v1/courses/\(ids.courseId)/lecture_segments/\(ids.id)"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .getUser, .getUserCourses, .getCourse, .getCourseLectureSegments:
      return .get
    case .requestToken:
      return .post
    }
  }
  
  // Obsolete. Use task?
  var parameters: [String : Any]? {
    switch self {

    default:
      return nil
    }
  }
  
  var parameterEncoding: ParameterEncoding {
    return JSONEncoding.default
  }
  
  var task: Task {
    switch self {
//    case .getCourse(let id):
//      return Task.requestParameters(parameters: ["id": id], encoding: URLEncoding.)
    default:
      return Task.requestPlain
    }
  }
  
  var sampleData: Data {
    switch self {
    default:
      return "Moya sampleData not implemented".utf8Encoded
    }
  }
  
  // TODO: DRY this out
  var headers: [String: String]? {
    let keychain = Keychain(service: Bundle.main.bundleIdentifier!)
    let token = keychain[Constants.Params.userToken] ?? "NULL"
    
    switch self {
    case .requestToken(let credentials):
      return ["Content-type": "application/json",
              "Accept": "application/json",
              Constants.Params.partnerToken: Constants.Keys.apiPartnerToken,
              Constants.Params.userEmail: credentials.email,
              Constants.Params.userPassword: credentials.password
      ]
    case .getUser(let userToken), .getUserCourses(let userToken):
      return ["Content-type": "application/json",
              "Accept": "application/json",
              Constants.Params.partnerToken: Constants.Keys.apiPartnerToken,
              Constants.Params.userToken: userToken
      ]
    case .getCourse(_):
      return ["Content-type": "application/json",
              "Accept": "application/json",
              Constants.Params.partnerToken: Constants.Keys.apiPartnerToken,
              Constants.Params.userToken: token
      ]
    default:
      return ["Content-type": "application/json",
              "Accept": "application/json",
              Constants.Params.partnerToken: Constants.Keys.apiPartnerToken
      ]
    }
  }
}

// MARK: - Helpers
private extension String {
  var urlEscaped: String {
    return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }
  
  var utf8Encoded: Data {
    return data(using: .utf8)!
  }
}
