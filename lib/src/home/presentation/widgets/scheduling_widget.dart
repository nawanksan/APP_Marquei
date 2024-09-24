import 'package:flutter/material.dart';

class SchedulingCard extends StatelessWidget {
  final String date;
  final String month;
  final String timeRange;
  final String customerName;
  final String servicesCount;
  final String price;
  final String paymentMethod;
  final VoidCallback onTap;

  const SchedulingCard({
    super.key,
    required this.date,
    required this.month,
    required this.timeRange,
    required this.customerName,
    required this.servicesCount,
    required this.price,
    required this.paymentMethod,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          month,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            timeRange,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF0D0D0D),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFE4EFFF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            alignment: Alignment.center,
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                              child: Text(
                                'Agendado',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF002AFF),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        customerName,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Serviços selecionados: $servicesCount',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF0D0D0D),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    paymentMethod,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF718096),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
