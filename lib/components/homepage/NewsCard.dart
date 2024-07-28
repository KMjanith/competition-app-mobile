import 'package:competition_app/pages/news/NewsPage.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../model/Article.dart';

class NewsCard extends StatelessWidget {
  final Article article;

  const NewsCard({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Image image;

    image = Image.network(
      article.urlToImage!,
      height: 100,
      width: 200,
      fit: BoxFit.cover,
    );

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        color: Color.fromARGB(62, 255, 255, 255),
      ),
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
        child: Column(
          children: [
            image,
            const SizedBox(height: 5),
            TextButton(
              onPressed: () {},
              child: Text(
                article.title,
                style: GoogleFonts.roboto(
                    color: const Color.fromARGB(221, 39, 39, 39),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  const Color.fromARGB(255, 168, 248, 241),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NewsPage(article: article)));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("More"),
                  Icon(Icons.arrow_forward_ios, size: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
