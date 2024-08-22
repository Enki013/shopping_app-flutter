import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/filter/filter_screen.dart';
import 'package:shop_app/screens/search/search_results_screen.dart';
import 'package:shop_app/models/Product.dart';

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide.none,
);

class SearchForm extends StatefulWidget {
  final String initialQuery;
  final Function(String, List<Product>)? onSearch;

  const SearchForm({Key? key, this.initialQuery = '', this.onSearch}) : super(key: key);

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  late TextEditingController _searchController;
  List<Product>? _filteredProducts;
  String _selectedCategory = 'All';
  String _selectedGender = 'Both';
  RangeValues _priceRangeValues = const RangeValues(50, 1000);

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showSearchResults(BuildContext context, String query) {
    List<Product> searchResults;
    if (_filteredProducts != null) {
      searchResults = _filteredProducts!.where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      searchResults = demo_product.where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    if (widget.onSearch != null) {
      widget.onSearch!(query, searchResults);
    } else {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => SearchResultsScreen(
            query: query,
            searchResults: searchResults,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        controller: _searchController,
        autofocus: false,
        onFieldSubmitted: (value) {
          _showSearchResults(context, value);
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "Search items...",
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          errorBorder: outlineInputBorder,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                padding: EdgeInsets.zero,
                minimumSize: const Size(48, 48),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return FilterScreen(
                      initialCategory: _selectedCategory,
                      initialGender: _selectedGender,
                      initialPriceRange: _priceRangeValues,
                    );
                  },
                ).then((result) {
                  if (result != null) {
                    setState(() {
                      _filteredProducts = result['filteredProducts'];
                      _selectedCategory = result['selectedCategory'];
                      _selectedGender = result['selectedGender'];
                      _priceRangeValues = result['priceRange'];
                    });
                    if (_searchController.text.isNotEmpty) {
                      _showSearchResults(context, _searchController.text);
                    }
                  }
                });
              },
              child: SvgPicture.asset(
                "assets/icons/Filter.svg",
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}