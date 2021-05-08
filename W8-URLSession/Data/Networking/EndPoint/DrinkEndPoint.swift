////
////  DrinkEndPoint.swift
////  W8-URLSession
////
////  Created by Văn Khánh Vương on 07/05/2021.
////
//
//import Foundation
//
//enum NetworkEnvironment {
//    case production
//}
//
//public enum DrinkApi {
//    case recommended(text: String)
//}
//
//extension DrinkApi: EndPointType {
//
//    var environmentBaseURL : String {
//        switch NetworkManager.environment {
//        case .production: return "https://www.thecocktaildb.com/api/json/v1/1"
//        }
//    }
//
//    var baseURL: URL {
//        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
//        return url
//    }
//
//    var path: String {
//        //switch self {
//                //case .recommended(let text):
//                    //return ""
//                //}
//    }
//
//    var httpMethod: HTTPMethod {
//        return .get
//    }
//
//    var task: HTTPTask {
//        //switch self {
//        //case .recommended(text: let text):
//            //return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["s":"",
//                                                                           //"":""])
//            //return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters:
//        //default:
//            return .request
//        }
//    }
//
//    var headers: HTTPHeaders? {
//        return nil
//    }
//}
