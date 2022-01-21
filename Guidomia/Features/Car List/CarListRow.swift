//
//  CarListRow.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-21.
//

import Foundation

enum CarListRow {
    case header(item: CarListHeaderTableViewCell.Item)
    case car(item: CarTableViewCell.Item)
}
