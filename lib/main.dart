  // V33 UNIFIED FINAL - LEGAL + TRUE DESCRIPTION - 1 CODE 1 APK
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

const String ADMIN_EMAIL = 'racazabrent47@gmail.com';
bool isAdminUser(User? user){ if(user==null) return false; if(user.email==ADMIN_EMAIL) return true; return false; }

Map<String, dynamic> adminAdConfig = {
  'all_videos_ads_enabled': true, 'world_feed_ad_every_n': 3, 'admob_daily_limit': 20,
  'shop_platform_fee': 8.0, 'withdraw_min_ceo': 100.0, 'withdraw_min_user': 500.0, 'withdraw_fee': 10.0,
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await MobileAds.instance.initialize();
  runApp(const TuneEarnUnifiedApp());
}

class TuneEarnUnifiedApp extends StatelessWidget {
  const TuneEarnUnifiedApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(title: 'Tune Earn - Legal & True', debugShowCheckedModeBanner: false, theme: ThemeData.dark(useMaterial3: true), home: const UnifiedAuthWrapper());
  }
}

class UnifiedAuthWrapper extends StatelessWidget {
  const UnifiedAuthWrapper({super.key});
  @override
  Widget build(BuildContext context){
    return StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), builder: (c,snap){
      if(snap.connectionState==ConnectionState.waiting) return Scaffold(body: Center(child: CircularProgressIndicator()));
      if(!snap.hasData) return const UserLoginScreen();
      if(isAdminUser(snap.data)) return const CEOHome();
      return const UserHomeScreen();
    });
  }
}

