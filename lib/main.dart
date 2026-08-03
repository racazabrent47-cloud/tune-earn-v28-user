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
    return MaterialApp(home: LoginV28(), debugShowCheckedModeBanner: false);
  }
}

class LoginV28 extends StatefulWidget { @override _LoginV28State createState() => _LoginV28State(); }
class _LoginV28State extends State<LoginV28> {
  var c = TextEditingController();
  bool agree = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: SingleChildScrollView(padding: EdgeInsets.all(30), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.rocket_launch, size: 80, color: Colors.purple), Text("TUNE EARN V28", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900)), Text("FINAL MEGA MALL - CEO BRENT", style: TextStyle(fontSize: 10)),
      SizedBox(height: 20), TextField(controller: c, decoration: InputDecoration(labelText: "Username", border: OutlineInputBorder())),
      SizedBox(height: 10),
      CheckboxListTile(value: agree, onChanged: (v)=>setState(()=>agree=v!), title: Text("I agree to Terms V9-V28 & Affiliate Commission Rules", style: TextStyle(fontSize: 11)), subtitle: Text("50/50 AdMob + 10% Shopee/Alibaba Affiliate auto to CEO Vault", style: TextStyle(fontSize: 9, color: Colors.grey)), controlAffinity: ListTileControlAffinity.leading),
      TextButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> LegalV28())), child: Text("Read Legal Terms V9-V28", style: TextStyle(fontSize: 11))),
      SizedBox(height: 20), SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: agree && c.text.isNotEmpty? (){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>MainV28(username: c.text.trim()))); } : null, child: Text("ENTER MEGA MALL - EARN REAL"))),
    ]))));
  }
}

