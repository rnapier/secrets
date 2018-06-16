//
//  ViewController.swift
//  HackMe
//
//  Created by Rob Napier on 5/29/18.
//  Copyright © 2018 Rob Napier. All rights reserved.
//

import UIKit
import WebKit

let keys = ["s3kretSkwarl", "Ha!U'llNevar(Find)Me", "TYYLWKMUAPZHLYXJMPUW", "TlqI7CIrzHp4/pY1wpRErEytlqs0IKeS4BzD9/3quqQ="]
let url = URL(string: "https://o0rq0uweih.execute-api.us-east-1.amazonaws.com/secrets/secrets?token=\(keys[2])")!

let dataKey = Data([
    0xd2, 0xb9, 0x6c, 0x45, 0x4e, 0x6f, 0x8c, 0xfb, 0xc7, 0x51, 0xa7, 0x7b,
    0xd3, 0x2b, 0x2a, 0x5f, 0xae, 0xe4, 0xe0, 0x33, 0x79, 0xd3, 0xfb, 0x0d,
    0x61, 0x10, 0xf9, 0xce, 0xa9, 0xc2, 0x2d, 0xb8
    ])

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!

    @IBAction func send(_ sender: Any) {
        let request = URLRequest(url: url)
        webView.load(request)
        // Make sure the keys aren't optimized out
        print(keys)
        print(dataKey)
    }

}