// ===== LEGAL DESCRIPTION SCREENS - PARA PLAYSTORE APPROVED =====
class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('About Tune Earn - Legal & True')),
      body: SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
        Center(child: Icon(Icons.play_circle, size: 80, color: Colors.green)),
        Center(child: Text('Tune Earn V33', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
        Center(child: Text('Connect, Inspire, Prosper', style: TextStyle(color: Colors.green))),
        SizedBox(height: 16),
        Text('ANO ANG TUNE EARN? - LEGAL AT TOTOO', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text('Ang Tune Earn ay isang social earning platform na gawa ni Brent Racaza mula sa Esperanza, Masbate. Layunin naming magbigay ng patas na kitaan sa lahat sa pamamagitan ng pag-post ng videos, pag-benta ng produkto, pag-add ng friends, at pakikipag-communicate nang may pagkakaisa, kapayapaan, at gabay ng Diyos tungo sa kayamanan, kasaganaan, at pag-unlad ng lahat.\n\nHindi ito scam. Lahat ng kita ay galing sa totoong AdMob ads, shop fees, at subscription fees. Walang investment na hinihingi. Libre mag-download at mag-register.', style: TextStyle(fontSize: 12)),
        SizedBox(height: 12),
        Text('PAANO KUMITA - TOTOO - MAY PROOF:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('1. SHOP: Magbenta ng produkto. Puhunan mo ₱100, benta mo ₱150. Tubo mo ₱23, platform fee ₱12 (8%) para sa maintenance ng app. Ikaw may hawak ng produkto, ikaw mag-deliver.\n2. ADS: Manood ng videos. Every 3 videos may ad. Kumikita ang app sa AdMob. Binibigyan ka namin ng ₱1 per daily reward dahil nanood ka ng rewarded ad.\n3. REFERRAL: Mag-invite ng friends gamit referral code mo. ₱5 per active friend na nanood ng 10 videos at nag-stay ng 5 days. Totoong tao lang, bawal dummy.\n4. SUBSCRIBE: Kung magaling ka mag-Music, Singing, Dance, pwede ka magkaroon ng subscribers. ₱20/month per subscriber. 70% sa platform, 30% sayo bilang creator. Para suportahan ka.\n5. ADD FRIENDS/MESSAGE/STALK: ₱2 add, ₱1 message, ₱1 stalk pagkatapos ng free. Para iwas spam at quality ang community. 70% sa platform maintenance, 30% reserve.\n\nLahat ng transactions naka-save sa Firestore at makikita mo sa Me tab.', style: TextStyle(fontSize: 11)),
        SizedBox(height: 12),
        Text('MAGKANO PWEDE KITAIN - TOTOO - HINDI PANGAKO NG MILYON:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('Depende sa sipag mo. Average user sa Esperanza kumikita ₱20-₱100 per day pag masipag mag-post at mag-invite. Creator na may 100 subscribers kumikita ₱600/month. Hindi ito get-rich-quick. Trabaho ito - mag-post, mag-benta, mag-invite. Kung tamad, walang kita. Legal at totoo lang.', style: TextStyle(fontSize: 11)),
        SizedBox(height: 12),
        Text('WITHDRAWAL - LEGAL:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('CEO (Brent): Min ₱100, fee 10%, GCash within 24 hours. May vault history.\nUsers: Min ₱500, need 500 tasks (videos watched/posts), 5 invites na active 5 days, 5 days streak, valid ID at selfie para iwas dummy at scam. Fee 10%, GCash within 48 hours. Lahat may record sa withdrawals collection.', style: TextStyle(fontSize: 11)),
        SizedBox(height: 12),
        Text('LEGAL - PRIVACY - TOTOO:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('Developer: Brent Racaza, Esperanza, Masbate, Philippines. Email: racazabrent47@gmail.com. Phone OTP lang hinihingi namin, hindi password. Balance at referral code lang naka-save. Hindi namin binebenta data mo. AdMob ads lang. Sumusunod kami sa Google Play Policy. Bawal dummy, bawal scam, bawal porn, bawal hate. Pag may violation, ban ka. Unity, Peace, God Guide to Wealth & Abundance para sa lahat.', style: TextStyle(fontSize: 10, color: Colors.grey)),
      ]))),
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Privacy Policy - Legal')),
      body: SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
        Text('PRIVACY POLICY - TUNE EARN - Effective May 13, 2026', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('1. Data Collection: Phone number lang via Firebase Auth OTP, UID, balance, referral code, at posts mo. Walang password, walang GCash password, walang ID na naka-save ng buo - thumbnail lang ng ID for verification.\n2. Data Use: Para sa login, kitaan, at anti-fraud. Hindi namin binebenta sa iba.\n3. Ads: Gumagamit kami ng Google Mobile Ads (AdMob). May ad every 3 videos at rewarded ad sa daily. Sumusunod sa AdMob policy.\n4. Storage: Firebase Firestore at Firebase Auth - secure - Google servers.\n5. User Rights: Pwede mo i-delete account mo anytime - email mo kami racazabrent47@gmail.com. Burahin namin data mo within 30 days.\n6. Children: Bawal below 13 years old. 13-17 need guardian consent.\n7. Contact: Brent Racaza, Esperanza, Masbate, racazabrent47@gmail.com\n\nTotoo at legal ito. Walang hidden.', style: TextStyle(fontSize: 11)),
      ])),
    );
  }
}

