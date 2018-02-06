//
//  Constants.swift
//  Assignment
//
//  Created by Magfurul Abeer on 2/4/18.
//  Copyright © 2018 ExecOnline. All rights reserved.
//

import UIKit

// Put into env variable

struct Constants {
  struct Keys {
    static let apiPartnerToken = ProcessInfo.processInfo.environment[Params.partnerToken] ?? "NULL"
  }
  
  struct Params {
    static let partnerToken = "X-Partner-Token"
    static let userToken = "X-User-Token"
    static let userEmail = "X-User-Email"
    static let userPassword = "X-User-Password"
    static let baseUrl = "X-Base-Url"
  }
  
  struct Colors {
    static let red = UIColor.rgb(219,55,50)
    static let darkRed = UIColor.rgb(164,49,51)
  }
}
