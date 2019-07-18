//
//  Model.swift
//  JSON Coding Exercise
//
//  Created by Eric Liberi on 7/18/19.
//  Copyright © 2019 Eric Liberi. All rights reserved.
//

import Foundation
import UIKit

struct User: Decodable {
    let name: String?
    let email: String?
    let address: Address?
}

struct Address: Decodable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
}
