import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// قاعدة بيانات وهمية للأرقام المسجلة مسبقاً لمنع التكرار
final Set<String> registeredPhones = {};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const YappApp());
}

class YappApp extends StatelessWidget {
  const YappApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yapp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      home: const AuthView(),
    );
  }
}

String appLang = 'ar';
final Map<String, Map<String, String>> t = {
  'ar': {
    'app_name': 'Yapp',
    'login': 'إنشاء حساب جديد',
    'subtitle': 'التسجيل برقم الهاتف فقط',
    'phone_hint': 'رقم الهاتف',
    'dob': 'تاريخ الميلاد (مثال: 1995/05/12)',
    'next_step': 'إرسال كود التحقق SMS',
    'phone_exists': 'هذا الرقم مسجل مسبقاً ولديه حساب بالفعل ⚠️',
    'verify_title': 'تأكيد رقم الهاتف',
    'verify_desc': 'أدخل كود الـ SMS المرسل إلى هاتفك',
    'verify_sms': 'كود الـ SMS (اكتب أي 4 أرقام للتجربة)',
    'verify_btn': 'تأكيد ودخول',
    'photo_title': 'توثيق الحساب بالصورة',
    'photo_desc': 'الرجاء رفع صورة حقيقية للوجه لتفعيل حسابك',
    'photo_valid': 'تم التحقق بنجاح ✅',
    'photo_invalid': 'مرفوض: صور الحيوانات/الزهور غير مقبولة ❌',
    'btn_flower': 'تجربة صورة خطأ (زهرة)',
    'btn_face': 'التقاط الوجه الحقيقي',
    'enter_feed': 'الانتقال للرئيسية ➔',
    'blurred_lock': 'الصور مقفلة 🔒\nيجب توثيق صورتك لرؤية الآخرين',
    'loc_title': 'صلاحية الموقع والتنبيهات',
    'loc_desc': 'نحتاج موقعك للأشخاص القريبين وتفعيل التنبيهات للإشارات',
    'loc_btn': 'السماح بالموقع والتنبيهات',
    'rate_title': 'تقييم التطبيق ⭐',
    'rate_desc': 'قيم Yapp بـ 5 نجوم واحصل على (+2 إعجاب مجاني)!',
    'rate_btn': 'قيم الآن والحصول على إعجابات',
  },
  'en': {
    'app_name': 'Yapp',
    'login': 'Create Account',
    'subtitle': 'Register with phone number only',
    'phone_hint': 'Phone Number',
    'dob': 'Date of Birth (e.g., 1995/05/12)',
    'next_step': 'Send SMS Verification Code',
    'phone_exists': 'This phone number is already registered ⚠️',
    'verify_title': 'Verify Phone',
    'verify_desc': 'Enter the SMS code sent to your phone',
    'verify_sms': 'SMS Code',
    'verify_btn': 'Verify & Enter',
    'photo_title': 'Face Verification',
    'photo_desc': 'Please upload a real face photo',
    'photo_valid': 'Verified Successfully ✅',
    'photo_invalid': 'Rejected: Flowers/Animals not allowed ❌',
    'btn_flower': 'Test Invalid (Flower)',
    'btn_face': 'Capture Real Face',
    'enter_feed': 'Go to Feed ➔',
    'blurred_lock': 'Photos Locked 🔒\nVerify photo to view others',
    'loc_title': 'Location & Notifications',
    'loc_desc': 'We need location for nearby users and notifications',
    'loc_btn': 'Allow Location & Notifications',
    'rate_title': 'Rate App ⭐',
    'rate_desc': 'Rate 5 stars to get (+2 free likes)!',
    'rate_btn': 'Rate & Get Likes',
  }
};

String selectedCountryCode = '+212';
String myPhone = '';
String myDob = '';
bool hasFace = false;
int likes = 10;
String userLocationStr = 'Location pending...';

class AuthView extends StatefulWidget {
  const AuthView({super.key});
  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final pCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  String? errorMsg;

