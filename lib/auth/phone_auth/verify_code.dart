
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../widgets/round_button.dart';
import '../../Constants/constants.dart';
import '../../screens/home_screen.dart';
import '../../utils/utils.dart';



class VerifyCodeScreen extends StatefulWidget {
  final String verificationId ;
  final String phoneNumber;
  const VerifyCodeScreen({Key? key, required this.verificationId,required this.phoneNumber}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false ;
  final verificationCodeController = TextEditingController();
  final auth = FirebaseAuth.instance ;
  final _firestore = FirebaseFirestore.instance.collection(Constants.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 80,),

            TextFormField(
              controller: verificationCodeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: '6 digit code'
              ),
            ),
            const SizedBox(height: 80,),
            RoundButton(title: 'Verify',loading: loading, onTap: ()async{

              setState(() {
                loading = true ;
              });
              final crendital = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId, 
                  smsCode: verificationCodeController.text.toString()
              );
              
              try{
                
                await auth.signInWithCredential(crendital);

                _firestore.doc(auth.currentUser?.uid).set({
                  Constants.userName : widget.phoneNumber,
                  Constants.userUid : auth.currentUser?.uid,
                  Constants.topScore : "0",
                });
                
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                
              }catch(e){
                setState(() {
                  loading = false ;
                });
                Utils().toastMessage(e.toString());
              }
            })

          ],
        ),
      ),
    );
  }
}
