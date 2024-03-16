//
//  HttpRequest.swift
//  soda-music-swiftui
//
//  Created by 苏粤翔 on 2024/3/16.
//

import Foundation

let baseUrl = "http://localhost:8080"

enum Module {
    case auth
    case user
    case music
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum AuthAPI {
    case getVerificationCode
    case login
    case register

    var method: HTTPMethod {
        switch self {
        case .getVerificationCode:
            return .get
        case .login:
            return .post
        case .register:
            return .post
        }
    }
}

enum UserAPI {
    case getVerificationCode
    case login
    case register

    var method: HTTPMethod {
        switch self {
        case .getVerificationCode:
            return .get
        case .login:
            return .post
        case .register:
            return .post
        }
    }
}

enum MusicAPI {
    case getVerificationCode
    case login
    case register

    var method: HTTPMethod {
        switch self {
        case .getVerificationCode:
            return .get
        case .login:
            return .post
        case .register:
            return .post
        }
    }
}

class NetworkManager {
    static let shared = NetworkManager()

    private let baseURL = baseUrl

    func request(module: Module, api: Any, parameters: [String: Any]?, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var path = ""
        var method: HTTPMethod = .get

        switch module {
        case .auth:
            path = "/auth"
            if let api = api as? AuthAPI {
                path += getPathForAuthAPI(api)
                method = api.method
            }
        case .user:
            path = "user/"
            if let api = api as? AuthAPI {
                path += getPathForAuthAPI(api)
                method = api.method
            }
        case .music:
            path = "music/"
            if let api = api as? AuthAPI {
                path += getPathForAuthAPI(api)
                method = api.method
            }
        }

        // Check if parameters exist and if it's a GET request
        if let parameters = parameters, method == .get {
            for (_, value) in parameters {
                path += "/\(value)"
            }
        }

        var urlComponents = URLComponents(string: baseURL + path)

        if let url = urlComponents?.url {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue

            if method == .post, let parameters = parameters {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                } catch {
                    completion(nil, nil, error)
                    return
                }
            }

            print("准备发送请求了\(request)")
            URLSession.shared.dataTask(with: request) { data, response, error in
                completion(data, response, error)
            }.resume()
        }
    }

    private func getPathForAuthAPI(_ api: AuthAPI) -> String {
        switch api {
        case .getVerificationCode:
            return "/sms-code"
        case .login:
            return "login"
        case .register:
            return "register"
        }
    }
}
