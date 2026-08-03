import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try { await Firebase.initializeApp(); } catch(e){}
  try { await MobileAds.instance.initialize(); } catch(e){}
  runApp(TuneEarnV28Final());
}

class TuneEarnV28Final extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginV28(), debugShowCheckedModeBanner: false, theme: ThemeData(primarySwatch: Colors.purple));
  }
}

class LoginV28 extends StatefulWidget { @override _LoginV28State createState() => _LoginV28State(); }
class _LoginV28State extends State<LoginV28> {
  var c = TextEditingController();
  bool agree = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: SingleChildScrollView(padding: EdgeInsets.all(30), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.rocket_launch, size: 80, color: Colors.purple), Text("TUNE EARN V28", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900)), Text("FINAL MEGA MALL - CEO BRENT - LEGIT BANK", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green)),
      SizedBox(height: 20), TextField(controller: c, decoration: InputDecoration(labelText: "Username", border: OutlineInputBorder())),
      SizedBox(height: 10),
      CheckboxListTile(value: agree, onChanged: (v)=>setState(()=>agree=v!), title: Text("I agree to Terms V9-V28 + Bank Withdraw 4.5% Fee + 50/50 AdMob", style: TextStyle(fontSize: 11)), subtitle: Text("50/50 AdMob + 10% Shopee/Alibaba Affiliate + 4.5% Withdraw Fee auto to CEO Vault MAIN_CEO_BRENT", style: TextStyle(fontSize: 9, color: Colors.grey)), controlAffinity: ListTileControlAffinity.leading),
      TextButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> LegalV28())), child: Text("Read Legal Terms V9-V28 - Bank Approved", style: TextStyle(fontSize: 11))),
      SizedBox(height: 20), SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: agree && c.text.isNotEmpty? (){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>MainV28(username: c.text.trim()))); } : null, child: Text("ENTER MEGA MALL - LEGIT BANK"))),
    ]))));
  }
}

class LegalV28 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("LEGAL V9-V28 + BANK")), body: SingleChildScrollView(padding: EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("TUNE EARN V28 - LEGAL + LEGIT BANK APPROVED", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 10),
      Text("V9-V12: Watch Ad Earn - AdMob Real ID 7813593140749854/7724732297 - User +₱1, CEO Vault MAIN_CEO_BRENT +₱1 - 50/50 - Auto tracked ceo_vault.", style: TextStyle(fontSize: 12)),
      SizedBox(height: 10),
      Text("V13-V16: Worldwide Feed - Viral Videos - Grant license worldwide.", style: TextStyle(fontSize: 12)),
      SizedBox(height: 10),
      Text("V17-V20: 10K Categories + Live - Community curated.", style: TextStyle(fontSize: 12)),
      SizedBox(height: 10),
      Text("V21-V28 FINAL MEGA MALL + LEGIT BANK:\n\n1. SHOPEE 12% + ALIBABA 8% Affiliate auto to ceo_vault affiliate_commission.\n\n2. ADMOB 50/50 - ₱1 user, ₱1 CEO - Real $ from Google monthly.\n\n3. LEGIT BANK WITHDRAW - GCash/PayPal:\n- Min ₱100\n- User requests withdraw -> balance deducted full amount\n- Auto fee 4.5% -> goes to CEO Vault withdraw_fee_income + available_balance\n- Net = amount - fee -> user receives via GCash/PayPal\n- Example: Request ₱100 -> Fee ₱4.50 to CEO -> User gets ₱95.50\n- Status: PENDING -> CEO approves in admin app tune-earn-v28-admin -> sends GCash -> marks APPROVED\n- Logs: withdraw_requests collection - username, gcash, amount, fee, net, status, timestamp\n- CEO Income: ad_income + affiliate_commission + withdraw_fee_income = available_balance\n- Payout: CEO only can withdraw from admin. Users via GCash/PayPal approved by CEO.\n\n4. COMPLIANCE: AdMob + Shopee + Alibaba TOS + Affiliate disclosure + Privacy username+balance only.", style: TextStyle(fontSize: 12)),
      SizedBox(height: 20),
      Text("By using you agree to 50/50 AdMob + 10% affiliate + 4.5% withdraw fee to CEO vault MAIN_CEO_BRENT. CEO owns platform. Bank via Firebase + GCash/PayPal manual send.", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
    ]))),
  );
}

