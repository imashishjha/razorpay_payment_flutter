import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Razorpay razorpay;

  TextEditingController Amountcontroller= TextEditingController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, PaymentSuccessHandler);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, PaymentErrorHandler);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, PaymentExWalletHandler);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void PaymentSuccessHandler(){
   print("Payment Successful");
  }
  void PaymentErrorHandler(){
    print("Payment Error");
  }
  void PaymentExWalletHandler(){
    print("Payment External Wallet");
  }

  void openCheckout(){
    var options={
      "key":"rzp_test_yz36KoG9eFYd9e",
      "amount": num.parse(Amountcontroller.text)*100,
      "name": "Ashish Jha",
      "description": "This is just a sample payment",
      "prefill": {
        "contact": "9325467434",
        "email":"info@companyname.com",
      },
      "external":{
        "wallets": ["paytm"]
      }
    };
    try{
     razorpay.open(options);
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RazorPay Payment System'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: Amountcontroller,
              decoration: InputDecoration(
                hintText: "Enter Amount to Pay",
              ),
            ),
          ),
          SizedBox(height: 12,),
          // ignore: deprecated_member_use
          RaisedButton(
              onPressed: (){
                openCheckout();
              },
              child: Text('Donate Now',style: TextStyle(color: Colors.white),),
              color: Colors.blue,
          )
        ],
      ),
    );
  }
}
