import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upi_pay/upi_pay.dart';
class ChoosePayment extends StatefulWidget {
  ChoosePaymentState createState() => ChoosePaymentState();
}
class ChoosePaymentState extends State<ChoosePayment> {
  @override
  void initState() {
    super.initState();
    initPayment();
    setState(() {
    });
  }
  initPayment() async {
    List<ApplicationMeta> upiApps = await UpiPay.getInstalledUpiApplications();
    for(int pos = 0;pos<upiApps.length;pos++){
      // print(upiApps[pos].upiApplication);
      // print(upiApps[pos].icon);
    }
  }
  startTransaction() async {
    UpiTransactionResponse txnResponse = await UpiPay.initiateTransaction(
      /// must be a string value of two decimal digits
        amount: "10.00",
        /// UpiApplication class has all the supported applications
        /// only accepts a value from the UpiApplication class
        app: UpiApplication.payTM,
        /// Name of the person / merchant receiving the payment
        receiverName: "John",
        /// UPI VPA of the person / merchant receiving the payment
        receiverUpiAddress: "johnupi@paytm",
        /// unique ID for the transaction
        /// use your business / use case specific ID generation logic here
        transactionRef: 'ORD1215236',
        /// there are some other optional parameters like
        /// [url], [merchantCode] and [transactionNode]
        /// url can be used share some additional data related to the transaction like invoice copy, etc.
        url: 'www.johnshop.com/order/ORD1215236',
        /// this is code that identifies the type of the merchant
        /// if you have a merchant UPI VPA as the receiver address
        /// add the relevant merchant code for seamless payment experience
        /// some application may reject payment intent if merchant code is missing
        /// when making a P2M (payment to merchant VPA) transaction
        merchantCode: "1032",
        /// anything that provides some desription of the transaction
        transactionNote: 'Test transaction'
    );
    print(txnResponse);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.of(context).pop()},
        ),
      ),
      body: Container(
        child: Center(
          child: GestureDetector(
            onTap: (){startTransaction();},
            child: Text("Payment"),
          ),
        ),
      ),
    );
  }
}
