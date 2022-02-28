import 'package:flutter/material.dart';

class TItleForPage extends StatelessWidget {
  const TItleForPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(10, 40, 30, 0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("images/icon.png", height: 50),
                const SizedBox(
                  width: 50,
                  child: Text("Bonjour adel"),
                ),
                const Spacer(flex: 2),
                Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      child: const Icon(
                        Icons.search,
                      ),
                    )),
                const Icon(Icons.notifications),
              ],
            ),
          ),
        ),
        Container(
          height: 150,
          padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
          margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: const Center(
            child: Text(
              "We are here to help you planning your wedding",
              style: TextStyle(fontSize: 25),
            ),
          ),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.orange),
        ),
      ],
    );
  }
}