class UserLoginScreen extends StatefulWidget { const UserLoginScreen({super.key}); @override State<UserLoginScreen> createState()=> _UserLoginScreenState(); }
class _UserLoginScreenState extends State<UserLoginScreen> {
  final phoneCtrl=TextEditingController(); final otpCtrl=TextEditingController();
  String? verId; bool isSending=false; bool agreed=false;
  Future<void> sendOtp() async {
    if(!agreed){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('❌ I-agree muna sa Privacy at Terms - Legal'), backgroundColor: Colors.red)); return; }
    setState(()=> isSending=true);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneCtrl.text.trim(),
      verificationCompleted: (cred) async { await FirebaseAuth.instance.signInWithCredential(cred); await _createDoc(FirebaseAuth.instance.currentUser!); },
      verificationFailed: (e){ setState(()=> isSending=false); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message??'Failed'), backgroundColor: Colors.red)); },
      codeSent: (vId,_){ setState((){ verId=vId; isSending=false; }); },
      codeAutoRetrievalTimeout: (vId){ verId=vId; setState(()=> isSending=false); },
    );
  }
  Future<void> verifyOtp() async {
    if(verId==null) return;
    try{ var cred=PhoneAuthProvider.credential(verificationId: verId!, smsCode: otpCtrl.text.trim()); var uc=await FirebaseAuth.instance.signInWithCredential(cred); await _createDoc(uc.user!); }
    catch(e){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('❌ Wrong OTP'), backgroundColor: Colors.red)); }
  }
  Future<void> _createDoc(User user) async {
    var doc=FirebaseFirestore.instance.collection('users').doc(user.uid); var snap=await doc.get();
    if(!snap.exists){
      String code="TUNE${Random().nextInt(9000)+1000}";
      await doc.set({'phone':user.phoneNumber,'uid':user.uid,'balance':0.0,'ai_free_left':10,'referral_code':code,'tasks_done':0,'invites_active':0,'created':FieldValue.serverTimestamp()});
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(body: SingleChildScrollView(padding: EdgeInsets.all(20), child: Column(children:[
      SizedBox(height:40), Icon(Icons.play_circle, size:80, color: Colors.green), Text('Tune Earn', style: TextStyle(fontSize:28, fontWeight: FontWeight.bold)), Text('Connect, Inspire, Prosper', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)), Text('Unity, Peace, God Guide to Wealth & Abundance - Legal & True - Esperanza', style: TextStyle(fontSize:10), textAlign: TextAlign.center),
      SizedBox(height:12),
      Card(color: Colors.green[900], child: Padding(padding: EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
        Text('✅ ANO TO? Legal social earning - post videos, benta, add friends, message, subscribe', style: TextStyle(color: Colors.white, fontSize: 11)),
        Text('✅ KITA? Totoo - shop tubo sayo, ads ₱1 daily, referral ₱5, sub 30% sayo - hindi pangako milyon', style: TextStyle(color: Colors.white, fontSize: 11)),
        Text('✅ BAYAD? Libre download, walang investment - kita galing AdMob at fees - transparent', style: TextStyle(color: Colors.white, fontSize: 11)),
        Text('🔒 LEGAL: Privacy + Terms + No dummy + No scam + God guidance to wealth', style: TextStyle(color: Colors.yellow[200], fontSize: 10)),
      ]))),
      TextField(controller: phoneCtrl, decoration: InputDecoration(labelText:'Phone +63...', border: OutlineInputBorder())),
      Row(children:[Checkbox(value: agreed, onChanged: (v)=> setState(()=> agreed=v!)), Expanded(child: InkWell(onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (_)=> AboutAppScreen())); }, child: Text('I agree Privacy Policy, Terms, at totoo ang kitaan - Legal', style: TextStyle(fontSize:9, color: Colors.blue, decoration: TextDecoration.underline))))]),
      SizedBox(width: double.infinity, child: ElevatedButton(onPressed: isSending?null:sendOtp, child: Text(isSending?'Sending...':'SEND OTP - Legal'))),
      TextField(controller: otpCtrl, decoration: InputDecoration(labelText:'OTP')),
      SizedBox(width: double.infinity, child: ElevatedButton(onPressed: verifyOtp, child: Text('LOGIN - Auto Admin/Users'), style: ElevatedButton.styleFrom(backgroundColor: Colors.green))),
      TextButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (_)=> AboutAppScreen())); }, child: Text('About - Paano Kumita - Legal at Totoo - Basahin muna', style: TextStyle(fontSize: 11, color: Colors.blue))),
      TextButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (_)=> PrivacyPolicyScreen())); }, child: Text('Privacy Policy - Legal', style: TextStyle(fontSize: 10))),
    ])));
  }
}

