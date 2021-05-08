//
//  EndPointType.swift
//  W8-URLSession
//
//  Created by Văn Khánh Vương on 06/05/2021.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
