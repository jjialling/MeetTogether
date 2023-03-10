//
//  NewsDetailViewController.swift
//  MeetTogether
//
//  Created by 蔡佳玲 on 2023/2/27.
//

import UIKit
import WebKit

class NewsDetailViewController: UIViewController {
    
    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = .default()
        configuration.dataDetectorTypes = [.all]
        
        let webView = WKWebView()
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.allowsBackForwardNavigationGestures = true
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        return webView
    }()
    
    private lazy var closeBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        btn.makeCloseStyle()
        btn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        
        return btn
    }()
    
    init(newsID: Int?) {
        super.init(nibName: nil, bundle: nil)
        self.view.isHidden = false //Fixed viewDidLoad not called
        self.title = "News"
//        self.view = webView
        var urlString = Network.baseURL + "/news/index.php"
//        if let id = newsID {
//            urlString = urlString + "/\(id)"
//        }
        urlString = urlString + "?src=app"
        DispatchQueue.main.async {
            let request = URLRequest(url: URL(string: urlString)!)
            self.webView.load(request)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setUI()
    }
   
    private func setUI() {
        view.addSubviews([webView])
        webView.snp.makeConstraints({
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        })
    }
    
    private func setupNav() {
        let closeItem = UIBarButtonItem(customView: closeBtn)
        self.navigationItem.leftBarButtonItem = closeItem
    }
    
    @objc func closeAction() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension NewsDetailViewController: WKNavigationDelegate, WKUIDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated {
            if let url = navigationAction.request.url, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                webView.load(navigationAction.request)
            }
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }
}

