import 'package:flutter/material.dart';
import 'package:todo_app/features_fake_apis/models/fake_cities_modal.dart';

class SearchableDropdown extends StatefulWidget {
  const SearchableDropdown({super.key});

  @override
  State<SearchableDropdown> createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  final Citites cities = Citites();
  bool isSearchFieldOpen = false;
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredCities = [];

  @override
  void initState() {
    super.initState();
    filteredCities = cities.cities;
  }

  void toggleSearchState() {
    setState(() {
      isSearchFieldOpen = !isSearchFieldOpen;
      if (!isSearchFieldOpen) {
        searchController.clear();
        filteredCities = cities.cities;
      }
    });
  }

  void filterCities(String text) {
    setState(() {
      filteredCities = cities.cities
          .where(
              (city) => city['city'].toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Cities'),
            IconButton(
              icon:
                  !isSearchFieldOpen ? Icon(Icons.search) : Icon(Icons.cancel),
              onPressed: toggleSearchState,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          if (isSearchFieldOpen)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: filterCities,
                decoration: InputDecoration(
                  hintText: "Search cities...",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCities.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[100],
                  child: ListTile(
                    leading: Icon(Icons.location_city),
                    title: Text(
                      filteredCities[index]['city'],
                      style: TextStyle(
                        fontSize: MediaQuery.sizeOf(context).height * 0.02,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
