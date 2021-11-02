//
//  ViewController.swift
//  paytmIntegration
//
//  Created by cedcoss on 30/10/21.
//

import UIKit
import AppInvokeSDK

class ViewController: UIViewController {

    private let handler = AIHandler()
    
    //TODO: Values required from current project to initiate paytm
    var custID: String? = nil           //cartId or userId
    var merchantID: String = ""
    var orderID: String = ""
    var txnToken = ""
    var grandTotal = "0.0"
    var callBackURL = ""
    var AIEnvironmentType : AIEnvironment = .staging        // set as default
    var appURL = ""
    var headerKey = ""
    var storID: String? = nil
    var paytmResponse = [String:Any]()
    
    
    //TODO: Required details from main project
    init(userID: String, merchantId: String, orderId: String, token: String, totalVal: String, callbackurl: String, environemntTyp: String, baseUrl: String, headerkey: String){
        super.init(nibName: nil, bundle: nil)
        self.custID = userID;
        self.merchantID = merchantId;
        self.orderID = orderId;
        self.txnToken = token;
        self.grandTotal = totalVal;
        if environemntTyp.lowercased() == "staging"{
            self.AIEnvironmentType = .staging;
        }else if environemntTyp.lowercased() == "production"{
            self.AIEnvironmentType = .production;
        }
        
        self.callBackURL = callbackurl;
        self.appURL = baseUrl;
        self.headerKey = headerkey;
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initiatePayment()
        // Do any additional setup after loading the view.
    }
    
    func initiatePayment(){
        AIHandler.version()
        self.handler.openPaytm(merchantId: self.merchantID, orderId: self.orderID, txnToken: self.txnToken, amount: self.grandTotal, callbackUrl: self.callBackURL, delegate: self, environment: self.AIEnvironmentType, urlScheme: nil)
    }


}

//MARK: - AIDelegate Methods
extension ViewController: AIDelegate {
    func didFinish(with status: AIPaymentStatus, response: [String : Any]) {
        print("Paytm Callback Response: ", response)
        paytmResponse = response
        onPaytmPaymentSuccess(paymentResponse:paytmResponse)
    }
    
    func openPaymentWebVC(_ controller: UIViewController?) {
        if let vc = controller {
            DispatchQueue.main.async {[weak self] in
                self?.present(vc, animated: true, completion: nil)
            }
        }
    }
    func onPaytmPaymentSuccess(paymentResponse:[String:Any])
    {
        var params = Dictionary<String,String>();
        params["payment_method"]="paytm";
        for (key,value) in paymentResponse{
            if(key.lowercased() == "CHECKSUMHASH".lowercased()){
                let val = value as! String
                params[key] = val.replacingOccurrences(of: "+", with: "%2B")
            }
            else{
                params[key] = value as? String
            }
           
        }
        print(params)
       //TODO: Call api to fetch Order State, and redirect to completion/failure page
        
    }
}

public enum environmentType{
    case production
    case staging
}
