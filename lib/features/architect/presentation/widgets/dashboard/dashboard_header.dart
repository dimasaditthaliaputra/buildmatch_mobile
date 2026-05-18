import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Stack(
        clipBehavior: Clip.none,
        children: [

          /// ORANGE HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 100),
            decoration: const BoxDecoration(
              color: Color(0xFFFF8A00),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// TOP BAR
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      children: [

                        const CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.white24,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [

                            Text(
                              "Arsitek Dashboard",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(height: 2),

                            Text(
                              "BuildMatch",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                /// WELCOME TEXT
                const Text(
                  "Selamat Datang,\nUrbanCore",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    height: 1.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          /// FLOATING CARD
          Positioned(
            left: 20,
            right: 20,
            bottom: 0,

            child: Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: const Color(0xFFFFF3EF),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// TOP CARD
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      const Text(
                        "BELUM CAIR",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF9C5200),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.hourglass_empty_rounded,
                          color: Color(0xFF7A3E00),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  /// DOTS + EYE
                  Row(
                    children: [

                      ...List.generate(
                        5,
                        (index) => Container(
                          width: 12,
                          height: 12,
                          margin: const EdgeInsets.only(right: 6),
                          decoration: const BoxDecoration(
                            color: Color(0xFF7A3E00),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),

                      const SizedBox(width: 6),

                      const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Color(0xFF3E1F00),
                        size: 22,
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    "3 transaksi menunggu",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF9C5200),
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// INDICATOR
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        width: 18,
                        height: 6,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B00),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),

                      const SizedBox(width: 6),

                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.orange.shade200,
                          shape: BoxShape.circle,
                        ),
                      ),

                      const SizedBox(width: 6),

                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.orange.shade200,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
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