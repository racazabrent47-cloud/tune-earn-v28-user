import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:math';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try { await Firebase.initializeApp(); } catch(e){}
  try { await MobileAds.instance.initialize(); } catch(e){}
  runApp(TuneEarnV28Final());
}

class TuneEarnV28Final extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginV28(), debugShowCheckedModeBanner: false);
  }
}

class LoginV28 extends StatefulWidget { @override _LoginV28State createState() => _LoginV28State(); }
class _LoginV28State extends State<LoginV28> {
  var c = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Padding(padding: EdgeInsets.all(30), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.rocket_launch, size: 80, color: Colors.purple), Text("TUNE
