import 'package:flutter/material.dart';

class HomeToolBar extends StatelessWidget {
  const HomeToolBar({super.key, required this.profileUrl, required this.name, required this.onTab});

  final String profileUrl;
  final String name;
  final Function() onTab;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.menu,
                  ),
                  onPressed: onTab,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: CircleAvatar(
                  foregroundImage: AssetImage('assets/images/img.jpg'),
                ),
              ),
            )
          ],
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, top: 10.0),
            child: Text(
              'Welcome Home',
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 2.0),
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 20, right: 20,bottom: 15),
            child: SearchBar(
              leading: Icon(Icons.search_rounded),
              hintText: 'Search',
              constraints: BoxConstraints(),
              elevation: MaterialStatePropertyAll(0.5),
            ),
          ),
        ),
      ],
    );
  }
}
