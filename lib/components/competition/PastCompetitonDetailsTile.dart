import 'package:competition_app/components/Constants/PaymentStatus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/Player.dart';

class PastCompetitonDetailsTile extends StatelessWidget {
  final Player player;
  
  const PastCompetitonDetailsTile({super.key ,required this.player});

  @override
  Widget build(BuildContext context) {
    final String paidAmount;
    final String paidDate;
    final Color backColor;
    final Color frontColor;

    if (player.paymentStatus != PaymentStatus.pending) {
      paidAmount = player.paidAmount;
      paidDate = player.paidDate;
      backColor = const Color.fromARGB(255, 165, 255, 168);
      frontColor = const Color.fromARGB(192, 102, 245, 107);
    } else {
      paidAmount = "Not Paid";
      paidDate = "Not Paid";
      backColor = const Color.fromARGB(255, 255, 172, 166);
      frontColor = const Color.fromARGB(204, 247, 129, 121);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(167, 0, 0, 0),
                blurRadius: 5,
                spreadRadius: 0.5,
                offset: Offset(1, 2))
          ],
          color: backColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                height: 100,
                width: 250,
                decoration: BoxDecoration(
                    color: frontColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        topRight: Radius.circular(55),
                        bottomRight: Radius.circular(55))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        
                        textingDetails("Full Name", player.name),
                        textingDetails("Birth C.No", player.birthCertificateNumber),
                        textingDetails("Comp Fees", paidAmount),
                        textingDetails("Paid Date", paidDate),
                        if( player.level != '')
                        textingDetails("Level", player.level),
                        if(player.kata)
                        textingDetails("Event", "Kata"),
                        if(player.kumite)
                        textingDetails("Event", "Kumite"),
                        textingDetails("Category", player.competeCategory),
                        
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromARGB(255, 0, 106, 133)),
                              child: TextButton(
                                  onPressed: () {
                                   
                                  },
                                  child: const Text(
                                    "Edit results",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Icon(Icons.sports_martial_arts,
                                size: 50, color: Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Padding textingDetails(String key, String value) {
  return Padding(
    padding: const EdgeInsets.only(right: 30, left: 20, top: 5, bottom: 5),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              const Icon(Icons.arrow_right, color: Colors.black, size: 15),
              const SizedBox(
                width: 3,
              ),
              Text(
                key,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          flex: 1,
          child: Text(
            textAlign: TextAlign.left,
            value,
            style: GoogleFonts.anta(
              fontSize: 12,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            overflow: TextOverflow.ellipsis, // Adds ellipsis if text overflows
          ),
        ),
      ],
    ),
  );
}
