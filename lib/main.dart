import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(const YappApp());

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
  },
  'fr': {
    'app_name': 'Yapp',
    'login': 'Connexion à Yapp',
    'email': 'E-mail',
    'phone': 'Numéro de téléphone',
    'search_country': 'Rechercher un pays ou indicatif...',
    'select_country': 'Choisir le pays',
    'next_photo': 'Continuer vers photo',
    'photo_title': 'Vérification Faciale',
    'photo_desc': 'Veuillez télécharger votre photo de profil',
    'photo_valid': 'Visage validé ✅',
    'photo_invalid': 'Rejeté: Fleurs/Animaux ❌',
    'btn_flower': 'Tester Fleur/Animal',
    'btn_face': 'Prendre un visage réel',
    'enter_feed': 'Entrer dans Yapp ➔',
    'blurred_lock': 'Photos floutées 🔒\nAjoutez votre photo pour débloquer',
    'rate_title': 'Noter Yapp ⭐',
    'rate_desc': 'Donnez 5 étoiles pour 2 likes gratuits!',
    'rate_btn': 'Noter (+2)',
    'ad_title': 'Plus de likes!',
    'ad_desc': 'Regardez une pub pour 2 likes.',
    'ad_btn': 'Voir la pub (+2)',
    'chat_title': 'Discussion Yapp',
    'chat_hint': 'Tapez un message...',
    'banner': 'Bannière Publicitaire (AdMob)',
    'admin_title': 'Admin Yapp',
  },
  'es': {
    'app_name': 'Yapp',
    'login': 'Iniciar Sesión',
    'email': 'Correo electrónico',
    'phone': 'Teléfono',
    'search_country': 'Buscar país o prefijo...',
    'select_country': 'Seleccionar país',
    'next_photo': 'Continuar a foto',
    'photo_title': 'Verificación Facial',
    'photo_desc': 'Sube tu foto de rostro',
    'photo_valid': 'Rostro validado ✅',
    'photo_invalid': 'Rechazado: Flores/Animales ❌',
    'btn_flower': 'Probar Flor/Animal',
    'btn_face': 'Tomar rostro real',
    'enter_feed': 'Entrar a Yapp ➔',
    'blurred_lock': 'Fotos bloqueadas 🔒\nSube tu foto para ver',
    'rate_title': 'Calificar Yapp ⭐',
    'rate_desc': '¡Califica 5 estrellas y obtén 2 likes!',
    'rate_btn': 'Calificar (+2)',
    'ad_title': '¡Sin likes!',
    'ad_desc': 'Mira un anuncio para 2 likes.',
    'ad_btn': 'Ver anuncio (+2)',
    'chat_title': 'Chat Yapp',
    'chat_hint': 'Escribe un mensaje...',
    'banner': 'Banner Publicitario (AdMob)',
    'admin_title': 'Panel Admin',
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
  },
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
  {'code': '+974', 'flag': '🇶🇦', 'name': 'Qatar / قطر'},
  {'code': '+965', 'flag': '🇰🇼', 'name': 'Kuwait / الكويت'},
  {'code': '+968', 'flag': '🇴🇲', 'name': 'Oman / عمان'},
  {'code': '+973', 'flag': '🇧🇭', 'name': 'Bahrain / البحرين'},
  {'code': '+962', 'flag': '🇯🇴', 'name': 'Jordan / الأردن'},
  {'code': '+961', 'flag': '🇱🇧', 'name': 'Lebanon / لبنان'},
  {'code': '+964', 'flag': '🇮🇶', 'name': 'Iraq / العراق'},
  {'code': '+970', 'flag': '🇵🇸', 'name': 'Palestine / فلسطين'},
  {'code': '+218', 'flag': '🇱🇾', 'name': 'Libya / ليبيا'},
  {'code': '+222', 'flag': '🇲🇷', 'name': 'Mauritania / موريتانيا'},
  {'code': '+249', 'flag': '🇸🇩', 'name': 'Sudan / السودان'},
  {'code': '+967', 'flag': '🇾🇪', 'name': 'Yemen / اليمن'},
  {'code': '+33',  'flag': '🇫🇷', 'name': 'France / فرنسا'},
  {'code': '+34',  'flag': '🇪🇸', 'name': 'Spain / إسبانيا'},
  {'code': '+39',  'flag': '🇮🇹', 'name': 'Italy / إيطاليا'},
  {'code': '+49',  'flag': '🇩🇪', 'name': 'Germany / ألمانيا'},
  {'code': '+44',  'flag': '🇬🇧', 'name': 'United Kingdom / بريطانيا'},
  {'code': '+1',   'flag': '🇺🇸', 'name': 'USA / أمريكا'},
  {'code': '+1',   'flag': '🇨🇦', 'name': 'Canada / كندا'},
  {'code': '+32',  'flag': '🇧🇪', 'name': 'Belgium / بلجيكا'},
  {'code': '+31',  'flag': '🇳🇱', 'name': 'Netherlands / هولندا'},
  {'code': '+41',  'flag': '🇨🇭', 'name': 'Switzerland / سويسرا'},
  {'code': '+351', 'flag': '🇵🇹', 'name': 'Portugal / البرتغال'},
  {'code': '+90',  'flag': '🇹🇷', 'name': 'Turkey / تركيا'},
  {'code': '+7',   'flag': '🇷🇺', 'name': 'Russia / روسيا'},
  {'code': '+86',  'flag': '🇨🇳', 'name': 'China / الصين'},
  {'code': '+91',  'flag': '🇮🇳', 'name': 'India / الهند'},
  {'code': '+55',  'flag': '🇧🇷', 'name': 'Brazil / البرازيل'},
  {'code': '+52',  'flag': '🇲🇽', 'name': 'Mexico / المكسيك'},
  {'code': '+221', 'flag': '🇸🇳', 'name': 'Senegal / السنغال'},
  {'code': '+225', 'flag': '🇨🇮', 'name': 'Ivory Coast / ساحل العاج'},
];

