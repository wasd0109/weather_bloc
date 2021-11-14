import 'package:bloc_weather/cubit/location_cubit.dart';
import 'package:bloc_weather/cubit/locationautocomplete_cubit.dart';
import 'package:bloc_weather/presentation/components/platform_specific_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();
  String error = "";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void setError(String message) {
    setState(() {
      error = message;
    });
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
            decoration: InputDecoration(
                    hintText: "Enter city name",
                    errorText: error != "" ? error : null)
                .applyDefaults(Theme.of(context).inputDecorationTheme),
            onChanged: (value) {
              BlocProvider.of<LocationAutocompleteCubit>(context)
                  .getSuggestions(value);
            },
          ),
          OutlinedButton(
            onPressed: () {
              setError("");
              if (_controller.text.isEmpty) setError("Required");
              return BlocProvider.of<LocationCubit>(context)
                  .getLocationFromCity(_controller.text);
            },
            child: Text(
              "Search",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            style: Theme.of(context).outlinedButtonTheme.style,
          ),
          BlocBuilder<LocationAutocompleteCubit, LocationAutocompleteState>(
            builder: (context, state) {
              if (state is LocationAutocompleteInitial) {
                return Container();
              }
              if (state is LocationAutocompleteLoaded) {
                return Expanded(
                  flex: 2,
                  child: Scrollbar(
                    child: ListView.builder(
                      itemBuilder: (context, i) {
                        return ListTile(
                          title: Text(state.suggestions[i].description),
                          onTap: () {
                            _controller.text = state.suggestions[i].description;
                          },
                        );
                      },
                      itemCount: state.suggestions.length,
                    ),
                  ),
                );
              }
              if (state is LocationAutocompleteLoading)
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: PlatformSpecificSpinner(),
                );
              return Text("Error");
            },
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