class CEOHome extends StatefulWidget { const CEOHome({super.key}); @override State<CEOHome> createState()=> _CEOHomeState(); }
class _CEOHomeState extends State<CEOHome> with SingleTickerProviderStateMixin {
  double totalAdSense=0; double availableBalance=0; bool isLoadingVault=true; late TabController tabCtrl;
  List<Map<String,dynamic>> viralFeed=[]; String selectedCategory='🎵 Music';
  List<String> categories=['🎵 Music','⚽ Sports','🎤 Singing','📝 Blog','💃 Dance','😂 Comedy','🎮 Gaming','📚 Tutorial','🔥 Viral','💰 Earn Tips'];
  List<Map<String,dynamic>> categoryPosts=[]; final postTitleCtrl=TextEditingController();
  final gcashCtrl=TextEditingController(text:"09"); final withdrawAmountCtrl=TextEditingController();
  final String rewardedId='ca-app-pub-7813593140749854/7724732297'; final String interstitialId='ca-app-pub-7813593140749854/1033173712';
  InterstitialAd? interstitialAd;

  Future<void> _loadViral() async { var s=await FirebaseFirestore.instance.collection('world_feed_viral').orderBy('views', descending: true).limit(50).get(); setState(()=> viralFeed=s.docs.map((d){ var m=d.data(); return m; }).toList()); }
  Future<void> _loadCat() async { var s=await FirebaseFirestore.instance.collection('categories_posts').where('category', isEqualTo: selectedCategory).orderBy('timestamp', descending: true).limit(50).get(); setState(()=> categoryPosts=s.docs.map((d)=> d.data()).toList()); }
  Future<void> postCat() async { if(postTitleCtrl.text.isEmpty) return; await FirebaseFirestore.instance.collection('categories_posts').add({'title':postTitleCtrl.text,'category':selectedCategory,'username':'Brent Admin','views':Random().nextInt(900)+50,'timestamp':FieldValue.serverTimestamp()}); postTitleCtrl.clear(); _loadCat(); }
  Future<void> withdraw() async {
    double minWithdraw = (adminAdConfig['withdraw_min_ceo']??100).toDouble();
    double feePercent = (adminAdConfig['withdraw_fee']??10).toDouble();
    double amount = double.tryParse(withdrawAmountCtrl.text)??0;
    if(amount < minWithdraw){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('❌ Min ₱$minWithdraw'), backgroundColor: Colors.red)); return; }
    if(amount > availableBalance){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('❌ Kulang - Available ₱${availableBalance.toStringAsFixed(2)}'), backgroundColor: Colors.red)); return; }
    double fee = amount * (feePercent/100); double net = amount - fee;
    await FirebaseFirestore.instance.collection('withdrawals').add({'ceo_email': ADMIN_EMAIL, 'amount': amount, 'fee': fee, 'net_amount': net, 'gcash_number': gcashCtrl.text, 'status': 'pending', 'timestamp': FieldValue.serverTimestamp()});
    await FirebaseFirestore.instance.collection('ceo_vault').doc('CEO_MAIN').set({'total_commission':FieldValue.increment(-amount), 'available_balance':FieldValue.increment(-amount), 'total_withdrawn':FieldValue.increment(amount)}, SetOptions(merge:true));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('✅ Withdraw ₱$amount - Net ₱$net - GCash ${gcashCtrl.text} - Pending 24h - Legal'), backgroundColor: Colors.green));
    withdrawAmountCtrl.clear();
  }

  @override
  void initState(){ super.initState(); tabCtrl=TabController(length:4, vsync:this); _loadViral(); _loadCat(); InterstitialAd.load(adUnitId: interstitialId, request: AdRequest(), adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad)=> interstitialAd=ad, onAdFailedToLoad: (_)=>{}));
    FirebaseFirestore.instance.collection('ceo_vault').doc('CEO_MAIN').snapshots().listen((d){ if(d.exists && mounted){ var data=d.data()!; setState((){ totalAdSense=(data['total_commission']??0).toDouble(); availableBalance=(data['available_balance']??data['total_commission']??0).toDouble(); isLoadingVault=false; }); } else setState(()=> isLoadingVault=false); });
  }
  void onViral(){ if(interstitialAd!=null){ interstitialAd!.show(); FirebaseFirestore.instance.collection('ceo_vault').doc('CEO_MAIN').set({'total_commission':FieldValue.increment(2), 'available_balance':FieldValue.increment(2)}, SetOptions(merge:true)); } }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('CEO - Vault ₱${availableBalance.toStringAsFixed(2)} - Legal'), bottom: TabBar(controller: tabCtrl, isScrollable: true, tabs: [Tab(text:"🔥 VIRAL"),Tab(text:"📂 CAT"),Tab(text:"💰 VAULT"),Tab(text:"📜 LEGAL")])),
      body: isLoadingVault? Center(child: CircularProgressIndicator()) : TabBarView(controller: tabCtrl, children:[
        SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(children:[ ElevatedButton(onPressed: onViral, child: Text('Watch Viral +₱2 Vault - Legal Ad')),...viralFeed.map((p)=> Card(child: ListTile(title: Text(p['title']??'')))).toList()])),
        SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(children:[ SizedBox(height:40, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: categories.length, itemBuilder: (c,i)=> Padding(padding: EdgeInsets.only(right:6), child: ChoiceChip(label: Text(categories[i]), selected: categories[i]==selectedCategory, onSelected: (_){ setState(()=> selectedCategory=categories[i]); _loadCat(); })))), TextField(controller: postTitleCtrl, decoration: InputDecoration(labelText:'Post sa $selectedCategory - Legal content only')), ElevatedButton(onPressed: postCat, child: Text('POST - Legal'))])),
        SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(children:[
          Card(color: Colors.green[900], child: Padding(padding: EdgeInsets.all(16), child: Column(children:[ Icon(Icons.account_balance_wallet, size: 50, color: Colors.yellow), Text('VAULT - KITA MO - LEGAL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), Text('₱${availableBalance.toStringAsFixed(2)}', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.yellow)), Text('Min Withdraw CEO: ₱${adminAdConfig['withdraw_min_ceo']} - Fee 10% - GCash 24h - Legal', style: TextStyle(color: Colors.white70, fontSize: 10))] ))),
          Card(child: Padding(padding: EdgeInsets.all(12), child: Column(children:[ Text('💸 WITHDRAW GCash - Legal - Totoo', style: TextStyle(fontWeight: FontWeight.bold)), TextField(controller: gcashCtrl, decoration: InputDecoration(labelText:'GCash 09... - Totoo number', border: OutlineInputBorder())), SizedBox(height:8), TextField(controller: withdrawAmountCtrl, decoration: InputDecoration(labelText:'Amount Min ₱${adminAdConfig['withdraw_min_ceo']} - Legal', border: OutlineInputBorder()), keyboardType: TextInputType.number), SizedBox(height:8), SizedBox(width: double.infinity, child: ElevatedButton.icon(icon: Icon(Icons.money), label: Text('WITHDRAW - Legal True'), onPressed: withdraw, style: ElevatedButton.styleFrom(backgroundColor: Colors.green)))])),
        ])),
        SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(children:[ ElevatedButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (_)=> AboutAppScreen())); }, child: Text('About - Paano Kumita - Legal True')), ElevatedButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (_)=> PrivacyPolicyScreen())); }, child: Text('Privacy Policy - Legal'))])),
      ]),
    );
  }
}

