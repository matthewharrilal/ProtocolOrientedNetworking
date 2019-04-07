//
//  EndpointType.swift
//  ProtocolOrientedNetworking
//
//  Created by Matthew Harrilal on 4/7/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

protocol EndpointType {
    var baseUrl: URL {get}
    var path: String {get}
    var httpMethod: String {get}
    var task: HTTPTask {get}
}


