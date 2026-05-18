import 'package:flutter/material.dart';
import '../widgets/dashboard/dashboard_header.dart';
import '../widgets/dashboard/active_project_card.dart';
import '../widgets/dashboard/request_card.dart';
import '../widgets/dashboard/financial_chart.dart';
import 'architect_project_page.dart';

class ArchitectDashboardPage extends StatelessWidget {
  const ArchitectDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// HEADER
            const DashboardHeader(),

            const SizedBox(height: 20),

            /// ACTIVE PROJECT
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ActiveProjectCard(),
            ),

            const SizedBox(height: 28),

            /// TITLE REQUEST
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    const Text(
                      "Permintaan Baru",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ArchitectProjectPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "LIHAT SEMUA",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
            ),

            const SizedBox(height: 14),

            /// REQUEST CARD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [

                  const RequestCard(
                    title: "Minimalis Studio Office",
                    location: "Jakarta Selatan",
                    price: "Rp 450 - 500jt",
                    size: "120 m²",
                  ),

                  const SizedBox(height: 18),

                  const RequestCard(
                    title: "Tropical Retreat Villa",
                    location: "Ubud, Bali",
                    price: "Rp 2M - 3.5M",
                    size: "350 m²",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            /// FINANCIAL CHART
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const FinancialChart(),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      /// BOTTOM NAVBAR
bottomNavigationBar: Container(
  height: 72,

  decoration: const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
    ),
  ),

  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [

      _navItem(
        icon: Icons.home_rounded,
        label: "Beranda",
        active: true,
      ),

      _navItem(
        icon: Icons.description_outlined,
        label: "Projek",
      ),

      _navItem(
        icon: Icons.shopping_cart_outlined,
        label: "Inbox",
      ),

      _navItem(
        icon: Icons.person_outline,
        label: "Pengaturan",
      ),
    ],
  ),
),
    );
  }

Widget _navItem({
  required IconData icon,
  required String label,
  bool active = false,
}) {
  return SizedBox(
    width: 70,

    child: Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,

      children: [

        /// ICON ACTIVE FLOATING
        if (active)
          Positioned(
            top: -18,

            child: Container(
              width: 54,
              height: 54,

              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                ),
              ),

              child: const Icon(
                Icons.home_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),

        /// ITEM NORMAL
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(height: active ? 18 : 0),

            if (!active)
              Icon(
                icon,
                color: Colors.black54,
                size: 24,
              ),

            const SizedBox(height: 6),

            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: active
                    ? Colors.orange
                    : Colors.black54,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
}