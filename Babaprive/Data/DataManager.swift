//
//  DataManager.swift
//  Ploop
//
//  Created by Benjamin Sénéchal on 03/06/2015.
//  Copyright (c) 2015 Benjamin Sénéchal. All rights reserved.
//

import Foundation
import UIKit

let DataManager : DataManagerProtocol = UIApplication.sharedApplication().delegate as! AppDelegate

protocol DataManagerProtocol {
    var saleBLL:SaleBLL {
        get
    }
}