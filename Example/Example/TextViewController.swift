//
//  TextViewController.swift
//  Example
//
//  Created by maizifeng on 2019/3/28.
//  Copyright © 2019 Marcus Wu. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import StyledTextKit

class TextViewController: UIViewController {

    private let containerView = UIView()
    private let styledTextView = StyledTextView()
    private let contentSizeCategory = UIApplication.shared.preferredContentSizeCategory

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        title = "TextViewController Example"
    }

    lazy var paragraphStyle: NSMutableParagraphStyle = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 0
        paragraphStyle.lineSpacing = 0
        paragraphStyle.lineHeightMultiple = 1.2
        return paragraphStyle
    }()

    lazy var style = TextStyle(size: 16, attributes: [
        .foregroundColor: UIColor.black,
        .paragraphStyle: paragraphStyle
    ])

    func setupSubview() {
        view.backgroundColor = .gray
        containerView.backgroundColor = .white

        view.addSubview(containerView)

        containerView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }

        containerView.addSubview(styledTextView)

        let styledText = StyledText(text: "尼采是第一个明确揭示人的心理中无意识领域并加以细致剖析的人，他的作品给现代深层心理学的研究提供了不少富有启发性的观念。弗洛伊德以《梦的解析》一书为精神分析学奠基，而尼采比他早二十到三十年就对梦的作用和机制作出类似的分析。尼采对于无意识有不少精辟的洞见，但这些洞见还都是零星的。当弗洛伊德运用精神分析学研究现代文明时，能够发现他把尼采的某些见解具体化了。尼采还在意识的背后进一步分析探讨其深层的心理活动", style: style)

        let builder = StyledTextBuilder(styledText: styledText)


        let renderer = StyledTextRenderer(
            string: builder.build(),
            contentSizeCategory: .large,
            inset: UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12),
            maximumNumberOfLines: 3
        ).warm(width: 240) // warms the size cache

        DispatchQueue.main.async {
            self.styledTextView.configure(with: renderer, width: self.containerView.bounds.width)
        }
        
    }
}
