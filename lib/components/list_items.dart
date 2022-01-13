import 'package:flutter/material.dart';

class ListItems extends StatelessWidget {
  final String imagePath;
  final String movieName;
  final String movieDetails;
  final String movieRating;
  final String movieLanguage;

  const ListItems(
      {Key? key,
      required this.imagePath,
      required this.movieName,
      required this.movieDetails,
      required this.movieRating,
      required this.movieLanguage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          splashColor: Colors.grey,
          onTap: () => print("Container pressed"),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(25)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.network(
                      imagePath,
                      height: 150,
                      width: 130,
                      fit: BoxFit.fill,
                    ),
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movieName,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        // textDirection: TextDirection.rtl,
                        // textAlign: TextAlign.left
                        // style: TextStyle
                      ),
                      Text(
                        movieDetails,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        // textAlign: TextAlign.left
                        // style: TextStyle
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // const SizedBox(height: 20),
                          Text(
                            "Rating:  " + movieRating,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.deepOrange,
                          ),
                        ],
                      ),
                      Text(
                        movieLanguage,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