  void proceed() {
    final tr = t[appLang] ?? t['en']!;
    if (pCtrl.text.isEmpty || dobCtrl.text.isEmpty) return;
    
    final fullPhone = '$selectedCountryCode${pCtrl.text.trim()}';

    // التحقق من عدم تكرار رقم الهاتف مسبقاً
    if (registeredPhones.contains(fullPhone)) {
      setState(() {
        errorMsg = tr['phone_exists'];
      });
      return;
    }

    myPhone = fullPhone;
    myDob = dobCtrl.text.trim();
    registeredPhones.add(myPhone); // تسجيل الرقم في القاعدة

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const VerificationView()));
  }

  @override
  Widget build(BuildContext context) {
    final tr = t[appLang] ?? t['en']!;
    return Scaffold(
      appBar: AppBar(title: Text(tr['app_name']!), backgroundColor: Colors.pinkAccent, centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(tr['login']!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.pinkAccent)),
                  const SizedBox(height: 5),
                  Text(tr['subtitle']!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 20),
                  if (errorMsg != null)
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.red.shade50,
                      child: Text(errorMsg!, style: const TextStyle(color: Colors.red, fontSize: 12), textAlign: TextAlign.center),
                    ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton<String>(
                          value: selectedCountryCode,
                          underline: const SizedBox(),
                          items: const [
                            DropdownMenuItem(value: '+212', child: Text('+212 (MA)')),
                            DropdownMenuItem(value: '+33', child: Text('+33 (FR)')),
                            DropdownMenuItem(value: '+966', child: Text('+966 (SA)')),
                            DropdownMenuItem(value: '+1', child: Text('+1 (US)')),
                          ],
                          onChanged: (val) => setState(() => selectedCountryCode = val!),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: pCtrl,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(labelText: tr['phone_hint']!, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), prefixIcon: const Icon(Icons.phone)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextField(controller: dobCtrl, decoration: InputDecoration(labelText: tr['dob']!, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), prefixIcon: const Icon(Icons.calendar_today))),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    onPressed: proceed,
                    child: Text(tr['next_step']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});
  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final smsCtrl = TextEditingController();

  void verifyCodes() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LocationPermissionView()));
  }

  @override
  Widget build(BuildContext context) {
    final tr = t[appLang] ?? t['en']!;
    return Scaffold(
      appBar: AppBar(title: Text(tr['verify_title']!), backgroundColor: Colors.pinkAccent, centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(tr['verify_desc']!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 20),
                  TextField(controller: smsCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: tr['verify_sms']!, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), prefixIcon: const Icon(Icons.sms))),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    onPressed: verifyCodes,
                    child: Text(tr['verify_btn']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LocationPermissionView extends StatefulWidget {
  const LocationPermissionView({super.key});
  @override
  State<LocationPermissionView> createState() => _LocationPermissionViewState();
}

class _LocationPermissionViewState extends State<LocationPermissionView> {
  Future<void> askPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission != LocationPermission.denied) {
        Position position = await Geolocator.getCurrentPosition();
        userLocationStr = 'Lat: ${position.latitude.toStringAsFixed(2)}, Lng: ${position.longitude.toStringAsFixed(2)} 📍';
      }
    }

    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (androidImplementation != null) {
      await androidImplementation.requestNotificationsPermission();
    }

    if (!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PhotoView()));
  }

  @override
  Widget build(BuildContext context) {
    final tr = t[appLang] ?? t['en']!;
    return Scaffold(
      appBar: AppBar(title: Text(tr['loc_title']!), backgroundColor: Colors.pinkAccent, centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.notifications_active, size: 70, color: Colors.pinkAccent),
                  const SizedBox(height: 20),
                  Text(tr['loc_desc']!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    onPressed: askPermissions,
                    child: Text(tr['loc_btn']!, style: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
          ),
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
      appBar: AppBar(title: Text(tr['photo_title']!), backgroundColor: Colors.pinkAccent, centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(resultText ?? tr['photo_desc']!, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: hasFace ? Colors.green : Colors.black87)),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade200, foregroundColor: Colors.black), onPressed: () => testPic(false), child: Text(tr['btn_flower']!)),
                      const SizedBox(width: 10),
                      ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, foregroundColor: Colors.white), onPressed: () => testPic(true), child: Text(tr['btn_face']!)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const FeedView())), child: Text(tr['enter_feed']!, style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)))
                ],
              ),
            ),
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
  final users = ['Sara, 24 (Nearby)', 'Karim, 27 (Nearby)', 'Yasmine, 22 (Nearby)'];
  int uIdx = 0;

  void tryLike() {
    setState(() {
      likes--;
      uIdx = (uIdx + 1) % users.length;
    });
    _showNotification();
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('yapp_notifs', 'Yapp Alerts',
            channelDescription: 'Notifications for new likes',
            importance: Importance.max,
            priority: Priority.high);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'إعجاب جديد في Yapp! ❤️',
      'أحدهم أبدى إعجابه بك!',
      platformChannelSpecifics,
    );
  }

  void showRateDialog(BuildContext context) {
    final tr = t[appLang] ?? t['en']!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr['rate_title']!),
        content: Text(tr['rate_desc']!),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                likes += 2; // إضافة 2 إعجاب مجاني عند التقييم
              });
              Navigator.pop(context);
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
    return Scaffold(
      appBar: AppBar(
        title: Text('${tr['app_name']!} | ❤️ $likes'),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () => showRateDialog(context),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$userLocationStr | DOB: $myDob', style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      width: 300,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.account_circle, size: 85, color: Colors.pinkAccent),
                          const SizedBox(height: 10),
                          Text(users[uIdx], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(backgroundColor: Colors.red.shade50, child: IconButton(icon: const Icon(Icons.close, color: Colors.red), onPressed: () => setState(() => uIdx = (uIdx + 1) % users.length))),
                              CircleAvatar(backgroundColor: Colors.green.shade50, child: IconButton(icon: const Icon(Icons.favorite, color: Colors.green), onPressed: tryLike)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  if (!hasFace)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          width: 300,
                          height: 220,
                          color: Colors.black.withOpacity(0
