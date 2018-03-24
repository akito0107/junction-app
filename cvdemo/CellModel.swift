//
//  CellModel.swift
//  cvdemo
//
//  Created by Akito Ito on 2018/03/25.
//  Copyright © 2018 Akito Ito. All rights reserved.
//

import UIKit

class CellModel: NSObject {
    var id:String
    var desc:String
    var imageUrl:URL?
    init(id: String, desc: String, imageUrl: URL?){
        self.id = id
        self.desc = desc
        self.imageUrl = imageUrl
    }
}
