import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:geolocator/geolocator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const YappApp());
}

class YappApp extends StatefulWidget {
  const YappApp({super.key});

  @override
  State<YappApp> createState() => _YappAppState();
}

String appLang = 'ar';

final Map<String, Map<String, String>> t = {
  'ar': {
    'app_name': 'Yapp',
    'login': 'تسجيل الدخول إلى Yapp',
    'email': 'البريد الإلكتروني',
    'phone': 'رقم الهاتف',
    'search_country': 'ابحث عن اسم أو رمز الدولة...',
    'select_country': 'اختر الدولة',
    'next_photo': 'متابعة لرفع الصورة',
    'photo_title': 'توثيق الوجه في Yapp',
    'photo_desc': 'الرجاء رفع صورة الوجه الشخصية',
    'photo_valid': 'تم قبول صورة الوجه ✅',
    'photo_invalid': 'مرفوض: تم رصد أزهار أو حيوانات ❌',
    'btn_flower': 'تجربة رفع زهرة/حيوان',
    'btn_face': 'التقاط وجه حقيقي',
    'enter_feed': 'الدخول إلى Yapp ➔',
    'blurred_lock': 'الصور محجوبة 🔒\nيجب رفع صورتك لتتمكن من الرؤية',
    'rate_title': 'تقييم 5 نجوم ⭐',
    'rate_desc': 'قيم Yapp بـ 5 نجوم لفتح 2 إعجاب فوراً!',
    'rate_btn': 'تقييم (+2)',
    'ad_title': 'نفدت الإعجابات!',
    'ad_desc': 'شاهد إعلاناً قصيراً لفتح 2 إعجاب.',
    'ad_btn': 'مشاهدة الإعلان (+2)',
    'chat_title': 'دردشة Yapp الحصرية',
    'chat_hint': 'ابدأ الـ Yap واكتب رسالتك...',
    'banner': 'مساحة إعلان البانر (AdMob Banner)',
    'admin_title': 'لوحة تحكم مدير Yapp',
    'loc_title': 'تحديد الموقع الجغرافي',
    'loc_desc': 'نحتاج موقعك لنعرض لك الأشخاص القريبين منك',
    'loc_btn': 'السماح بالوصول للموقع',
    'loc_success': 'تم تحديد موقعك بنجاح 📍',
  },
  'en': {
    'app_name': 'Yapp',
    'login': 'Sign In to Yapp',
    'email': 'Email address',
    'phone': 'Phone number',
    'search_country': 'Search country or code...',
    'select_country': 'Select Country',
    'next_photo': 'Proceed to Photo',
    'photo_title': 'Face Verification',
    'photo_desc': 'Please upload your face photo',
    'photo_valid': 'Face Verified ✅',
    'photo_invalid': 'Rejected: Flowers/Animals ❌',
    'btn_flower': 'Test Flower/Animal',
    'btn_face': 'Capture Real Face',
    'enter_feed': 'Enter Yapp ➔',
    'blurred_lock': 'Photos Locked 🔒\nUpload your photo to view others',
    'rate_title': 'Rate 5 Stars ⭐',
    'rate_desc': 'Rate us 5 stars for 2 free likes!',
    'rate_btn': 'Rate (+2)',
    'ad_title': 'Out of Likes!',
    'ad_desc': 'Watch an ad to get 2 likes.',
    'ad_btn': 'Watch Ad (+2)',
    'chat_title': 'Yapp Chat',
    'chat_hint': 'Start yapping...',
    'banner': 'AdMob Banner Ad Space',
    'admin_title': 'Super Admin Panel',
    'loc_title': 'Location Access',
    'loc_desc': 'We need your location to find nearby people',
    'loc_btn': 'Allow Location Access',
    'loc_success': 'Location acquired successfully 📍',
  }
};

class _YappAppState extends State<YappApp> {
  void switchLanguage(String code) {
    setState(() => appLang = code);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yapp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink),
      home: AuthView(onLangChange: switchLanguage),
    );
  }
}

final List<Map<String, String>> allWorldCountries = [
  {'code': '+212', 'flag': '🇲🇦', 'name': 'Morocco / المغرب'},
  {'code': '+213', 'flag': '🇩🇿', 'name': 'Algeria / الجزائر'},
  {'code': '+216', 'flag': '🇹🇳', 'name': 'Tunisia / تونس'},
  {'code': '+20',  'flag': '🇪🇬', 'name': 'Egypt / مصر'},
  {'code': '+966', 'flag': '🇸🇦', 'name': 'Saudi Arabia / السعودية'},
  {'code': '+971', 'flag': '🇦🇪', 'name': 'UAE / الإمارات'},
];

