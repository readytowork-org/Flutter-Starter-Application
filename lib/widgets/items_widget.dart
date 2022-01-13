// import 'package:basic_app/models/movies_model.dart';
// import 'package:flutter/material.dart';

// class ItemWidget extends StatelessWidget {
//   final MoviesModal items;

//   const ItemWidget({Key? key, required this.items}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       child: ListTile(
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//           onTap: () => {print('listItem Clicked')},
//           selectedColor: Colors.grey,
//           leading: Image.network(items.posterPath.toString(), fit: BoxFit.fill),
//           title: Text(
//             items.title.toString(),
//           ),
//           subtitle: Text(items.releaseDate.toString()),
//           trailing: Column(
//             children: [
//               const Icon(
//                 // Alignment:  Alignment(10, 10),
//                 Icons.star,
//                 color: Colors.deepOrange,
//               ),
//               Text(items.voteAverage.toString()),
//             ],
//           )),
//     );
//   }
// }
