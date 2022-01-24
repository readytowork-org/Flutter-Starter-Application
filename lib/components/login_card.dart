import 'package:flutter/material.dart';

class LoginCard extends StatelessWidget {
  final String image;
  final String textValue;
  final void Function() onPress;

  const LoginCard(
      {Key? key,
      required this.image,
      required this.textValue,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: onPress,
        splashColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Image.asset(
              image,
            ),
            title: Text(
              textValue,
            ),
          ),
        ),
      ),
    );
  }
}
