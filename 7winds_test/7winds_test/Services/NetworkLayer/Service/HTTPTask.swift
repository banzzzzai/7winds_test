//
//  HTTPTask.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 07.02.2024.
//

import Foundation

typealias HTTPHeaders = [String: String]

enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
//    case accountImageUploadingParameters(
//        bodyParameters: Parameters?,
//        urlParameters: Parameters?,
//        filePathKey: String,
//        imageDataKey: Data,
//        imageType: ImageType
//    )
}
