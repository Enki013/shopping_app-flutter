import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String selectedCategory = 'New Arrival';
  RangeValues _priceRangeValues = const RangeValues(50, 1000);
  RangeValues _distanceRangeValues = const RangeValues(0.5, 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(defaultPadding * 1.5), //yanlardan
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(defaultBorderRadius),
                  topRight: Radius.circular(defaultBorderRadius),
                ),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  sliderTheme: SliderTheme.of(context).copyWith(
                    valueIndicatorTextStyle:
                        const TextStyle(color: Colors.white),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      title: Text('Filters',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700)),
                      centerTitle: true,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: TextButton(
                        onPressed: () {
                          // Clear filter logic
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        ),
                        child: const Text(
                          'Clear',
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(
                        height: defaultPadding * 1.5), //filters category arası
                    Text(
                      'Category',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                        height:
                            defaultPadding * 1.5), // category new arrival arası
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildCategoryChip('New Arrival'),
                          const SizedBox(width: 8),
                          _buildCategoryChip('Top Trending'),
                          const SizedBox(width: 8),
                          _buildCategoryChip('Featured Products'),
                        ],
                      ),
                    ),
                    const SizedBox(
                        height:
                            defaultPadding * 2.5), //new arrival pricing arası
                    Text('Pricing',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w500)),
                    const SizedBox(
                        height: defaultPadding * 2.5), //pricing ve slider arası
                    RangeSlider(
                      values: _priceRangeValues,
                      min: 50,
                      max: 1000,
                      divisions: 19,
                      labels: RangeLabels(
                        '\$${_priceRangeValues.start.round()}',
                        '\$${_priceRangeValues.end.round()}',
                      ),
                      activeColor: primaryColor,
                      inactiveColor: primaryColor.withOpacity(0.3),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _priceRangeValues = values;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$${_priceRangeValues.start.round()}'),
                        Text('\$${_priceRangeValues.end.round()}'),
                      ],
                    ),
                    const SizedBox(
                        height: defaultPadding *
                            2), //pricing distance slider arası boşluk
                    Text('Distance',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.w500)),
                    const SizedBox(
                        height: defaultPadding * 2.5), //distance padding
                    RangeSlider(
                      values: _distanceRangeValues,
                      min: 0.5,
                      max: 2,
                      divisions: 3,
                      labels: RangeLabels(
                        '${_distanceRangeValues.start.toStringAsFixed(1)}Km',
                        '${_distanceRangeValues.end.toStringAsFixed(1)}Km',
                      ),
                      activeColor: primaryColor,
                      inactiveColor: primaryColor.withOpacity(0.3),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _distanceRangeValues = values;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '${_distanceRangeValues.start.toStringAsFixed(1)}Km'),
                        Text(
                            '${_distanceRangeValues.end.toStringAsFixed(1)}Km'),
                      ],
                    ),
                    const SizedBox(
                        height: defaultPadding * 2.5), //en alt padding
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding),
                        ),
                        onPressed: () {
                          // Filtre uygulama mantığı
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Apply Filter',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    return ChoiceChip(
      label: Text(category),
      selected: selectedCategory == category,
      selectedColor: primaryColor,
      labelStyle: TextStyle(
        color: selectedCategory == category ? Colors.white : Colors.black,
      ),
      onSelected: (bool selected) {
        setState(() {
          selectedCategory = selected ? category : selectedCategory;
        });
      },
    );
  }
}