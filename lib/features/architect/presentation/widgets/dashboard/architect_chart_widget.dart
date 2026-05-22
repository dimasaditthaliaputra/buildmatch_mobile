import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:buildmatch_mobile/core/theme/app_colors.dart';
import 'package:buildmatch_mobile/core/theme/app_text_styles.dart';
import 'package:buildmatch_mobile/core/widgets/global_card.dart';

class ArchitectChartWidget extends StatefulWidget {
  final Map<String, dynamic> chartData;

  const ArchitectChartWidget({super.key, required this.chartData});

  @override
  State<ArchitectChartWidget> createState() => _ArchitectChartWidgetState();
}

class _ArchitectChartWidgetState extends State<ArchitectChartWidget> {
  final PageController _pageController = PageController(viewportFraction: 0.93);
  int _activeToggleIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Grafik',
            style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 350,
          child: PageView(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            children: [
              // ---------------------------------------------------------------
              // SLIDE 1: GRAFIK KEUANGAN (LINE CHART MANUAL)
              // ---------------------------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: GlobalCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Grafik Keuangan', style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: AppColors.textDark)),
                                Text('6 bulan terakhir', style: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryBlack, fontSize: 11)),
                              ],
                            ),
                            Row(
                              children: [
                                _buildToggleBadge('Tahun', _activeToggleIndex == 0, 0),
                                const SizedBox(width: 4),
                                _buildToggleBadge('Bulan', _activeToggleIndex == 1, 1),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        Expanded(
                          child: Row(
                            children: [
                              // Sumbu Y Kiri (Nominal Angka)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  _buildYAxisLabel('500jt'),
                                  _buildYAxisLabel('400jt'),
                                  _buildYAxisLabel('300jt'),
                                  _buildYAxisLabel('200jt'),
                                  _buildYAxisLabel('100jt'),
                                  const SizedBox(height: 16),
                                ],
                              ),
                              const SizedBox(width: 8),
                              // Grid dan Garis Grafik
                              Expanded(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: CustomPaint(
                                        size: Size.infinite,
                                        painter: ManualLineChartPainter(),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Sumbu X Bawah (Bulan)
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('JAN', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                        Text('FEB', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                        Text('MAR', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                        Text('APR', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                        Text('MEI', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                        Text('JUN', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                        Text('JUL', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // 💡 PERBAIKAN: Garis oranye penunjuk legenda dihilangkan
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Pendapatan',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: const Color(0xFFF36F13), // Langsung pakai warna teks oranye sebagai penanda
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Bulan lalu',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: const Color(0xFFFCD3B6), 
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              // ---------------------------------------------------------------
              // SLIDE 2: GRAFIK STATUS PROYEK (DONUT CHART)
              // ---------------------------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: GlobalCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Grafik Proyek', style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: AppColors.textDark)),
                        Text('Status proyek aktif', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMid, fontSize: 11)),
                        const SizedBox(height: 20),
                        
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Center(
                                  child: SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: CustomPaint(
                                      painter: ManualDonutChartPainter(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildDonutLegend(const Color(0xFFF36F13), 'Aktif (3)'),
                                    const SizedBox(height: 10),
                                    _buildDonutLegend(const Color(0xFF3B621F), 'Selesai (2)'),
                                    const SizedBox(height: 10),
                                    _buildDonutLegend(const Color(0xFFFCECD9), 'Pending (1)'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFDF8F4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem('24', 'Selesai'),
                              _buildStatDivider(),
                              _buildStatItem('3', 'Aktif'),
                              _buildStatDivider(),
                              _buildStatItem('4.9', 'Rating'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildYAxisLabel(String text) {
    return Text(text, style: const TextStyle(fontSize: 10, color: Colors.grey));
  }

  Widget _buildToggleBadge(String label, bool isSelected, int index) {
    return GestureDetector(
      onTap: () => setState(() => _activeToggleIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFCECD9) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isSelected ? const Color(0xFFD46210) : AppColors.textMid),
        ),
      ),
    );
  }

  Widget _buildDonutLegend(Color color, String label) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Color(0xFF7A5936), fontWeight: FontWeight.bold, fontSize: 12)),
      ],
    );
  }

  Widget _buildStatItem(String value, String title) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFD46210))),
        const SizedBox(height: 2),
        Text(title, style: TextStyle(fontSize: 11, color: AppColors.textMid, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(width: 1, height: 24, color: const Color(0xFFF2E2D5));
  }
}

class ManualLineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.15)
      ..strokeWidth = 1;

    double stepY = size.height / 4;
    for (int i = 0; i <= 4; i++) {
      double y = stepY * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    double stepX = size.width / 6;
    
    // Titik data fiktif disesuaikan skala kurva gambar asli Anda (Meliuk naik dari kiri ke kanan)
    List<Offset> mainLineSpots = [
      Offset(stepX * 0, size.height * 0.78), // JAN
      Offset(stepX * 1, size.height * 0.72), // FEB
      Offset(stepX * 2, size.height * 0.52), // MAR
      Offset(stepX * 3, size.height * 0.60), // APR
      Offset(stepX * 4, size.height * 0.28), // MEI
      Offset(stepX * 5, size.height * 0.22), // JUN
      Offset(stepX * 6, size.height * 0.05), // JUL
    ];

    final mainLinePaint = Paint()
      ..color = const Color(0xFFF36F13)
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final mainPath = Path()..moveTo(mainLineSpots[0].dx, mainLineSpots[0].dy);
    for (var i = 1; i < mainLineSpots.length; i++) {
      mainPath.lineTo(mainLineSpots[i].dx, mainLineSpots[i].dy);
    }
    canvas.drawPath(mainPath, mainLinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ManualDonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius - 8);

    final paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..color = const Color(0xFFF36F13);

    final paint2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..color = const Color(0xFF3B621F);

    final paint3 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..color = const Color(0xFFFCECD9);

    canvas.drawArc(rect, -math.pi / 2, 2.2, false, paint1); 
    canvas.drawArc(rect, -math.pi / 2 + 2.2, 1.9, false, paint2); 
    canvas.drawArc(rect, -math.pi / 2 + 2.2 + 1.9, 2.18, false, paint3); 
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}