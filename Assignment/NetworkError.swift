//
//  NetworkError.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/5/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import Foundation

enum NetworkError: Error {
  case noInternetConnection
  case custom(String)
  case other
}

extension NetworkError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .noInternetConnection:
      return "No Internet Connection"
    case .custom(let message):
      return message
    default:
      return "Something went wrong"
    }
  }
}

