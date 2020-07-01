//
//  ViewController.swift
//  web
//
//  Created by Jz D on 2020/7/1.
//  Copyright © 2020 Jz D. All rights reserved.
//

import UIKit


import WebKit


class ViewController: UIViewController {
    
    lazy
    var webView: WKWebView = {
        let webCfg: WKWebViewConfiguration = WKWebViewConfiguration()


        // Setup WKUserContentController instance for injecting user script
        var userController: WKUserContentController = WKUserContentController()

        // Add a script message handler for receiving  "buttonClicked" event notifications posted from the JS document using window.webkit.messageHandlers.buttonClicked.postMessage script message
        userController.add(self, name: "nativeProcess")
        // Configure the WKWebViewConfiguration instance with the WKUserContentController
        webCfg.userContentController = userController;

        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), configuration: webCfg)
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Experimental HTML"
        self.view.addSubview(webView)
        let urlToLoad = Bundle.main.url(forResource: "0", withExtension: "html")
        // Do any additional setup after loading the view.
        webView.load(URLRequest(url: urlToLoad!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    


    // MARK: API from Random user implementation.

    func fetchRandomUserProfile(guid: String) {
        //https://randomuser.me/api
        let request = NSMutableURLRequest(url: URL(string: "https://randomuser.me/api") as! URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) -> Void in
            if let e = error{
                print(e)
            } else {
                let httpResponse = response as? HTTPURLResponse
                let theString = String(data: data!, encoding: .utf8)
                print(theString)
                DispatchQueue.main.async {
                    self.executeCallBack(guid: guid, data: theString!)
                }

            }
        })

        dataTask.resume()
    }

    func executeCallBack(guid: String, data: String) {
        let execString = String(format: "executePromise('%@','%@')", guid, data)
        print(execString)
        webView.evaluateJavaScript(execString) {
            (data, err) in
            print("Finished calling")
        }
    }
}




extension ViewController: WKScriptMessageHandler{
    
    /// Assuming that the javascript sends message back, this function handles the message
    ///
    /// - Parameters:
    ///   - userContentController: controller
    ///   - message: Message. Can be a String or [String:Any] to a single level.
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("User message got")
        if let theBody = message.body as? [String: Any] {
            if let guid = theBody["guid"] as? String {
                print("guid of the promise is " + guid)
                fetchRandomUserProfile(guid: guid)
            }
        }

    }
}
