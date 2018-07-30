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
                            CoreDataModel.addRecord(token.accessToken)
                            completion(token)
                        } catch let parsingError { print("Error", parsingError) }
                    }
                }
            }
        }
    }
    
    static func getUserInfo(with accessToken: String, completion: @escaping (UserInfo?) -> Void) {
        guard let url = URL(string: "https://api.github.com/user") else { return }
        let headers = ["Authorization": "token \(accessToken)", "Accept": "application/json"]
        request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                guard let jsonData = response.data else { return }
                let jsonResponse = try? JSONDecoder().decode(UserInfo.self, from: jsonData)
                completion(jsonResponse)
            case .failure:
                completion(nil)
            }
        }
    }
    
    static func setUserInfo(with accessToken: String, _ userData: EditableUserData, completion: @escaping (Error?) -> Void) {
        guard let url = URL(string: "https://api.github.com/user") else { return }
        let headers = ["Authorization": "token \(accessToken)", "Accept": "application/json"]
        let parameters = [
                "name": userData.name,
                "blog": userData.blog,
                "company": userData.company,
                "location": userData.location,
                "bio": userData.bio
            ]
        request(url, method: .patch, parameters: parameters, encoding: URLEncoding.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success:
                completion(nil)
            case .failure:
                completion(TypeError.dataIsAbsent)
            }
        }
    }
}


