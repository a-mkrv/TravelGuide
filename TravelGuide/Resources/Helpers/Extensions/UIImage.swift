//
//  UIImage.swift
//  TravelGuide
//
//  Created by Anton Makarov on 22.03.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if (error == nil) {
                    if let imageData = data as NSData? {
                        DispatchQueue.main.async {
                            self.image = UIImage(data: imageData as Data)
                        }
                    }
                } else {
                    self.image = UIImage(named: "nn") // change to city template
                    print("Error image download: \(String(describing: error?.localizedDescription))");
                }
            }.resume();
        }
    }
}
