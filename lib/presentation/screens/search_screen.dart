import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void unfocusTextField() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _controller,
            autofocus: true,
            autocorrect: true,
            decoration: InputDecoration(hintText: "Enter city name")
                .applyDefaults(Theme.of(context).inputDecorationTheme),
          ),
        ],
      ),
    );
  }
}
