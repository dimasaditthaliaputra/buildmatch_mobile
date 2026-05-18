import 'package:flutter/material.dart';

class FinancialChart extends StatelessWidget {
  const FinancialChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// TITLE BESAR
        const Text(
          "Grafik",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),

        /// CARD
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [

                      Text(
                        "Grafik Keuangan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        "6 bulan terakhir",
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [

                      _tab("Tahun"),

                      const SizedBox(width: 6),

                      _tab("Bulan"),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// CHART AREA
              SizedBox(
                height: 220,
                child: Column(
                  children: [

                    /// GRAPH
                    Expanded(
                      child: Stack(
                        children: [

                          /// GRID
                          Column(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              5,
                              (index) => Row(
                                children: [

                                  SizedBox(
                                    width: 35,
                                    child: Text(
                                      "${500 - (index * 100)}jt",
                                      style: const TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          /// ORANGE LINE
                          Positioned(
                            left: 40,
                            right: 0,
                            bottom: 60,

                            child: Container(
                              height: 3,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// MONTHS
                    const Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [

                        Text("JAN",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11)),

                        Text("FEB",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11)),

                        Text("MAR",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11)),

                        Text("APR",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11)),

                        Text("MEI",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11)),

                        Text("JUN",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11)),

                        Text("JUL",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11)),
                      ],
                    ),

                    const SizedBox(height: 18),

                    /// LEGEND
                    Row(
                      children: [

                        Container(
                          width: 24,
                          height: 3,
                          color: Colors.orange,
                        ),

                        const SizedBox(width: 8),

                        const Text(
                          "Pendapatan",
                          style: TextStyle(fontSize: 11),
                        ),

                        const SizedBox(width: 20),

                        Container(
                          width: 24,
                          height: 3,
                          color: Color(0xFFFFCC80),
                        ),

                        const SizedBox(width: 8),

                        const Text(
                          "Bulan lalu",
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _tab(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),

      decoration: BoxDecoration(
        color: const Color(0xFFFFE0B2),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          color: Color(0xFFB86A00),
        ),
      ),
    );
  }
}