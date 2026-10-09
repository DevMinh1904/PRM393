import 'package:flutter/material.dart';

void main() {
  runApp(const MomoApp());
}

// MoMo Brand Colors
const Color momoPrimary = Color(0xFFA50064);
const Color momoPinkLight = Color(0xFFD82D8B);
const Color momoBackground = Color(0xFFF5F5F7);

class MomoApp extends StatelessWidget {
  const MomoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoMo Super App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: momoPrimary,
        scaffoldBackgroundColor: momoBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: momoPrimary,
          primary: momoPrimary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: momoPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// ============================================================================
// SHARED PAYMENT DIALOG
// ============================================================================
void showPaymentDialog(
  BuildContext context, {
  required String serviceName,
  required String details,
  required String amount,
}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 28),
          SizedBox(width: 8),
          Text('Xác nhận thanh toán', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dịch vụ: $serviceName', style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text('Chi tiết: $details', style: const TextStyle(color: Colors.black87)),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Số tiền thanh toán:', style: TextStyle(fontSize: 14)),
              Text(
                amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: momoPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: momoPrimary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            Navigator.pop(ctx);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Thanh toán thành công: $amount qua Ví MoMo!'),
                backgroundColor: momoPrimary,
              ),
            );
          },
          child: const Text('Xác nhận'),
        ),
      ],
    ),
  );
}