class MainV28 extends StatefulWidget { final String username; MainV28({required this.username}); @override _MainV28State createState() => _MainV28State(); }
class _MainV28State extends State<MainV28> {
  int idx = 0; RewardedAd? ad; double bal = 0;
  List cats = ["For You","Music","Dance","Comedy","Gaming","Food","Fashion","Tech","Viral","Live","Shopee","Alibaba","Mall","Worldwide"];
  @override
  void initState(){ super.initState(); loadAd(); FirebaseFirestore.instance.collection('users').doc(widget.username).snapshots().listen((d){ if(d.exists&&mounted) setState(()=>bal=(d['balance']??0).toDouble()); }); }
  void loadAd(){ RewardedAd.load(adUnitId: 'ca-app-pub-7813593140749854/7724732297', request: AdRequest(), rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (a)=>ad=a, onAdFailedToLoad: (e)=>Future.delayed(Duration(seconds: 5), loadAd))); }
  void earn(){ if(ad==null){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Loading Ad..."))); loadAd(); return; } ad!.show(onUserEarnedReward: (a,r) async { var ceo=FirebaseFirestore.instance.collection('ceo_vault').doc('MAIN_CEO_BRENT'); var user=FirebaseFirestore.instance.collection('users').doc(widget.username); await user.set({'balance':FieldValue.increment(1), 'ads_watched':FieldValue.increment(1), 'last_earn':FieldValue.serverTimestamp()}, SetOptions(merge:true)); await ceo.set({'available_balance':FieldValue.increment(1), 'total_app_income':FieldValue.increment(2), 'ad_income':FieldValue.increment(2), 'ceo_50':FieldValue.increment(1), 'user_50':FieldValue.increment(1), 'last_user':widget.username, 'last_update':FieldValue.serverTimestamp()}, SetOptions(merge:true)); if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("✅ +₱1 SAYO +₱1 CEO VAULT!"))); loadAd(); }); }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("V28 LEGIT BANK ₱$bal"), actions: [IconButton(icon: Icon(Icons.monetization_on), onPressed: earn), IconButton(icon: Icon(Icons.gavel), onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=>LegalV28()))) ]),
      body: [WorldFeed(), Cats(cats: cats), Mall(username: widget.username, earn: earn), Live(), WalletLegitBank(bal: bal, earn: earn, username: widget.username)][idx],
      bottomNavigationBar: BottomNavigationBar(currentIndex: idx, onTap: (i)=>setState(()=>idx=i), type: BottomNavigationBarType.fixed, items: [BottomNavigationBarItem(icon: Icon(Icons.public), label: "World"), BottomNavigationBarItem(icon: Icon(Icons.category), label: "10K"), BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Mall"), BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: "Live"), BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: "Bank")]),
    );
  }
}

class WorldFeed extends StatelessWidget { @override Widget build(BuildContext context){ return StreamBuilder(stream: FirebaseFirestore.instance.collection('worlds_feed').orderBy('timestamp', descending: true).limit(100).snapshots(), builder: (c,s){ if(!s.hasData) return Center(child: CircularProgressIndicator()); var docs=s.data!.docs; return ListView.builder(itemCount: docs.length==0?10:docs.length, itemBuilder: (c,i){ if(docs.length==0) return Card(margin: EdgeInsets.all(8), child: Container(height: 180, child: Center(child: Text("Viral Video ${i+1} - Worldwide")))); var d=docs[i].data() as Map; return Card(child: ListTile(title: Text(d['caption']??"Viral ${i+1}"), subtitle: Text("${d['username']} • ${Random().nextInt(10000)} views"))); }); }); } }
class Cats extends StatelessWidget { final List cats; Cats({required this.cats}); @override Widget build(BuildContext context){ return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemCount: 100, itemBuilder: (c,i)=> Card(child: Center(child: Text(i<cats.length?cats[i]:"Cat ${i+1}")))); } }
class Mall extends StatelessWidget {
  final String username; final Function earn;
  Mall({required this.username, required this.earn});
  final products = [
    {"name":"Shopee Buds Pro","price":"₱899","shop":"Shopee","comm":"12% = ₱107","link":"https://shopee.ph/search?keyword=buds"},
    {"name":"Alibaba LED Strip","price":"₱450","shop":"Alibaba","comm":"8% = ₱36","link":"https://www.alibaba.com/showroom/led-strip"},
    {"name":"Gaming Headset","price":"₱1200","shop":"Mall","comm":"10% = ₱120","link":"https://shopee.ph/search?keyword=gaming+headset"},
  ];
  Future<void> openAff(String url, String shop, int price) async {
    var ceo = FirebaseFirestore.instance.collection('ceo_vault').doc('MAIN_CEO_BRENT');
    await FirebaseFirestore.instance.collection('affiliate_clicks').add({'username':username, 'shop':shop, 'price':price, 'timestamp':FieldValue.serverTimestamp(), 'status':'clicked'});
    await ceo.set({'affiliate_clicks': FieldValue.increment(1), 'affiliate_commission': FieldValue.increment((price*0.10).round()), 'available_balance': FieldValue.increment((price*0.10).round()), 'total_app_income': FieldValue.increment((price*0.10).round())}, SetOptions(merge:true));
    final uri = Uri.parse(url); if(await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
  @override
  Widget build(BuildContext context){
    return GridView.builder(padding: EdgeInsets.all(8), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.75), itemCount: products.length*3, itemBuilder: (c,i){ var p=products[i%products.length]; return Card(child: Column(children: [Expanded(child: Container(color: Colors.grey[300], child: Center(child: Icon(Icons.shopping_bag)))), Padding(padding: EdgeInsets.all(6), child: Column(children: [Text(p['name']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), Text(p['price']!, style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)), Text("${p['shop']} - ${p['comm']}", style: TextStyle(fontSize: 8, color: Colors.orange)), Text("Disclosure: CEO earns commission", style: TextStyle(fontSize: 7, color: Colors.grey)), SizedBox(height: 4), SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){ openAff(p['link']!, p['shop']!, int.parse(p['price']!.replaceAll(RegExp(r'[^0-9]'), ''))); }, child: Text("BUY", style: TextStyle(fontSize: 9))))]))])); });
  }
}
class Live extends StatelessWidget { @override Widget build(BuildContext context){ return ListView.builder(itemCount: 20, itemBuilder: (c,i)=> Card(child: ListTile(leading: CircleAvatar(), title: Text("Live ${i+1}"), trailing: Container(color: Colors.red, padding: EdgeInsets.all(4), child: Text("LIVE", style: TextStyle(color: Colors.white, fontSize: 10)))))); } }

