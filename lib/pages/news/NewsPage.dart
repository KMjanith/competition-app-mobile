import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/Constants/StyleConstants.dart';
import '../../components/common/HedingAnimation.dart';
import '../../model/Article.dart';

class NewsPage extends StatelessWidget {
  final Article article;
  const NewsPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StyleConstants.upperBackgroundContainer,
          Column(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ],
                ),
              ),
              const HeadingAnimation(heading: "News Feed"),
              const SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(article.title,
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 208, 238, 238))),
                        const SizedBox(height: 10),
                        Image.network(article.urlToImage != null &&
                                article.urlToImage!.isNotEmpty
                            ? article.urlToImage!
                            : 'https://www.dictionary.com/e/wp-content/uploads/2020/01/Zip_Zero_Zilch_1000x700_jpg_2ZuoCxRf.jpg'),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5),
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 5, // space between the widgets
                            children: [
                              const Icon(
                                Icons.manage_accounts_rounded,
                                color: Colors.white38,
                              ),
                              Text(
                                "Author: ${article.author ?? ''}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const Text("-"),
                              Text(
                                publishedAtStringConverter(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(62, 255, 255, 255),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    article.description ??
                                        'no description available',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(
                                            255, 243, 208, 208))),
                                const SizedBox(height: 20),
                                const Text(
                                  "Link to site",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _launchUrl(Uri.parse(article.url));
                                  },
                                  child: Text(
                                    article.url,
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 133, 195, 219)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: FloatingActionButton(
                backgroundColor: const Color.fromARGB(68, 93, 196, 243),
                child: const Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 211, 211, 211),
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
        ],
      ),
    );
  }

  String publishedAtStringConverter() {
    return "${article.publishedAt.split("-")[0]}-${article.publishedAt.split("-")[1]}-${article.publishedAt.split("-")[2].split('')[0]}${article.publishedAt.split("-")[2].split('')[1]}";
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
