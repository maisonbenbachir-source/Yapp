import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    'subtitle': 'أدخل معلوماتك للبدء بالاستكشاف',
    'email': 'البريد الإلكتروني',
    'phone': 'رقم الهاتف (للتحقق SMS)',
    'dob': 'تاريخ الميلاد (مثال: 1995/05/12)',
    'next_step': 'متابعة وإرسال الرموز',
    'verify_title': 'تأكيد الحساب',
    'verify_desc': 'أدخل الرمز المرسل لهاتفك وإيميلك',
    'verify_sms': 'رمز الـ SMS',
    'verify_email': 'رمز تفعيل الإيميل',
    'verify_btn': 'تأكيد ودخول',
    'photo_title': 'توثيق الحساب بالصورة',
    'photo_desc': 'الرجاء رفع صورة حقيقية للوجه لتفعيل حسابك',
    'photo_valid': 'تم التحقق بنجاح ✅',
    'photo_invalid': 'مرفوض: صور الحيوانات/الزهور غير مقبولة ❌',
    'btn_flower': 'تجربة صورة خطأ (زهرة)',
    'btn_face': 'التقاط الوجه الحقيقي',
    'enter_feed': 'الانتقال للرئيسية ➔',
    'blurred_lock': 'الصور مقفلة 🔒\nيجب توثيق صورتك لرؤية الآخرين',
    'loc_title': 'تحديد الموقع الجغرافي',
    'loc_desc': 'نحتاج لمعرفة موقعك لنعرض لك الأشخاص القريبين منك',
    'loc_btn': 'السماح بالوصول للموقع',
  },
  'en': {
    'app_name': 'Yapp',
    'login': 'Create Account',
    'subtitle': 'Enter your details to start',
    'email': 'Email Address',
    'phone': 'Phone Number (SMS)',
    'dob': 'Date of Birth (e.g., 1995/05/12)',
    'next_step': 'Proceed & Send Codes',
    'verify_title': 'Account Verification',
    'verify_desc': 'Enter codes sent to your phone & email',
    'verify_sms': 'SMS Code',
    'verify_email': 'Email Code',
    'verify_btn': 'Verify & Enter',
    'photo_title': 'Face Verification',
    'photo_desc': 'Please upload a real face photo',
    'photo_valid': 'Verified Successfully ✅',
    'photo_invalid': 'Rejected: Flowers/Animals not allowed ❌',
    'btn_flower': 'Test Invalid (Flower)',
    'btn_face': 'Capture Real Face',
    'enter_feed': 'Go to Feed ➔',
    'blurred_lock': 'Photos Locked 🔒\nVerify photo to view others',
    'loc_title': 'Location Access',
    'loc_desc': 'We need your location to show nearby people',
    'loc_btn': 'Allow Location',
  }
};

String myEmail = '';
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
  final eCtrl = TextEditingController();
  final pCtrl = TextEditingController();
  final dobCtrl = TextEditingController();

  void proceed() {
    if (eCtrl.text.isEmpty || pCtrl.text.isEmpty || dobCtrl.text.isEmpty) return;
    myEmail = eCtrl.text.trim();
    myPhone = pCtrl.text.trim();
    myDob = dobCtrl.text.trim();
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
                  const SizedBox(height: 25),
                  TextField(controller: eCtrl, decoration: InputDecoration(labelText: tr['email']!, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), prefixIcon: const Icon(Icons.email))),
                  const SizedBox(height: 15),
                  TextField(controller: pCtrl, keyboardType: TextInputType.phone, decoration: InputDecoration(labelText: tr['phone']!, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), prefixIcon: const Icon(Icons.phone))),
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
  final emailCtrl = TextEditingController();

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
                  const SizedBox(height: 15),
                  TextField(controller: emailCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: tr['verify_email']!, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), prefixIcon: const Icon(Icons.mark_email_read))),
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
  Future<void> askLocation() async {
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
                  const Icon(Icons.location_on, size: 70, color: Colors.pinkAccent),
                  const SizedBox(height: 20),
                  Text(tr['loc_desc']!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    onPressed: askLocation,
                    child: Text(tr['loc_btn']!, style: const TextStyle(fontSize: 15)),
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
  }

  @override
  Widget build(BuildContext context) {
    final tr = t[appLang] ?? t['en']!;
    return Scaffold(
      appBar: AppBar(title: Text('${tr['app_name']!} | ❤️ $likes | DOB: $myDob'), backgroundColor: Colors.pinkAccent),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(userLocationStr, style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
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
                          color: Colors.black.withOpacity(0.55),
                          child: Center(
                            child: Text(tr['blurred_lock']!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
