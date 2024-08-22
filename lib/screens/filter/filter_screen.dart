import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';

class FilterScreen extends StatefulWidget {
  final String initialCategory;
  final String initialGender;
  final RangeValues initialPriceRange;

  const FilterScreen({
    Key? key,
    this.initialCategory = 'All',
    this.initialGender = 'Both',
    this.initialPriceRange = const RangeValues(50, 1000),
  }) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late String selectedCategory;
  late String selectedGender;
  late RangeValues _priceRangeValues;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
    selectedGender = widget.initialGender;
    _priceRangeValues = widget.initialPriceRange;
  }

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
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(defaultPadding * 1.5),
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
                      valueIndicatorTextStyle: const TextStyle(color: Colors.white),
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
                            setState(() {
                              selectedCategory = 'All';
                              selectedGender = 'Both';
                              _priceRangeValues = const RangeValues(50, 1000);
                            });
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
                      const SizedBox(height: defaultPadding * 1.5),
                      Text(
                        'Category',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: defaultPadding * 1.5),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildCategoryChip('All'),
                            const SizedBox(width: 8),
                            _buildCategoryChip('Dress'),
                            const SizedBox(width: 8),
                            _buildCategoryChip('Shirt'),
                            const SizedBox(width: 8),
                            _buildCategoryChip('Pants'),
                            const SizedBox(width: 8),
                            _buildCategoryChip('Tshirt'),
                          ],
                        ),
                      ),
                      const SizedBox(height: defaultPadding * 2.5),
                      Text('Gender',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.black, fontWeight: FontWeight.w500)),
                      const SizedBox(height: defaultPadding * 1.5),
                      Row(
                        children: [
                          _buildGenderChip('Both'),
                          const SizedBox(width: 8),
                          _buildGenderChip('Man'),
                          const SizedBox(width: 8),
                          _buildGenderChip('Woman'),
                        ],
                      ),
                      const SizedBox(height: defaultPadding * 2.5),
                      Text('Pricing',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.black, fontWeight: FontWeight.w500)),
                      const SizedBox(height: defaultPadding * 2.5),
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
                      const SizedBox(height: defaultPadding * 2.5),
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
                            List<Product> filteredProducts = demo_product.where((product) {
                              bool matchesCategory = selectedCategory == 'All' || product.category == selectedCategory;
                              bool matchesGender = selectedGender == 'Both' || product.gender == selectedGender;
                              bool matchesPrice = product.price >= _priceRangeValues.start && product.price <= _priceRangeValues.end;
                              return matchesCategory && matchesGender && matchesPrice;
                            }).toList();

                            // Debug çıktıları
                            print("Selected Category: $selectedCategory");
                            print("Selected Gender: $selectedGender");
                            print("Price Range: ${_priceRangeValues.start} - ${_priceRangeValues.end}");
                            print("Filtered Products Count: ${filteredProducts.length}");

                            Navigator.pop(context, {
                              'filteredProducts': filteredProducts,
                              'selectedCategory': selectedCategory,
                              'selectedGender': selectedGender,
                              'priceRange': _priceRangeValues,
                            });
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

  Widget _buildGenderChip(String gender) {
    return ChoiceChip(
      label: Text(gender),
      selected: selectedGender == gender,
      selectedColor: primaryColor,
      labelStyle: TextStyle(
        color: selectedGender == gender ? Colors.white : Colors.black,
      ),
      onSelected: (bool selected) {
        setState(() {
          selectedGender = selected ? gender : selectedGender;
        });
      },
    );
  }
}