import 'package:flutter/material.dart';
import 'package:payment_app/keys.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:payment_app/extensions.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Razorpay _razorpay;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlerPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlerErrorFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlerExternalWallet);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _razorpay.clear();
    super.dispose();
  }

  void _handlerPaymentSuccess(PaymentSuccessResponse response) {
    print("Payment success");
    _scaffoldKey.currentState.showSnackBar('Payment Success'.showSnackBar);
  }

  void _handlerErrorFailure(PaymentFailureResponse response) {
    print("Payment error");
    _scaffoldKey.currentState.showSnackBar('Payment error'.showSnackBar);
  }

  void _handlerExternalWallet() {
    print("External Wallet");
    _scaffoldKey.currentState.showSnackBar('External Wallet'.showSnackBar);
  }

  void openCheckout() {
    var options = {
      'key': razorpay_key,
      'amount': int.parse(_textEditingController.text) * 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Payments App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _textEditingController,
                validator: (value) =>
                    value.isEmpty ? 'Please Enter amount' : null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Amount to pay"),
              ),
              SizedBox(
                height: 12,
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Donate Now",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    openCheckout();
                    _formKey.currentState.reset();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
