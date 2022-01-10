import 'package:basic_app/models/movies_model.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      // image: const DecorationImage(
      //   image: NetworkImage(
      //       'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
      //   fit: BoxFit.cover,
      // ),
      // border: Border.all(
      //   color: Colors.green,
      //   width: 1.5,
      // ),
      // borderRadius: BorderRadius.circular(12),
      // ),
      child: Card(
        elevation: 4,
        child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onTap: () => {print('listItem Clicked')},
            selectedColor: Colors.grey,
            leading: Image.network(item.posterPath, fit: BoxFit.fill),
            title: Text(
              item.title,
            ),
            subtitle: Text(item.releaseDate),
            trailing: Column(
              children: [
                const Icon(
                  // Alignment:  Alignment(10, 10),
                  Icons.star,
                  color: Colors.deepOrange,
                ),
                Text(item.voteAverage.toString()),
              ],
            )),
      ),
    );
  }
}
