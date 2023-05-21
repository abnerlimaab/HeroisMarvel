//
//  MarvelAPI.swift
//  HeroisMarvel
//
//  Created by Abner Lima on 13/05/23.
//  Copyright © 2023 Eric Brito. All rights reserved.
//

import Foundation
import SwiftHash
import Alamofire

class MarvelAPI {
    
    static private var basePath: String {
        return ProcessInfo.processInfo.environment["API_MARVEL_BASE_URL"] ?? ""
    }
    static private var privateKey: String {
        return ProcessInfo.processInfo.environment["API_MARVEL_PRIVATE_KEY"] ?? ""
    }
    static private var publicKey: String {
        return ProcessInfo.processInfo.environment["API_MARVEL_PUBLIC_KEY"] ?? ""
    }
    static private let limit = 50
    
    class func loadHeros(mame: String?, page: Int = 0, onComplete: @escaping (MarvelInfo?) -> Void) {
        let offset = page * limit
        let startsWith: String
        if let name = mame, !name.isEmpty {
            startsWith = "nameStartsWith=\(name.replacingOccurrences(of: " ", with: ""))"
        } else {
            startsWith = ""
        }
        let url = "\(basePath)?offset=\(offset)&limit=\(limit)&\(startsWith)&\(getCredentials())"
        Alamofire.request(url).responseJSON { response in
            guard let data = response.data,
            let marvelInfo = try? JSONDecoder().decode(MarvelInfo.self, from: data),
            marvelInfo.code == 200 else {
                onComplete(nil)
                return
            }
            
            onComplete(marvelInfo)
        }
    }
    
    private class func getCredentials() -> String {
        let ts = "\(Date().timeIntervalSince1970)"
        let hash = MD5(ts+privateKey+publicKey).lowercased()
        return "ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
    
}