List<Map<String, String>> chatLogs = [];
String myEmail = '';
bool hasFace = false;
int likes = 10;
int outCount = 0;
bool rated = false;

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

  void openCountryPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        String searchQuery = '';
        return StatefulBuilder(
          builder: (context, setModalState) {
            final filtered = allWorldCountries.where((c) {
              final q = searchQuery.toLowerCase();
              return c['name']!.toLowerCase().contains(q) || c['code']!.contains(q);
            }).toList();

            return Container(
              height: 480,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(t[appLang]!['select_country']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      hintText: t[appLang]!['search_country']!,
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    onChanged: (val) => setModalState(() => searchQuery = val),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (ctx, i) {
                        final item = filtered[i];
                        return ListTile(
                          leading: Text(item['flag']!, style: const TextStyle(fontSize: 24)),
                          title: Text(item['name']!),
                          trailing: Text(item['code']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent)),
                          onTap: () {
                            setState(() => selectedCountry = item);
                            Navigator.pop(ctx);
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  void proceed() {
    if (eCtrl.text.isEmpty || pCtrl.text.isEmpty) return;
    myEmail = eCtrl.text.trim().toLowerCase();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PhotoView()));
  }

  @override
  Widget build(BuildContext context) {
    final tr = t[appLang]!;

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
              PopupMenuItem(value: 'fr', child: Text('Français')),
              PopupMenuItem(value: 'es', child: Text('Español')),
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
                InkWell(
                  onTap: openCountryPicker,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Text(selectedCountry['flag']!, style: const TextStyle(fontSize: 20)),
                        const SizedBox(width: 4),
                        Text(selectedCountry['code']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
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

class PhotoView extends StatefulWidget {
  const PhotoView({super.key});
  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  String? resultText;

  void testPic(bool isHuman) {
    final tr = t[appLang]!;
    setState(() {
      hasFace = isHuman;
      resultText = isHuman ? tr['photo_valid']! : tr['photo_invalid']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tr = t[appLang]!;

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
  final users = ['Sara, 24', 'Karim, 27', 'Yasmine, 22'];
  int uIdx = 0;

  void tryLike() {
    if (likes <= 0) {
      outCount++;
      if (outCount == 2 && !rated) {
        showRate();
      } else {
        showAd();
      }
      return;
    }
    setState(() {
      likes--;
      uIdx = (uIdx + 1) % users.length;
    });
  }

  void showRate() {
    final tr = t[appLang]!;
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

  void showAd() {
    final tr = t[appLang]!;
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(tr['ad_title']!),
        content: Text(tr['ad_desc']!),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() => likes += 2);
              Navigator.pop(c);
            },
            child: Text(tr['ad_btn']!),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tr = t[appLang]!;
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
  final banned = ['واتساب', 'whatsapp', 'انستا', 'انستغرام', 'instagram', 'تيك توك', 'tiktok', 'سناب', 'snap'];

  void send() {
    String txt = msgCtrl.text.trim();
    if (txt.isEmpty) return;

    for (var b in banned) {
      if (txt.toLowerCase().contains(b)) {
        showDialog(
          context: context,
          builder: (c) => const AlertDialog(title: Text('Security'), content: Text('Links/Apps are strictly forbidden!')),
        );
        return;
      }
    }

    if (RegExp(r'\d{6,}').hasMatch(txt.replaceAll(' ', ''))) {
      showDialog(
        context: context,
        builder: (c) => const AlertDialog(title: Text('Security'), content: Text('Phone numbers are strictly prohibited!')),
      );
      return;
    }

    setState(() {
      chatLogs.add({'sender': myEmail, 'msg': txt});
      msgCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tr = t[appLang]!;

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
    final tr = t[appLang]!;

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