List<Map<String, String>> chatLogs = [];
String myEmail = '';
bool hasFace = false;
int likes = 10;
int outCount = 0;
bool rated = false;
String userLocationStr = 'Pending location...';

class AuthView extends StatefulWidget {
  final Function(String) onLangChange;
  const AuthView({super.key, required this.onLangChange});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final eCtrl = TextEditingController();
  final pCtrl = TextEditingController();
  Map<String, String> selectedCountry = allWorldCountries[0];

  void proceed() {
    if (eCtrl.text.isEmpty || pCtrl.text.isEmpty) return;
    myEmail = eCtrl.text.trim().toLowerCase();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LocationPermissionView()));
  }

  @override
  Widget build(BuildContext context) {
    final tr = t[appLang] ?? t['en']!;

    return Scaffold(
      appBar: AppBar(
        title: Text(tr['app_name']!),
        backgroundColor: Colors.pinkAccent,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: (val) {
              widget.onLangChange(val);
              setState(() {});
            },
            itemBuilder: (ctx) => const [
              PopupMenuItem(value: 'ar', child: Text('العربية')),
              PopupMenuItem(value: 'en', child: Text('English')),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(tr['login']!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(controller: eCtrl, decoration: InputDecoration(labelText: tr['email']!, border: const OutlineInputBorder())),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextField(controller: pCtrl, keyboardType: TextInputType.phone, decoration: InputDecoration(labelText: tr['phone']!, border: const OutlineInputBorder())),
                ),
              ],
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, foregroundColor: Colors.white),
                onPressed: proceed,
                child: Text(tr['next_photo']!),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// صفحة طلب الموقع الجغرافي
class LocationPermissionView extends StatefulWidget {
  const LocationPermissionView({super.key});

  @override
  State<LocationPermissionView> createState() => _LocationPermissionViewState();
}

class _LocationPermissionViewState extends State<LocationPermissionView> {
  bool isLoading = false;

  Future<void> askLocation() async {
    setState(() => isLoading = true);
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => isLoading = false);
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => isLoading = false);
        return;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      setState(() => isLoading = false);
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      userLocationStr = 'Lat: ${position.latitude.toStringAsFixed(2)}, Lng: ${position.longitude.toStringAsFixed(2)} (Nearby Active 📍)';
      isLoading = false;
    });

    if (!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PhotoView()));
  }

  @override
  Widget build(BuildContext context) {
    final tr = t[appLang] ?? t['en']!;

    return Scaffold(
      appBar: AppBar(title: Text(tr['loc_title']!), backgroundColor: Colors.pinkAccent),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, size: 80, color: Colors.pinkAccent),
            const SizedBox(height: 20),
            Text(tr['loc_desc']!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, foregroundColor: Colors.white),
                      onPressed: askLocation,
                      child: Text(tr['loc_btn']!),
                    ),
                  ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PhotoView())),
              child: const Text('Skip for now / تخطي مؤقتاً'),
            )
          ],
        ),
      ),
    );
  }
}

class PhotoView extends StatefulWidget {
  const PhotoView({super.key});
  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  String? resultText;