class WalletLegitBank extends StatefulWidget { final double bal; final Function earn; final String username; WalletLegitBank({required this.bal, required this.earn, required this.username}); @override _WalletLegitBankState createState() => _WalletLegitBankState(); }
class _WalletLegitBankState extends State<WalletLegitBank> {
  var gcashCtrl = TextEditingController(); var amountCtrl = TextEditingController(); bool loading = false;
  Future<void> withdraw() async {
    double amt = double.tryParse(amountCtrl.text)??0;
    if(amt < 100){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Min ₱100"))); return; }
    if(amt > widget.bal){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Kulang balance"))); return; }
    if(gcashCtrl.text.length < 10){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Lagay GCash/PayPal"))); return; }
    setState(()=>loading=true);
    double fee = amt * 0.045; double net = amt - fee;
    var ceo = FirebaseFirestore.instance.collection('ceo_vault').doc('MAIN_CEO_BRENT');
    var user = FirebaseFirestore.instance.collection('users').doc(widget.username);
    await user.set({'balance': FieldValue.increment(-amt)}, SetOptions(merge:true));
    await ceo.set({'available_balance': FieldValue.increment(fee), 'withdraw_fee_income': FieldValue.increment(fee), 'total_app_income': FieldValue.increment(fee)}, SetOptions(merge:true));
    await FirebaseFirestore.instance.collection('withdraw_requests').add({'username': widget.username, 'gcash_paypal': gcashCtrl.text, 'amount_requested': amt, 'fee_4_5_percent': fee, 'net_to_user': net, 'status': 'PENDING', 'timestamp': FieldValue.serverTimestamp(), 'type': 'GCash/PayPal', 'ceo_vault': 'MAIN_CEO_BRENT'});
    setState(()=>loading=false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("✅ REQUESTED ₱$amt - Fee 4.5% ₱${fee.toStringAsFixed(2)} - Net ₱${net.toStringAsFixed(2)} - PENDING CEO APPROVAL")));
    amountCtrl.clear();
  }
  @override
  Widget build(BuildContext context){
    double feeP = (double.tryParse(amountCtrl.text)??0)*0.045; double netP = (double.tryParse(amountCtrl.text)??0)-feeP;
    return SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(children: [
      Icon(Icons.account_balance, size: 60, color: Colors.green), Text("LEGIT BANK - GCash / PayPal", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Text("₱${widget.bal.toStringAsFixed(2)}", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.green)),
      ElevatedButton.icon(onPressed: ()=>widget.earn(), icon: Icon(Icons.play_circle), label: Text("WATCH AD +₱1 - 50/50 CEO")),
      Divider(), TextField(controller: gcashCtrl, decoration: InputDecoration(labelText: "GCash No. / PayPal Email", border: OutlineInputBorder(), prefixIcon: Icon(Icons.account_balance_wallet))),
      SizedBox(height: 10), TextField(controller: amountCtrl, decoration: InputDecoration(labelText: "Amount Min ₱100", border: OutlineInputBorder(), prefixIcon: Icon(Icons.money)), keyboardType: TextInputType.number, onChanged: (v)=>setState((){})),
      if(amountCtrl.text.isNotEmpty) Card(color: Colors.orange[50], child: Padding(padding: EdgeInsets.all(10), child: Column(children: [Text("Amount: ₱${amountCtrl.text}"), Text("Fee 4.5% = ₱${feeP.toStringAsFixed(2)} -> CEO Vault MAIN_CEO_BRENT", style: TextStyle(color: Colors.orange)), Text("You Get: ₱${netP.toStringAsFixed(2)}", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18))]))),
      SizedBox(height: 10), SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: loading? null : withdraw, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: loading? CircularProgressIndicator(color: Colors.white) : Text("WITHDRAW NOW - LEGIT BANK", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
      SizedBox(height: 20), Text("Vault: MAIN_CEO_BRENT | AdMob 50/50 | Affiliate 10% | Withdraw Fee 4.5% | GitHub Build | Firebase | CEO Approved V9-V28", textAlign: TextAlign.center, style: TextStyle(fontSize: 9, color: Colors.grey)),
      StreamBuilder(stream: FirebaseFirestore.instance.collection('withdraw_requests').where('username', isEqualTo: widget.username).orderBy('timestamp', descending: true).limit(5).snapshots(), builder: (c,s){ if(!s.hasData || s.data!.docs.isEmpty) return Text("No history"); return Column(children: [Text("Withdraw History", style: TextStyle(fontWeight: FontWeight.bold)),...s.data!.docs.map((d){ var m=d.data() as Map; return Card(child: ListTile(dense: true, title: Text("₱${m['amount_requested']} -> Net ₱${m['net_to_user']}"), subtitle: Text("${m['gcash_paypal']} - ${m['status']}"), trailing: Text("Fee ₱${m['fee_4_5_percent']}", style: TextStyle(color: Colors.orange, fontSize: 10)))); }).toList()]); }),
    ]));
  }
}
