//
//  RSSExtensions.swift
//  RSSFeed
//
//  Created by Joshi, Vinayak (CAI - Atlanta-CON) on 4/19/16.
//  Copyright © 2016 Joshi, Vinayak (CAI - Atlanta-CON). All rights reserved.
//

import Foundation

// extension to trim the \n \t prefix to the string
extension String{
    func removelineBrakes()-> String {
        return self.stringByReplacingOccurrencesOfString("^\\s*",withString: "", options: .RegularExpressionSearch)
    }
}