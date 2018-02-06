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
}


