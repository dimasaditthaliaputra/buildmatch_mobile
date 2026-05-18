import 'package:flutter/material.dart';

class ActiveProjectCard extends StatelessWidget {
  const ActiveProjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// TITLE DI LUAR CARD
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [

            Text(
              "Proyek Aktif",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),

            Text(
              "LIHAT SEMUA",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        /// CARD
        Container(
          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [

                  Container(
                    width: 55,
                    height: 55,

                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text(
                          "Modern Zen Villa",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "Fase 3: Konstruksi & Pengawasan",
                          style: TextStyle(
                            color: Colors.orange.shade700,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),

                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE0B2),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: const Text(
                      "AKTIF",
                      style: TextStyle(
                        color: Color(0xFFB86A00),
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 18),

              const Text(
                "65%",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),

              const SizedBox(height: 8),

              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const LinearProgressIndicator(
                  value: 0.65,
                  minHeight: 8,
                  backgroundColor: Color(0xFFFFE0B2),
                  valueColor: AlwaysStoppedAnimation(
                    Color(0xFFFF8A00),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(
                    "Mulai Jan 2005",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),

                  Text(
                    "Est. Sept 2005",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}