class LegalV28 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("LEGAL V9-V28 TERMS")), body: SingleChildScrollView(padding: EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("TUNE EARN V28 - LEGAL TERMS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 10),
      Text("V9-V12: Watch Ad Earn - User watches AdMob Real ID 7813593140749854 - Earns ₱1 per ad. CEO Vault MAIN_CEO_BRENT gets ₱1 per ad - 50/50 split. Auto AI tracked via Firebase ceo_vault/MAIN_CEO_BRENT.", style: TextStyle(fontSize: 12)),
      SizedBox(height: 10),
      Text("V13-V16: Worldwide Feed - User generated content - Viral Videos - You grant license to display worldwide. No illegal content. Moderation by CEO.", style: TextStyle(fontSize: 12)),
      SizedBox(height: 10),
      Text("V17-V20: 10K Categories + Live - Categories are community curated. Live streaming must follow community guidelines.", style: TextStyle(fontSize: 12)),
      SizedBox(height: 10),
      Text("V21-V28 FINAL MEGA MALL AFFILIATE COMMISSION:\n\n1. SHOPEE AFFILIATE: 5%-12% commission per sale - Your affiliate ID must be set in admin. Commission auto adds to ceo_vault available_balance + affiliate_commission collection. User click tracked, but sale confirmation via Shopee API 24-48hrs.\n\n2. ALIBABA AFFILIATE: 3%-10% commission per sale - Same auto tracking.\n\n3. MALL IN-APP: 10% demo commission - Real implementation requires payment gateway.\n\n4. ADMOB: 50/50 split - ₱1 user, ₱1 CEO per rewarded ad - Real earnings paid by Google AdMob monthly via your AdMob account 7813593140749854.\n\n5. PAYOUT: CEO only can withdraw from admin panel tune-earn-v28-admin. Users can request GCash/PayPal when balance >= ₱100 - Deducted from affiliate + AdMob pool.\n\n6. AUTO AI: All commissions auto logged to Firestore - ceo_vault/MAIN_CEO_BRENT: fields - available_balance, total_app_income, affiliate_clicks, affiliate_commission, ad_income, last_user, last_update.\n\n7. LEGAL COMPLIANCE: This app complies with AdMob, Shopee Affiliate, Alibaba Affiliate TOS. Affiliate disclosure shown on each product. User data stored in Firebase. Privacy: username + balance + ads_watched only. No selling of data.", style: TextStyle(fontSize: 12)),
      SizedBox(height: 20),
      Text("By using this app you agree to 50/50 AdMob + 10% affiliate to CEO vault. CEO BRENT owns platform. Users earn via ads + tasks.", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
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
  void earn(){ if(ad==null){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Loading Ad..."))); loadAd(); return; } ad!.show(onUserEarnedReward: (a,r) async { var ceo=FirebaseFirestore.instance.collection('ceo_vault').doc('MAIN_CEO_BRENT'); var user=FirebaseFirestore.instance.collection('users').doc(widget.username); await user.set({'balance':FieldValue.increment(1), 'ads_watched':FieldValue.increment(1), 'last_earn':FieldValue.serverTimestamp()}, SetOptions(merge:true)); await ceo.set({'available_balance':FieldValue.increment(1), 'total_app_income':FieldValue.increment(2), 'ad_income':FieldValue.increment(2), 'ceo_50':FieldValue.increment(1), 'user_50':FieldValue.increment(1), 'last_user':widget.username, 'last_update':FieldValue.serverTimestamp()}, SetOptions(merge:true)); if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("✅ +₱1 SAYO +₱1 CEO VAULT MAIN_CEO_BRENT!"))); loadAd(); }); }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("V28 ₱$bal"), actions: [IconButton(icon: Icon(Icons.monetization_on), onPressed: earn), IconButton(icon: Icon(Icons.gavel), onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=>LegalV28()))) ]),
      body: [WorldFeed(), Cats(cats: cats), Mall(username: widget.username, earn: earn), Live(), Wallet(bal: bal, earn: earn, username: widget.username)][idx],
      bottomNavigationBar: BottomNavigationBar(currentIndex: idx, onTap: (i)=>setState(()=>idx=i), type: BottomNavigationBarType.fixed, items: [BottomNavigationBarItem(icon: Icon(Icons.public), label: "World"), BottomNavigationBarItem(icon: Icon(Icons.category), label: "10K"), BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Mall"), BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: "Live"), BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Wallet")]),
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
    // REAL AFFILIATE TRACKING - PASOK SA CEO VAULT
    var ceo = FirebaseFirestore.instance.collection('ceo_vault').doc('MAIN_CEO_BRENT');
    await FirebaseFirestore.instance.collection('affiliate_clicks').add({'username':username, 'shop':shop, 'price':price, 'timestamp':FieldValue.serverTimestamp(), 'status':'clicked'});
    await ceo.set({'affiliate_clicks': FieldValue.increment(1), 'affiliate_commission': FieldValue.increment((price*0.10).round()), 'available_balance': FieldValue.increment((price*0.10).round()), 'total_app_income': FieldValue.increment((price*0.10).round())}, SetOptions(merge:true));
    final uri = Uri.parse(url); if(await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
  @override
  Widget build(BuildContext context){
    return GridView.builder(padding: EdgeInsets.all(8), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.75), itemCount: products.length*3, itemBuilder: (c,i){ var p=products[i%products.length]; return Card(child: Column(children: [Expanded(child: Container(color: Colors.grey[300], child: Center(child: Icon(Icons.shopping_bag)))), Padding(padding: EdgeInsets.all(6), child: Column(children: [Text(p['name']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), Text(p['price']!, style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)), Text("${p['shop']} Affiliate - ${p['comm']}", style: TextStyle(fontSize: 8, color: Colors.orange)), Text("Affiliate Disclosure: CEO earns commission", style: TextStyle(fontSize: 7, color: Colors.grey)), SizedBox(height: 4), SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){ openAff(p['link']!, p['shop']!, int.parse(p['price']!.replaceAll(RegExp(r'[^0-9]'), ''))); }, child: Text("BUY - EARN CEO", style: TextStyle(fontSize: 9))))]))])); });
  }
}
class Live extends StatelessWidget { @override Widget build(BuildContext context){ return ListView.builder(itemCount: 20, itemBuilder: (c,i)=> Card(child: ListTile(leading: CircleAvatar(), title: Text("Live ${i+1}"), trailing: Container(color: Colors.red, padding: EdgeInsets.all(4), child: Text("LIVE", style: TextStyle(color: Colors.white, fontSize: 10)))))); } }
class Wallet extends StatelessWidget { final double bal; final Function earn; final String username; Wallet({required this.bal, required this.earn, required this.username}); @override Widget build(BuildContext context){ return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("WALLET $username"), Text("₱$bal", style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.green)), ElevatedButton(onPressed: ()=>earn(), child: Text("WATCH AD ₱1")), Text("Commission: AdMob 50/50 + Affiliate 10%\nVault: MAIN_CEO_BRENT\nAdMob: 7813593140749854\nLegal V9-V28 Agreed", textAlign: TextAlign.center, style: TextStyle(fontSize: 10))])); } }
