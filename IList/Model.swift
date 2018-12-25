//
//  Model.swift
//  IList
//
//  Created by HengQiang Cao on 12/1/18.
//  Copyright © 2018 HengQiang Cao. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: String
    var title: String
    var detail: String
    var date:Date
    var status:String
}
