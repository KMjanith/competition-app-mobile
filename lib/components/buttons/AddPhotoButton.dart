import "package:flutter/material.dart";

class AddPhotoButton extends StatelessWidget {
  final VoidCallback? selectFile;
  const AddPhotoButton({super.key, this.selectFile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: const Color.fromARGB(150, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.photo, color: Color.fromARGB(255, 109, 106, 106)),
            TextButton(
                onPressed: selectFile,
                child: const Text(
                  "choose a photo",
                  style: TextStyle(
                      color: Color.fromARGB(255, 54, 54, 54), fontSize: 18),
                )),
          ],
        ),
      ),
    );
  }
}
