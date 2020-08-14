//
//  NYSegmentedLabel.swift
//  NYT news
//
//  Created by Ayman Ata on 8/13/20.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import UIKit

class NYSegmentedLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(lblText: String) {
        super.init(frame: .zero)
        text = lblText
        setup()
    }

    private func setup() {
        adjustsFontSizeToFitWidth = true
        font = UIFont.systemFont(ofSize: 16, weight: .medium)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20
        
    }
}
