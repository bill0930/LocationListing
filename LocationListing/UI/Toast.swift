//
//  Toast.swift
//  LocationListing
//
//  Created by Billy Chan on 7/5/2021.
//
import Loaf

import Foundation

public class Toast {

    static func showTheListIsFromCache(sender: UIViewController) {
        let message = "The List is from Cache"
        Loaf(message, state: .info, location: .bottom, presentingDirection: .vertical, dismissingDirection: .vertical, sender: sender)
            .show()
    }
}
