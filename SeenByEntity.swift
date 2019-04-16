//
//  SeenByEntity.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 09/03/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

class SeenByModel: Decodable{
    var data: SeenByCountModel?
    var status: Bool?
    var error: Bool?
    var message: String?
}
class SeenByCountModel: Decodable{
    var Count: Int?
    var result: [SeenByDataModel]?
}
class SeenByDataModel: Decodable{
    var UserId: Int?
    var  ImageUrl: String?
    var FirstName: String?
    var LastName: String?
    var CreatedDate: CLong?
}

class SeenByRequest: Codable{
    var commentId = ""
    var subGroupId = ""
    init(commentId: String, subGroupId: String) {
        self.commentId = commentId
        self.subGroupId = subGroupId
    }
}
