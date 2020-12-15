//
//  UIImageView+Ext.swift
//  VIPSwift
//
//  Created by Vinicius Salmont on 14/12/20.
//

import Kingfisher

extension UIImageView {
    func download(url: String?, rounded: Bool = true) {
        guard let _url = url else {
            return
        }
        if rounded {
            self.layer.cornerRadius = self.frame.size.width / 2
            self.kf.setImage(with: URL(string: _url), placeholder: nil)
        } else {
            self.kf.setImage(with: URL(string: _url))
        }
    }
}