  void testPic(bool isHuman) {
    final tr = t[appLang] ?? t['en']!;
    setState(() {
      hasFace = isHuman;
      resultText = isHuman ? tr['photo_valid']! : tr['photo_invalid']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tr = t[appLang] ?? t['en']!;

    return Scaffold(
      appBar: AppBar(title: Text(tr['photo_title']!), backgroundColor: Colors.pinkAccent),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                resultText ?? tr['photo_desc']!,
                textAlign: TextAlign.center,
                style: TextStyle(color: hasFace ? Colors.green : (resultText == null ? Colors.black87 : Colors.red), fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () => testPic(false), child: Text(tr['btn_flower']!)),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, foregroundColor: Colors.white),
                    onPressed: () => testPic(true),
                    child: Text(tr['btn_face']!),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              TextButton(
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const FeedView())),
                child: Text(tr['enter_feed']!),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FeedView extends StatefulWidget {
  const FeedView({super.key});
  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  BannerAd? _bannerAd;
  bool _isBannerLoaded = false;
  final users = ['Sara, 24 (Nearby)', 'Karim, 27 (Nearby)', 'Yasmine, 22 (Nearby)'];
  int uIdx = 0;

  @override
  void initState() {
    super.initState();
    _loadAdBanner();
  }

  void _loadAdBanner() {
    _bannerAd = BannerAd(
      // استخدام معرف اختبار AdMob حصرياً أثناء التطوير لتجنب الحظر
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', 
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => setState(() => _isBannerLoaded = true),
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  void tryLike() {
    if (likes <= 0) {
      outCount++;
      if (outCount == 2 && !rated) {
        showRate();
      } else {
        showRewardedAd();
      }
      return;
    }
    setState(() {
      likes--;
      uIdx = (uIdx + 1) % users.length;
    });
  }

  void showRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917', // Test Rewarded ID
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.show(onUserEarnedReward: (ad, reward) {
            setState(() => likes += 2);
          });
        },
        onAdFailedToLoad: (err) {},
      ),
    );
  }

  void showRate() {
    final tr = t[appLang] ?? t['en']!;
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(tr['rate_title']!),
        content: Text(tr['rate_desc']!),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                rated = true;
                likes += 2;
              });
              Navigator.pop(c);
            },
            child: Text(tr['rate_btn']!),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tr = t[appLang] ?? t['en']!;
    bool isAdmin = (myEmail == 'maisonbenbachir@gmail.com');

    return Scaffold(
      appBar: AppBar(
        title: Text('${tr['app_name']!} | ❤️ $likes'),
        backgroundColor: Colors.pinkAccent,
        actions: [
          if (isAdmin)
            IconButton(
              icon: const Icon(Icons.shield),
              tooltip: tr['admin_title']!,
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminView())),
            ),
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatView())),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(userLocationStr, style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 285,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.account_circle, size: 75, color: Colors.pinkAccent),
                          const SizedBox(height: 8),
                          Text(users[uIdx], style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 18),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.close, color: Colors.red, size: 30),
                                onPressed: () => setState(() => uIdx = (uIdx + 1) % users.length),
                              ),
                              IconButton(
                                icon: const Icon(Icons.favorite, color: Colors.green, size: 30),
                                onPressed: tryLike,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    if (!hasFace)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: Container(
                            width: 285,
                            height: 200,
                            color: Colors.black.withOpacity(0.55),
                            padding: const EdgeInsets.all(12),
                            child: Center(
                              child: Text(
                                tr['blurred_lock']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          if (_isBannerLoaded && _bannerAd != null)
            Container(
              alignment: Alignment.center,
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            )
          else
            Container(
              height: 45,
              color: Colors.grey[300],
              child: Center(child: Text(tr['banner']!, style: const TextStyle(fontSize: 12))),
            )
        ],
      ),
    );
  }
}

class ChatView extends StatefulWidget {
  const ChatView({super.key});
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final msgCtrl = TextEditingController();

  void send() {
    String txt = msgCtrl.text.trim();
    if (txt.isEmpty) return;
    setState(() {
      chatLogs.add({'sender': myEmail, 'msg': txt});
      msgCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tr = t[appLang] ?? t['en']!;
    return Scaffold(
      appBar: AppBar(title: Text(tr['chat_title']!), backgroundColor: Colors.pinkAccent),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatLogs.length,
              itemBuilder: (c, i) => ListTile(title: Text(chatLogs[i]['msg']!), subtitle: Text(chatLogs[i]['sender']!)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(child: TextField(controller: msgCtrl, decoration: InputDecoration(hintText: tr['chat_hint']!))),
                IconButton(icon: const Icon(Icons.send, color: Colors.pinkAccent), onPressed: send),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AdminView extends StatefulWidget {
  const AdminView({super.key});
  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  @override
  Widget build(BuildContext context) {
    final tr = t[appLang] ?? t['en']!;
    return Scaffold(
      appBar: AppBar(title: Text(tr['admin_title']!), backgroundColor: Colors.blueGrey[900]),
      body: ListView.builder(
        itemCount: chatLogs.length,
        itemBuilder: (c, i) => ListTile(
          title: Text(chatLogs[i]['msg']!),
          subtitle: Text('User: ${chatLogs[i]['sender']}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => setState(() => chatLogs.removeAt(i)),
          ),
        ),
      ),
    );
  }
}
