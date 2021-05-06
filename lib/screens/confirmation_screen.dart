import 'package:flutter/material.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({Key key}) : super(key: key);

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  // TODO: Change the UI for this screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            SizedBox(height: 250.0,),
            Center(child: Image.asset("assets/images/Frametickmark.png")),
            SizedBox(height: 30.0,),
            Text("Thanks For Sharing The Details." , style: TextStyle(fontSize: 20.0),),
            Text("You Are Successfully Registered As A Donor." , style: TextStyle(fontSize: 20.0),),
            Text("We’ll Get Back To You!" , style: TextStyle(fontSize: 20.0),),
            SizedBox(height: 250.0,),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, '/wrapper', (route) => false);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)
                ),
                minimumSize: Size(350.0,50.0),
              ),
              child: Text("Return To Home" , style: TextStyle(fontSize: 25.0 , color: Colors.white),),
            )
          ],
        )
    );
  }
}
