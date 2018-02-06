//
//  NetworkService.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/5/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import Foundation
import Moya
import KeychainAccess
import RealmSwift
import then
import ObjectMapper

typealias JSON = [String: Any]

class NetworkService {
  var client: MoyaProvider<ExecOnlineAPI>
  var keychain: Keychain
//  var realm: Realm
  
  init(client: MoyaProvider<ExecOnlineAPI> = MoyaProvider<ExecOnlineAPI>(plugins: [moyaPlugin]),
       keychain: Keychain = Keychain(service: Bundle.main.bundleIdentifier!)) {
//       realm: Realm = try! Realm()) {
    self.client = client
    self.keychain = keychain
//    self.realm = realm
  }
    
  func request(target: ExecOnlineAPI) -> Promise<JSON> {
    return Promise { [weak self] resolve, reject in
      guard let this = self else { fatalError() }

      this.client.request(target, completion: { result in
        switch result {
        case .success(let response):
          do {
            guard let json = try response.mapJSON() as? JSON else {
              reject(NetworkError.custom("Could not parse JSON"))
              return
            }

            resolve(json)
          } catch let error {
            reject(error)
          }
          
        case .failure(let error):
          reject(error)
        }
      })
    }
  }
  
  func requestThenSelect<T>(target: ExecOnlineAPI, path: String) -> Promise<T> {
    return Promise { [weak self] resolve, reject in
      guard let this = self else { fatalError() }
      
      this.client.request(target, completion: { result in
        switch result {
        case .success(let response):
          do {
            guard let json = try response.mapJSON() as? JSON, let selection = json[path] as? T else {
              reject(NetworkError.custom("Could not parse JSON"))
              return
            }
            
            resolve(selection)
          } catch let error {
            reject(error)
          }
          
        case .failure(let error):
          reject(error)
        }
      })
    }
  }
  
  func requestThenMap<T>(target: ExecOnlineAPI) -> Promise<T> where T: Mappable {
    return Promise { [weak self] resolve, reject in
      guard let this = self else { fatalError() }
      
      this.client.request(target, completion: { result in
        switch result {
        case .success(let response):
          do {
            guard let json = try response.mapJSON() as? JSON, let object: T = Mapper<T>().map(JSON: json)  else {
              reject(NetworkError.custom("Could not parse JSON"))
              return
            }
            
            resolve(object)
          } catch let error {
            reject(error)
          }
          
        case .failure(let error):
          reject(error)
        }
      })
    }
  }
  
  func requestArray(target: ExecOnlineAPI) -> Promise<[JSON]> {
    return Promise { [weak self] resolve, reject in
      guard let this = self else { fatalError() }
      
      this.client.request(target, completion: { result in
        switch result {
        case .success(let response):
          do {
            guard let json = try response.mapJSON() as? [JSON] else {
              reject(NetworkError.custom("Could not parse JSON"))
              return
            }
            
            resolve(json)
          } catch let error {
            reject(error)
          }
          
        case .failure(let error):
          reject(error)
        }
      })
    }
  }
}


