//
//  CardItem.swift
//  MatchedGeometryEffect
//
//  Created by ice on 2024/8/19.
//

import Foundation

struct Game: Identifiable{
    var id: String {
        return title
    }
    let cover: String
    let title: String
    let summary: String
}
