//
//  NetworkService.swift
//  VIPSwift
//
//  Created by Vinicius Salmont on 14/12/20.
//

import Alamofire

protocol Endpoint {
    var method: HTTPMethod { get }
    var path: String { get }
    var paramters: Parameters? { get }
    var header: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
}

class NetworkService {
    static let shared = NetworkService()
    private var dataRequest: DataRequest?
    private var success: ((_ data: Data?) -> Void)?
    private var failure: ((_ error: Error?) -> Void)?

    @discardableResult
    private func dataRequest(url: URLConvertible,
                             method: HTTPMethod,
                             parameters: Parameters? = nil,
                             encoding: ParameterEncoding,
                             headers: HTTPHeaders? = nil) -> DataRequest {
        return SessionManager.default.request(url,
                                              method: method,
                                              encoding: encoding,
                                              headers: headers)
    }

    func request<T: Endpoint>(endpoint: T,
                              success: ((_ data: Data) -> Void)? = nil,
                              failure: ((_ error: Error) -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            self.dataRequest = self.dataRequest(url: endpoint.path,
                                                method: endpoint.method,
                                                parameters: endpoint.paramters,
                                                encoding: endpoint.encoding,
                                                headers: endpoint.header)
            self.dataRequest?.responseData(completionHandler: { (response) in
                switch response.result {
                case let .success(data):
                    success?(data)
                case let .failure(error):
                    failure?(error)
                }
            })
        }
    }
}
