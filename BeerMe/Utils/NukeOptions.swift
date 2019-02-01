//
//  NukeOptions.swift
//  BeerMe
//
//  Created by Scarpz on 01/02/19.
//  Copyright © 2019 scarpz. All rights reserved.
//

import Foundation
import Nuke

/// Struct to store all the options of placeholder and visual transition used in Nuke
///
/// - championLoading: Option to display a Beer placeholder while download the real image
struct NukeOptions {
    static let imageLoading = ImageLoadingOptions(placeholder: UIImage(named: "beerIcon")!, transition: .fadeIn(duration: 0.3))
}
