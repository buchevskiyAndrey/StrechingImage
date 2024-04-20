//
//  ViewController.swift
//  StrechingImage
//
//  Created by Бучевский Андрей on 20.04.2024.
//

import UIKit

class ViewController: UIViewController {

    private let imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "test"))
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.zPosition = 1
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = .init(width:  UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height * 2)
        // Иначе почему-то индикатор скролла имел большой инсет от топа
        scrollView.verticalScrollIndicatorInsets = .init(top: 1, left: 0, bottom: 0, right: 0)
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(imageView)
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        let y = scrollView.contentOffset.y
        if y > 0 {
            imageView.frame.origin.y = min(0, -y)
        } else {
            imageView.frame.size = .init(width: view.bounds.width, height: 300 - y)
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    }
}