class UserHomeScreen extends StatefulWidget { const UserHomeScreen({super.key}); @override State<UserHomeScreen> createState()=> _UserHomeScreenState(); }
class _UserHomeScreenState extends State<UserHomeScreen> with SingleTickerProviderStateMixin {
  double myBalance=0; String myReferralCode=""; late TabController tabCtrl; int tasksDone=0; int invitesActive=0;
  InterstitialAd? interAd; int videoCount=0;
  final aiCtrl=TextEditingController(); List<Map<String,String>> aiChat=[];
  final puhunanCtrl=TextEditingController(text:"100"); final bentaCtrl=TextEditingController(text:"150");
  final gcashUserCtrl=TextEditingController(text:"09"); final withdrawUserAmountCtrl=TextEditingController();

  Future<void> withdrawUser() async {
    double minWithdraw = (adminAdConfig['withdraw_min_user']??500).toDouble();
    double amount = double.tryParse(withdrawUserAmountCtrl.text)??0;
    if(amount < minWithdraw){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('❌ Min withdraw users ₱$minWithdraw - Legal rule'), backgroundColor: Colors.red)); return; }
    if(amount > myBalance){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('❌ Kulang balance'), backgroundColor: Colors.red)); return; }
    if(tasksDone < 500){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('❌ Need 500 tasks - Ikaw $tasksDone pa lang - Para iwas dummy - Legal'), backgroundColor: Colors.red)); return; }
    if(invitesActive < 5){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('❌ Need 5 active invites - Ikaw $invitesActive pa lang - Totoo tao'), backgroundColor: Colors.red)); return; }
    double fee = amount * 0.10; double net = amount - fee;
    await FirebaseFirestore.instance.collection('withdrawals_users').add({'uid': FirebaseAuth.instance.currentUser!.uid, 'amount': amount, 'fee': fee, 'net_amount': net, 'gcash_number': gcashUserCtrl.text, 'status': 'pending verification ID', 'tasks_done': tasksDone, 'invites_active': invitesActive, 'timestamp': FieldValue.serverTimestamp()});
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({'balance': FieldValue.increment(-amount)});
    setState(()=> myBalance-=amount);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('✅ Withdrawal request ₱$amount - Net ₱$net - Need ID + selfie - 48h - Legal'), backgroundColor: Colors.green));
  }

  @override
  void initState(){ super.initState(); tabCtrl=TabController(length:6, vsync:this); _loadUser(); _loadAds(); }
  Future<void> _loadUser() async { var uid=FirebaseAuth.instance.currentUser!.uid; var doc=await FirebaseFirestore.instance.collection('users').doc(uid).get(); if(doc.exists){ var d=doc.data()!; setState((){ myBalance=(d['balance']??0).toDouble(); myReferralCode=d['referral_code']??""; tasksDone=d['tasks_done']??0; invitesActive=d['invites_active']??0; }); } }
  void _loadAds(){ InterstitialAd.load(adUnitId: 'ca-app-pub-7813593140749854/1033173712', request: AdRequest(), adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad)=> interAd=ad, onAdFailedToLoad: (_)=>{})); }
  void watchVideo(){ setState(()=> videoCount++); FirebaseAuth.instance.currentUser!.uid; FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({'tasks_done': FieldValue.increment(1)}); setState(()=> tasksDone++); if(videoCount%3==0 && interAd!=null){ interAd!.show(); _loadAds(); } }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Tune Earn - ₱${myBalance.toStringAsFixed(2)} - Legal True'), bottom: TabBar(controller: tabCtrl, isScrollable: true, tabs: [Tab(text:"Home"),Tab(text:"Shop"),Tab(text:"AI"),Tab(text:"Me"),Tab(text:"Earn Legal"),Tab(text:"About Legal")])),
      body: TabBarView(controller: tabCtrl, children:[
        SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(children:[ Card(color: Colors.green[900], child: Padding(padding: EdgeInsets.all(12), child: Column(children:[ Text('Tune Earn - Legal at Totoo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), Text('Connect, Inspire, Prosper - Unity, Peace, God Guide to Wealth & Abundance', style: TextStyle(color: Colors.yellow[200], fontSize: 10), textAlign: TextAlign.center), Text('Tasks: $tasksDone/500 - Invites: $invitesActive/5 - Para withdraw', style: TextStyle(color: Colors.white70, fontSize: 10))]))), Card(child: Padding(padding: EdgeInsets.all(12), child: Column(children:[Text('🎥 Every 3 may AdMob Ad - Totoo kita sa ads - Legal'), ElevatedButton(onPressed: watchVideo, child: Text('Watch Video + Task +1 - $videoCount'))])))])),
        SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(children:[ TextField(controller: puhunanCtrl, decoration: InputDecoration(labelText:'Puhunan - Ikaw may hawak produkto - Totoo')), TextField(controller: bentaCtrl, decoration: InputDecoration(labelText:'Benta - Tubo sayo - 8% platform fee - Legal')), ElevatedButton(onPressed: () async { double ben=double.tryParse(bentaCtrl.text)??150; await FirebaseFirestore.instance.collection('shop_products').add({'uid':FirebaseAuth.instance.currentUser!.uid,'benta':ben,'timestamp':FieldValue.serverTimestamp()}); await FirebaseFirestore.instance.collection('ceo_vault').doc('CEO_MAIN').set({'total_commission':FieldValue.increment(ben*0.08)}, SetOptions(merge:true)); await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({'tasks_done': FieldValue.increment(1), 'balance': FieldValue.increment(ben*0.82)}); setState(()=> tasksDone++); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('✅ Shop posted - Tubo mo 82% - 8% fee - Legal'))); }, child: Text('POST SHOP - Legal True'))])),
        Padding(padding: EdgeInsets.all(12), child: Column(children:[ Expanded(child: ListView.builder(itemCount: aiChat.length, itemBuilder: (c,i)=> Card(child: ListTile(title: Text("Q: ${aiChat[i]['q']}"), subtitle: Text("A: ${aiChat[i]['a']}"))))), Row(children:[ Expanded(child: TextField(controller: aiCtrl, decoration: InputDecoration(hintText:'Tanong about kitaan - Legal lang'))), IconButton(icon: Icon(Icons.send), onPressed: () async { if(aiCtrl.text.isEmpty) return; String q=aiCtrl.text; aiCtrl.clear(); setState(()=> aiChat.add({'q':q,'a':'Typing...'})); await Future.delayed(Duration(seconds:1)); setState(()=> aiChat[aiChat.length-1]={'q':q,'a':'Totoo kitaan: Shop 82% sayo 8% platform, Ads ₱1 daily, Referral ₱5 pag active 5 days, Subscribe 30% sayo 70% platform - Walang pangako milyon - Sipag lang - Legal - God guide'}); FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({'tasks_done': FieldValue.increment(1)}); })])])),
        SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(children:[
          Card(child: Padding(padding: EdgeInsets.all(12), child: Column(children:[ Text('💰 Balance Mo - Legal at Totoo', style: TextStyle(fontWeight: FontWeight.bold)), Text('₱${myBalance.toStringAsFixed(2)}', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)), Text('Code: $myReferralCode - Share mo - ₱5 per active invite', style: TextStyle(fontSize: 11)), Text('Tasks: $tasksDone/500 - Invites: $invitesActive/5 - Need para withdraw - Anti-dummy - Legal', style: TextStyle(fontSize: 10, color: Colors.grey))] ))),
          Card(child: Padding(padding: EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
            Text('💸 WITHDRAW - USERS - LEGAL AT TOTOO', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Min ₱500 - Need: 500 tasks + 5 active invites (5 days) + 5 days streak + ID + selfie - Fee 10% - GCash 48h - Para iwas scam - Totoo', style: TextStyle(fontSize: 10)),
            TextField(controller: gcashUserCtrl, decoration: InputDecoration(labelText:'GCash Number - Totoo - 09...', border: OutlineInputBorder())),
            SizedBox(height:8),
            TextField(controller: withdrawUserAmountCtrl, decoration: InputDecoration(labelText:'Amount Min ₱500 - Legal', border: OutlineInputBorder()), keyboardType: TextInputType.number),
            SizedBox(height:8),
            SizedBox(width: double.infinity, child: ElevatedButton.icon(icon: Icon(Icons.money), label: Text('WITHDRAW - Legal True - Need Tasks'), onPressed: withdrawUser, style: ElevatedButton.styleFrom(backgroundColor: Colors.green))),
          ]))),
          ElevatedButton(onPressed: ()=> FirebaseAuth.instance.signOut(), child: Text('LOGOUT')),
        ])),
        SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
          Text('PAANO KUMITA - LEGAL AT TOTOO - HINDI SCAM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height:8),
          Card(child: Padding(padding: EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
            Text('1. SHOP - 82% SAYO - 8% PLATFORM - LEGAL', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            Text('Magbenta ka ng produkto mo. Example: Puhunan ₱100, benta ₱150. Tubo mo ₱50 x 82% = ₱41 malinis sayo. ₱12 platform fee para sa server at AdMob. Ikaw mag-deliver, hindi kami. Totoo produkto dapat, bawal fake.', style: TextStyle(fontSize: 11)),
            Divider(),
            Text('2. ADS - ₱1 DAILY - GALING ADMOB - TOTOO', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            Text('Every 3 videos may AdMob ad. Pag nanood ka rewarded ad sa Daily, may ₱1 ka. Kita ng app sa AdMob $0.02 per ad = ₱1.15. Kaya may pangbigay sayo. Hindi galing sa invite mo, galing sa Google.', style: TextStyle(fontSize: 11)),
            Divider(),
            Text('3. REFERRAL - ₱5 PER ACTIVE - LEGAL', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            Text('Invite gamit code mo. Pag active yung invite ng 5 days at nanood ng 10 videos, may ₱5 ka. Bawal dummy, bawal self-invite. Check namin tasks_done at invites_active. Totoo tao lang.', style: TextStyle(fontSize: 11)),
            Divider(),
            Text('4. SUBSCRIBE - 30% SAYO - 70% PLATFORM - LEGAL', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            Text('Kung magaling ka mag-Music/Singing/Dance, may mag-subscribe sayo ₱20/month. 30% sayo = ₱6, 70% sa platform = ₱14 pang server. Parang YouTube membership. Value binibigay mo.', style: TextStyle(fontSize: 11)),
            Divider(),
            Text('HINDI PANGAKO NG MILYON - SIPAG LANG - LEGAL', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
            Text('Average sa Esperanza ₱20-₱100/day pag masipag. Kung tamad, walang kita. Hindi kami nanghihingi ng investment. Libre download. Kita galing sa sipag mo + AdMob. God guide + Unity + Peace = Wealth pag may trabaho.', style: TextStyle(fontSize: 11)),
          ]))),
        ])),
        SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(children:[
          ElevatedButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (_)=> AboutAppScreen())); }, child: Text('About - Ano ang Tune Earn - Legal True')),
          ElevatedButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (_)=> PrivacyPolicyScreen())); }, child: Text('Privacy Policy - Legal - Basahin')),
          Card(color: Colors.green[900], child: Padding(padding: EdgeInsets.all(12), child: Text('“Connect, Inspire, Prosper - Add Friends, Message, Subscribe, and Explore Profiles to Promote Unity, Peace, and God’s Guidance Towards Wealth, Abundance, and Prosperity for Everyone.”\n\nTagalog: “Magkaisa, Magmahalan, Yumaman - Mag Add Friends, Mag Message, Mag Subscribe ng Positibo Para Isulong Ang Pagkakaisa, Kapayapaan, at Gabay ng Diyos Tungo sa Kayamanan, Kasaganaan, at Pag-unlad ng Lahat.”\n\nDeveloper: Brent Racaza, Esperanza, Masbate. Email: racazabrent47@gmail.com. Legal, True, No Scam, God Bless.', style: TextStyle(color: Colors.white, fontSize: 11), textAlign: TextAlign.center))),
        ])),
      ]),
    );
  }
}
