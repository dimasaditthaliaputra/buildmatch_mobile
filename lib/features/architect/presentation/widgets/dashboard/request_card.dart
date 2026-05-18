import 'package:flutter/material.dart';

class RequestCard extends StatelessWidget {
  final String title;
  final String location;
  final String price;
  final String size;

  const RequestCard({
    super.key,
    required this.title,
    required this.location,
    required this.price,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// TITLE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      location,
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
                  horizontal: 12,
                  vertical: 5,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xFFFFE0B2),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: const Text(
                  "NEW",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB86A00),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          /// INFO BOX
          Row(
            children: [

              Expanded(
                child: _infoBox(
                  "Rentang Harga",
                  price,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _infoBox(
                  "Luas Bangunan",
                  size,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          /// BUTTON
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15),

            decoration: BoxDecoration(
              color: const Color(0xFFFF8A00),
              borderRadius: BorderRadius.circular(30),
            ),

            child: const Center(
              child: Text(
                "Lihat Detail",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.orange,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}