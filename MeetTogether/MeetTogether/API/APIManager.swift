//
//  APIManager.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/3/28.
//

import Foundation
import MBProgressHUD
import Moya

class APIManager {
    static let shared = APIManager()

    static let requestQueue: DispatchQueue = DispatchQueue(label: "com.25sprout.request_queue", qos: .background)

    private init() {}

    private let usingSampleData = false // 是否使用 SampleData 作為 Response

    private let networkPlugin = NetworkActivityPlugin.init { changeType, targetType in
        switch changeType {
        case .began:
            DispatchQueue.main.async {
                if let view = UIApplication.shared.mainKeyWindow {
                    MBProgressHUD.showAdded(to: view, animated: true)
                }
            }
        case .ended:
            DispatchQueue.main.async {
                if let view = UIApplication.shared.mainKeyWindow {
                    MBProgressHUD.hide(for: view, animated: false)
                }
            }
        }
    }
}

extension APIManager {
    
    func request<T: DecodableResponseTargetType>(_ targetType: T,
                                                 thread: DispatchQueue = APIManager.requestQueue,
                                                 completion: @escaping ((Swift.Result<T.Response?, APIError>) -> Void)) {
        let provider = createProvider(targetType)
        thread.async {
            provider.request(targetType) { result in
                let decoder = JSONDecoder ()
                switch result {
                case .success(let response):
                    if let model = try? response.map (T.Response.self, using: decoder) {
                        completion (.success (model))
                    }

                case .failure(let error):
                    completion(.failure(APIError.moyaError(error)))
                }
            }
        }
    }

    private func createProvider<T>(_ targetType: T) -> MoyaProvider<T> {
        let provider: MoyaProvider<T>
        provider = {
            if usingSampleData {
                return MoyaProvider<T>(stubClosure: MoyaProvider<T>.delayedStub(0.1),
                                       plugins: [NetworkLoggerPlugin()])
            } else {
                return MoyaProvider<T>(plugins: [networkPlugin, NetworkLoggerPlugin(), VerbosePlugin(verbose: true)])
            }
        }()
        return provider
    }
}

