//
//  CrypotControlService.swift
//  CryptoManager
//
//  Created by Jonny Caley on 28/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class CryptoControlService: NSObject {
    
    static let shared = CryptoControlService()
    
    func getTopNews() -> Single<News> {
        return Single.create { single -> Disposable in
            
            AF.request(Constants.CRYPTOCONTROL_URL + Constants.CRYPTOCONTROL_NEWS,
                       method: .get,
                       parameters: [Constants.CRYPTOCONTROL_NAME: Constants.CRYPTOCONTROL_KEY],
                       encoding: URLEncoding(destination: .queryString),
                       headers: nil)
                .validate()
                .responseJSON { response in
                    print(response.data)
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            // if no error provided by alamofire return .notFound error instead.
                            // .notFound should never happen here?
                            single(.error(response.error ?? NewtorkFailureReason.notFound))
                            return
                        }
                        do {
                            print("trying")
                            let response = try JSONDecoder().decode(News.self, from: data)
                            print("Success")
                            single(.success(response))
                        } catch {
                            single(.error(error))
                        }
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode,
                            let reason = NewtorkFailureReason(rawValue: statusCode)
                        {
                            single(.error(reason))
                        }
                        single(.error(error))
                    }
            }
            return Disposables.create()
        }
    }
}
