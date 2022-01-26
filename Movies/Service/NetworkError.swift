//
//  NetworkError.swift
//  Movies
//
//  Created by Ty Pham on 19/01/2022.
//

import Foundation
import Alamofire

struct NetworkError: Error {
  let error: AFError
  let systemError: SystemError?
}

struct SystemError: Codable, Error {
    var status: String
    var errorMessage: String
}
