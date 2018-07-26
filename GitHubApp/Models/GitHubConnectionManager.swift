//
//  GitHubConnectionManager.swift
//  GitHubApp
//
//  Created by Vladyslav Filipov on 25.07.2018.
//  Copyright © 2018 Vladislav Filipov. All rights reserved.
//

import UIKit
import Alamofire
import SafariServices

class GitHubConnectionManager {
    
    static private var safariAuthenticator: Any? = nil
    
    static var authURL = "https://github.com/login/oauth/authorize"
    static var redirectURL = "GitHubApp://response"
    static var tokenURL = "https://github.com/login/oauth/access_token"
    static var clientID = "53ad93d75566f2be8721"
    static var clientSecret = "f6793aa0ec3a7c0badee13d8a9c3aeb8269e306d"

    static var link: String {
        return "\(authURL)?client_id=\(clientID)&redirect_uri=\(redirectURL)"
    }
    
    static func handle(redirectURL: URL, completion: @escaping (OAuth2Token) -> Void) {
        if #available(iOS 11.0, *) { } else {
            if let svc = self.safariAuthenticator as? SFSafariViewController {
                svc.dismiss(animated: true, completion: nil)
                self.safariAuthenticator = nil
            }
        }
        if GitHubConnectionManager.redirectURL.isEmpty {
            print("Redirect URL is empty")
            return
        }
        let components = URLComponents(url: redirectURL, resolvingAgainstBaseURL: true)
        if let queryItems = components?.queryItems {
            let codeItems = queryItems.filter({ (item) -> Bool in
                if item.name == "code" { return true }
                return false
            })
            if codeItems.count > 0 {
                if let code = codeItems[0].value {
                    let headers = ["Content-Type": "application/x-www-form-urlencoded", "Accept": "application/json"]
                    let parameters = [
                        "code": "\(code)",
                        "client_id": "\(GitHubConnectionManager.clientID)",
                        "client_secret": "\(GitHubConnectionManager.clientSecret)",
                        "redirect_uri": "\(GitHubConnectionManager.redirectURL)",
                        "grant_type": "authorization_code"
                        ]
                    request(GitHubConnectionManager.tokenURL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).validate().responseJSON { responseJSON in
                        guard let dataResponse = responseJSON.data else {
                            print("Response Error")
                            return
                        }
                        do {
                            let token = try JSONDecoder().decode(OAuth2Token.self, from: dataResponse)
                            completion(token)
                        } catch let parsingError { print("Error", parsingError) }
                    }
                }
            }
        }
    }
    
    static func getUserInfo(with accessToken: String, completion: @escaping (UserInfo) -> Void) {
        guard let url = URL(string: "https://api.github.com/user") else { return }
        let headers = ["Authorization": "token \(accessToken)", "Accept": "application/json"]
        request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                guard let jsonData = response.data else { return }
                do {
                    print(response)
                    let jsonResponse = try JSONDecoder().decode(UserInfo.self, from: jsonData)
                    completion(jsonResponse)
                }
                catch { print("error catched") }
            case .failure:
                print("failure")
            }
        }
    }
    
//    static func loadToken() {
//        if clientID != "" {
//            let keychain = KeychainPasswordItem(service: "OAuth2Client.\(clientID)", account: )
//            do {
//                if let accessToken = try keychain.get("accessToken.accessToken"), let type = try keychain.get("accessToken.tokenType"), let refreshToken = try keychain.get("accessToken.refreshToken") {
//                    self.token = OAuth2Token()
//                    self.token?.accessToken = accessToken
//                    self.token?.tokenType = type
//                    self.token?.refreshToken = refreshToken
//                    if let idToken = try keychain.get("accessToken.idToken") {
//                        self.token?.idToken = idToken
//                    }
//                    if let timeIntervalString = try keychain.get("accessToken.accessTokenExpiry") {
//                        if let timeInterval = Double(timeIntervalString) {
//                            let accessTokenExpiry = Date(timeIntervalSinceReferenceDate: timeInterval)
//                            self.token?.accessTokenExpiry = accessTokenExpiry
//                        }
//                    }
//                }
//            } catch let error {
//                print("loadToken error: \(error)")
//            }
//        } else {
//            print("error: No client Id provided")
//        }
//    }
//
//    /// Override to implement your own logic in subclass.
//    open func saveToken() {
//        if self.configuration.clientId != "" {
//            let keychain = Keychain(service: "OAuth2Client.\(self.configuration.clientId)")
//            if let accessToken = self.token?.accessToken, let type = self.token?.tokenType, let refreshToken = self.token?.refreshToken {
//                do {
//                    try keychain.synchronizable(true).set("\(accessToken)", key: "accessToken.accessToken")
//                    try keychain.synchronizable(true).set("\(type)", key: "accessToken.tokenType")
//                    try keychain.synchronizable(true).set("\(refreshToken)", key: "accessToken.refreshToken")
//                    if let idToken = self.token?.idToken {
//                        try keychain.synchronizable(true).set("\(idToken)", key: "accessToken.idToken")
//                    }
//                    if let accessTokenExpiry = self.token?.accessTokenExpiry {
//                        let timeInterval = accessTokenExpiry.timeIntervalSinceReferenceDate
//                        try keychain.synchronizable(true).set("\(timeInterval)", key: "accessToken.accessTokenExpiry")
//                    }
//                } catch let error {
//                    print("saveToken error: \(error)")
//                }
//            }
//        } else {
//            print("error: No client Id provided")
//        }
//    }
//    
//    /// Override to implement your own logic in subclass.
//    open func clearToken() {
//        if self.configuration.clientId != "" {
//            let keychain = Keychain(service: "OAuth2Client.\(self.configuration.clientId)")
//            do {
//                try keychain.remove("accessToken.accessToken")
//                try keychain.remove("accessToken.tokenType")
//                try keychain.remove("accessToken.refreshToken")
//                try keychain.remove("accessToken.idToken")
//                try keychain.remove("accessToken.accessTokenExpiry")
//            } catch let error {
//                print("error: \(error)")
//            }
//        } else {
//            print("clearToken error: No client Id provided")
//        }
//    }
}