// ============================================================================
// 1. HOME SCREEN
// ============================================================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {
        'title': 'Chuyển tiền',
        'icon': Icons.send_rounded,
        'color': Colors.blue,
        'action': () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tính năng Chuyển tiền')),
            ),
      },
      {
        'title': 'Thanh toán\nhóa đơn',
        'icon': Icons.receipt_long_rounded,
        'color': Colors.orange,
        'action': () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BillServicesScreen()),
            ),
      },
      {
        'title': 'Nạp tiền\nđiện thoại',
        'icon': Icons.phone_android_rounded,
        'color': Colors.green,
        'action': () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PhoneTopUpScreen()),
            ),
      },
      {
        'title': 'Vé xem phim',
        'icon': Icons.movie_creation_outlined,
        'color': Colors.purple,
        'action': () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MovieBookingScreen()),
            ),
      },
      {
        'title': 'Du lịch -\nĐi lại',
        'icon': Icons.flight_takeoff_rounded,
        'color': Colors.teal,
        'action': () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TravelBookingScreen()),
            ),
      },
      {
        'title': 'Tất cả\ndịch vụ',
        'icon': Icons.grid_view_rounded,
        'color': momoPrimary,
        'action': () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tất cả các dịch vụ tiện ích')),
            ),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white24,
              child: Icon(Icons.person, color: Colors.white),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Xin chào,', style: TextStyle(fontSize: 12)),
                Text(
                  'NGUYEN VAN A',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // MoMo Balance Card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [momoPrimary, momoPinkLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Số dư MoMo', style: TextStyle(color: Colors.white70, fontSize: 13)),
                      SizedBox(height: 4),
                      Text(
                        '5.250.000 đ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: momoPrimary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle, size: 18),
                    label: const Text('Nạp tiền', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

            // Grid Services
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Dịch vụ MoMo',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: services.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.85,
                        ),
                        itemBuilder: (context, index) {
                          final item = services[index];
                          final color = item['color'] as Color;
                          return InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: item['action'] as VoidCallback,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: color.withValues(alpha: 0.12),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    item['icon'] as IconData,
                                    size: 28,
                                    color: color,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item['title'] as String,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 2. BILL SERVICES MENU SCREEN
// ============================================================================
class BillServicesScreen extends StatelessWidget {
  const BillServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final billItems = [
      {
        'title': 'Hóa đơn Điện',
        'subtitle': 'EVN toàn quốc, hoàn tiền & chiết khấu',
        'icon': Icons.bolt_rounded,
        'color': Colors.amber.shade700,
        'page': const ElectricityBillScreen(),
      },
      {
        'title': 'Hóa đơn Nước',
        'subtitle': 'Cấp nước các tỉnh thành và khu vực',
        'icon': Icons.water_drop_rounded,
        'color': Colors.blueAccent,
        'page': const WaterBillScreen(),
      },
      {
        'title': 'Internet & Truyền hình',
        'subtitle': 'VNPT, Viettel, FPT Telecom, SCTV',
        'icon': Icons.wifi_rounded,
        'color': Colors.purple,
        'page': const InternetBillScreen(),
      },
      {
        'title': 'Học phí & Giáo dục',
        'subtitle': 'Thanh toán học phí các trường mầm non - đại học',
        'icon': Icons.school_rounded,
        'color': Colors.teal,
        'page': const EducationBillScreen(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán hóa đơn'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: billItems.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = billItems[index];
          final color = item['color'] as Color;
          return Card(
            elevation: 1,
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(item['icon'] as IconData, color: color),
              ),
              title: Text(
                item['title'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                item['subtitle'] as String,
                style: const TextStyle(fontSize: 12),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => item['page'] as Widget),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ============================================================================
// 2.1 HÓA ĐƠN ĐIỆN
// ============================================================================
class ElectricityBillScreen extends StatefulWidget {
  const ElectricityBillScreen({super.key});

  @override
  State<ElectricityBillScreen> createState() => _ElectricityBillScreenState();
}

class _ElectricityBillScreenState extends State<ElectricityBillScreen> {
  final _customerCodeController = TextEditingController(text: 'PE0100023456');
  String _provider = 'EVN Miền Bắc';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán tiền Điện'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.bolt_rounded, size: 54, color: Colors.amber.shade800),
                  ),
                  const SizedBox(height: 12),
                  const Text('Tổng công ty Điện lực Việt Nam',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Text('Tra cứu & thanh toán cước điện sinh hoạt',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Nhà cung cấp', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _provider,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: 'EVN Miền Bắc', child: Text('EVN Miền Bắc')),
                    DropdownMenuItem(value: 'EVN Hà Nội', child: Text('EVN TP. Hà Nội')),
                    DropdownMenuItem(value: 'EVN Miền Nam', child: Text('EVN Miền Nam')),
                    DropdownMenuItem(value: 'EVN TP.HCM', child: Text('EVN TP. Hồ Chí Minh')),
                  ],
                  onChanged: (val) => setState(() => _provider = val!),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Mã khách hàng (Mã PE)', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _customerCodeController,
              decoration: InputDecoration(
                hintText: 'Ví dụ: PE01000...',
                prefixIcon: const Icon(Icons.badge_outlined),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: momoPrimary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  showPaymentDialog(
                    context,
                    serviceName: 'Hóa đơn Điện ($_provider)',
                    details: 'Mã KH: ${_customerCodeController.text}',
                    amount: '348.000 đ',
                  );
                },
                child: const Text('Kiểm tra & Thanh toán',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 2.2 HÓA ĐƠN NƯỚC
// ============================================================================
class WaterBillScreen extends StatefulWidget {
  const WaterBillScreen({super.key});

  @override
  State<WaterBillScreen> createState() => _WaterBillScreenState();
}

class _WaterBillScreenState extends State<WaterBillScreen> {
  final _waterCodeController = TextEditingController(text: 'DB992103');
  String _waterCompany = 'Cấp nước Sông Đà (Viwasupco)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán tiền Nước'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.water_drop_rounded, size: 54, color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 12),
                  const Text('Công ty Cấp Thoát Nước',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Text('Thanh toán định kỳ tiền nước sinh hoạt',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Đơn vị cấp nước', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _waterCompany,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: 'Cấp nước Sông Đà (Viwasupco)', child: Text('Cấp nước Sông Đà')),
                    DropdownMenuItem(value: 'Nước sạch Hà Nội (Hawacom)', child: Text('Nước sạch Hà Nội')),
                    DropdownMenuItem(value: 'Sawaco TP. Hồ Chí Minh', child: Text('Sawaco TP. HCM')),
                  ],
                  onChanged: (val) => setState(() => _waterCompany = val!),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Mã danh bộ / Mã khách hàng', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _waterCodeController,
              decoration: InputDecoration(
                hintText: 'Nhập mã danh bộ...',
                prefixIcon: const Icon(Icons.pin_outlined),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: momoPrimary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  showPaymentDialog(
                    context,
                    serviceName: 'Hóa đơn Nước ($_waterCompany)',
                    details: 'Mã danh bộ: ${_waterCodeController.text}',
                    amount: '112.500 đ',
                  );
                },
                child: const Text('Kiểm tra & Thanh toán',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 2.3 HÓA ĐƠN INTERNET & TRUYỀN HÌNH
// ============================================================================
class InternetBillScreen extends StatefulWidget {
  const InternetBillScreen({super.key});

  @override
  State<InternetBillScreen> createState() => _InternetBillScreenState();
}

class _InternetBillScreenState extends State<InternetBillScreen> {
  final _contractController = TextEditingController(text: 'FPT-HN-88421');
  String _provider = 'FPT Telecom';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internet & Truyền hình'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.wifi_rounded, size: 54, color: Colors.purple),
                  ),
                  const SizedBox(height: 12),
                  const Text('Cước Internet & Truyền hình Cáp',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Text('Thanh toán tức thì, không lo gián đoạn kết nối',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Nhà cung cấp mạng', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _provider,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: 'FPT Telecom', child: Text('FPT Telecom')),
                    DropdownMenuItem(value: 'Viettel Telecom', child: Text('Viettel Telecom')),
                    DropdownMenuItem(value: 'VNPT Internet', child: Text('VNPT Internet')),
                    DropdownMenuItem(value: 'SCTV Truyền hình Cáp', child: Text('SCTV Truyền hình Cáp')),
                  ],
                  onChanged: (val) => setState(() => _provider = val!),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Số hợp đồng / Mã khách hàng', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _contractController,
              decoration: InputDecoration(
                hintText: 'Nhập số hợp đồng internet...',
                prefixIcon: const Icon(Icons.router_outlined),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: momoPrimary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  showPaymentDialog(
                    context,
                    serviceName: 'Cước Internet ($_provider)',
                    details: 'Hợp đồng: ${_contractController.text}',
                    amount: '220.000 đ',
                  );
                },
                child: const Text('Kiểm tra & Thanh toán',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 2.4 HỌC PHÍ & GIÁO DỤC
// ============================================================================
class EducationBillScreen extends StatefulWidget {
  const EducationBillScreen({super.key});

  @override
  State<EducationBillScreen> createState() => _EducationBillScreenState();
}

class _EducationBillScreenState extends State<EducationBillScreen> {
  final _studentIdController = TextEditingController(text: 'SV2026889');
  String _institution = 'Đại học FPT';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Học phí & Giáo dục'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.school_rounded, size: 54, color: Colors.teal),
                  ),
                  const SizedBox(height: 12),
                  const Text('Cổng thanh toán Học phí',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Text('Thanh toán học phí, lệ phí thi trực tuyến',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Trường học / Đơn vị giáo dục', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _institution,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: 'Đại học FPT', child: Text('Đại học FPT')),
                    DropdownMenuItem(value: 'Đại học Bách Khoa', child: Text('Đại học Bách Khoa')),
                    DropdownMenuItem(value: 'Đại học Kinh tế Quốc dân', child: Text('Đại học Kinh tế Quốc dân')),
                    DropdownMenuItem(value: 'Hệ thống Vinschool', child: Text('Hệ thống Vinschool')),
                  ],
                  onChanged: (val) => setState(() => _institution = val!),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Mã số học sinh / sinh viên (MSSV)', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _studentIdController,
              decoration: InputDecoration(
                hintText: 'Nhập mã sinh viên...',
                prefixIcon: const Icon(Icons.account_box_outlined),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: momoPrimary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  showPaymentDialog(
                    context,
                    serviceName: 'Học phí ($_institution)',
                    details: 'Mã SV: ${_studentIdController.text} - Kỳ Fall 2026',
                    amount: '4.500.000 đ',
                  );
                },
                child: const Text('Tra cứu & Đóng học phí',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 3. NẠP TIỀN ĐIỆN THOẠI (10k, 20k, 50k, 100k, 200k, 500k)
// ============================================================================
class PhoneTopUpScreen extends StatefulWidget {
  const PhoneTopUpScreen({super.key});

  @override
  State<PhoneTopUpScreen> createState() => _PhoneTopUpScreenState();
}

class _PhoneTopUpScreenState extends State<PhoneTopUpScreen> {
  final _phoneController = TextEditingController(text: '0988 123 456');
  final List<int> _denominations = [10000, 20000, 50000, 100000, 200000, 500000];
  int _selectedAmount = 50000;
  String _telco = 'Viettel';

  String _formatCurrency(int amount) {
    if (amount >= 1000) {
      return '${amount ~/ 1000}.000 đ';
    }
    return '$amount đ';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nạp tiền điện thoại'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Số điện thoại
            const Text('Số điện thoại nhận tiền', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone_iphone_rounded, color: momoPrimary),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.contacts_rounded, color: Colors.grey),
                  onPressed: () {},
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Chọn nhà mạng
            const Text('Nhà mạng', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: ['Viettel', 'Vinaphone', 'Mobifone'].map((name) {
                final isSelected = _telco == name;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(name),
                      selected: isSelected,
                      selectedColor: momoPrimary.withValues(alpha: 0.15),
                      labelStyle: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? momoPrimary : Colors.black87,
                      ),
                      onSelected: (selected) {
                        if (selected) setState(() => _telco = name);
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Chọn mệnh giá nạp
            const Text('Chọn mệnh giá nạp', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _denominations.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.6,
              ),
              itemBuilder: (context, index) {
                final amount = _denominations[index];
                final isSelected = _selectedAmount == amount;
                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => setState(() => _selectedAmount = amount),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? momoPrimary.withValues(alpha: 0.1) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? momoPrimary : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _formatCurrency(amount),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? momoPrimary : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 36),

            // Nút nạp tiền
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: momoPrimary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  showPaymentDialog(
                    context,
                    serviceName: 'Nạp ĐT $_telco',
                    details: 'SĐT: ${_phoneController.text}',
                    amount: _formatCurrency(_selectedAmount),
                  );
                },
                child: Text(
                  'Nạp ngay ${_formatCurrency(_selectedAmount)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 4. ĐẶT VÉ XEM PHIM (3 PHIM LAB 5 + THANH TOÁN)
// ============================================================================
class MovieItem {
  final int id;
  final String title;
  final String posterUrl;
  final String genre;
  final double rating;
  final String price;

  const MovieItem({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.genre,
    required this.rating,
    required this.price,
  });
}

class MovieBookingScreen extends StatelessWidget {
  const MovieBookingScreen({super.key});

  final List<MovieItem> movies = const [
    MovieItem(
      id: 1,
      title: 'Inception (Kẻ Đánh Cắp Giấc Mơ)',
      posterUrl: 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?auto=format&fit=crop&w=800&q=80',
      genre: 'Khoa học viễn tưởng, Hành động',
      rating: 8.8,
      price: '95.000 đ',
    ),
    MovieItem(
      id: 2,
      title: 'Interstellar (Hố Đen Tử Thần)',
      posterUrl: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=800&q=80',
      genre: 'Phiêu lưu, Tâm lý',
      rating: 8.7,
      price: '105.000 đ',
    ),
    MovieItem(
      id: 3,
      title: 'The Dark Knight (Kỵ Sĩ Bóng Đêm)',
      posterUrl: 'https://images.unsplash.com/photo-1509281373149-e957c6296406?auto=format&fit=crop&w=800&q=80',
      genre: 'Hành động, Tội phạm',
      rating: 9.0,
      price: '110.000 đ',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vé xem phim'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: movies.length,
        separatorBuilder: (_, _) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            clipBehavior: Clip.antiAlias,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  movie.posterUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    height: 160,
                    color: Colors.grey[800],
                    child: const Center(child: Icon(Icons.movie, size: 50, color: Colors.white54)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              movie.title,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 18),
                              const SizedBox(width: 4),
                              Text('${movie.rating}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(movie.genre, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Giá từ', style: TextStyle(fontSize: 11, color: Colors.grey)),
                              Text(
                                movie.price,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: momoPrimary),
                              ),
                            ],
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: momoPrimary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () {
                              showPaymentDialog(
                                context,
                                serviceName: 'Vé xem phim CGV',
                                details: '${movie.title} • Ghế VIP G12 • Suất 19:30',
                                amount: movie.price,
                              );
                            },
                            icon: const Icon(Icons.confirmation_number_outlined, size: 16),
                            label: const Text('Đặt vé & Thanh toán'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ============================================================================
// 5. ĐẶT VÉ DU LỊCH (ĐIỂM ĐI / ĐẾN: TP HCM, HÀ NỘI, ĐÀ NẴNG + THANH TOÁN)
// ============================================================================
class TravelBookingScreen extends StatefulWidget {
  const TravelBookingScreen({super.key});

  @override
  State<TravelBookingScreen> createState() => _TravelBookingScreenState();
}

class _TravelBookingScreenState extends State<TravelBookingScreen> {
  final List<String> _cities = ['TP. Hồ Chí Minh', 'Hà Nội', 'Đà Nẵng'];
  String _fromCity = 'TP. Hồ Chí Minh';
  String _toCity = 'Đà Nẵng';
  String _transportType = 'Vé máy bay';
  String _travelDate = '15/10/2026';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Du lịch - Đi lại'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card chọn chuyến đi
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Loại phương tiện
                    Row(
                      children: ['Vé máy bay', 'Vé tàu hỏa', 'Vé xe khách'].map((mode) {
                        final isSelected = _transportType == mode;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: ChoiceChip(
                              label: Text(mode, style: const TextStyle(fontSize: 11)),
                              selected: isSelected,
                              selectedColor: momoPrimary.withValues(alpha: 0.15),
                              labelStyle: TextStyle(
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? momoPrimary : Colors.black87,
                              ),
                              onSelected: (selected) {
                                if (selected) setState(() => _transportType = mode);
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),

                    // Điểm đi
                    const Text('Điểm khởi hành', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<String>(
                      initialValue: _fromCity,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.flight_takeoff, color: momoPrimary),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: _cities.map((city) {
                        return DropdownMenuItem(value: city, child: Text(city));
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _fromCity = val!;
                          if (_fromCity == _toCity) {
                            _toCity = _cities.firstWhere((c) => c != _fromCity);
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Nút đổi chiều
                    Center(
                      child: IconButton(
                        icon: const Icon(Icons.swap_vert_circle, color: momoPrimary, size: 36),
                        onPressed: () {
                          setState(() {
                            final temp = _fromCity;
                            _fromCity = _toCity;
                            _toCity = temp;
                          });
                        },
                      ),
                    ),

                    // Điểm đến
                    const Text('Điểm đến', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<String>(
                      initialValue: _toCity,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.flight_land, color: Colors.blue),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: _cities.map((city) {
                        return DropdownMenuItem(value: city, child: Text(city));
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _toCity = val!;
                          if (_toCity == _fromCity) {
                            _fromCity = _cities.firstWhere((c) => c != _toCity);
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Ngày khởi hành
                    const Text('Ngày khởi hành', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 4),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.grey.shade400),
                      ),
                      leading: const Icon(Icons.calendar_month, color: momoPrimary),
                      title: Text(_travelDate, style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: const Text('Thay đổi', style: TextStyle(color: momoPrimary)),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now().add(const Duration(days: 3)),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 90)),
                        );
                        if (picked != null) {
                          setState(() {
                            _travelDate = '${picked.day}/${picked.month}/${picked.year}';
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Nút tìm và thanh toán
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: momoPrimary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  showPaymentDialog(
                    context,
                    serviceName: '$_transportType: $_fromCity ➔ $_toCity',
                    details: 'Khởi hành: $_travelDate • Hạng Phổ thông',
                    amount: '1.250.000 đ',
                  );
                },
                child: const Text('Tìm chuyến & Thanh toán',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
