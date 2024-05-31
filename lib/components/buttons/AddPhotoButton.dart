import "package:flutter/material.dart";

class AddPhotoButton extends StatelessWidget {
  final VoidCallback? selectFile;
  const AddPhotoButton({super.key, this.selectFile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28.0, right: 28, top: 10),
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color.fromARGB(167, 99, 99, 99),
              width: 1,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.photo, color: Color.fromARGB(255, 155, 136, 136)),
            TextButton(
                onPressed: selectFile,
                child: const Text(
                  "choose a photo",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                )),
          ],
        ),
      ),
    );
  }
}
