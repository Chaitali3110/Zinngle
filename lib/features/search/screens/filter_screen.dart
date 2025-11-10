// lib/features/search/screens/filter_screen.dart
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues _priceRange = const RangeValues(0, 200);
  double _rating = 0;
  String? _selectedCategory;
  String? _selectedLanguage;
  bool _onlineOnly = false;

  final List<String> _categories = [
    'Entertainment',
    'Education',
    'Lifestyle',
    'Sports',
    'Technology',
  ];

  final List<String> _languages = [
    'English',
    'Hindi',
    'Spanish',
    'French',
    'German',
  ];

  void _resetFilters() {
    setState(() {
      _priceRange = const RangeValues(0, 200);
      _rating = 0;
      _selectedCategory = null;
      _selectedLanguage = null;
      _onlineOnly = false;
    });
  }

  void _applyFilters() {
    // Apply filters logic
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _resetFilters,
            child: const Text('Reset'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Price Range (per minute)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                RangeSlider(
                  values: _priceRange,
                  min: 0,
                  max: 200,
                  divisions: 20,
                  labels: RangeLabels(
                    '₹${_priceRange.start.round()}',
                    '₹${_priceRange.end.round()}',
                  ),
                  onChanged: (values) {
                    setState(() {
                      _priceRange = values;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('₹${_priceRange.start.round()}'),
                    Text('₹${_priceRange.end.round()}'),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Minimum Rating',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Slider(
                  value: _rating,
                  min: 0,
                  max: 5,
                  divisions: 10,
                  label: _rating.toStringAsFixed(1),
                  onChanged: (value) {
                    setState(() {
                      _rating = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('0.0'),
                    Row(
                      children: [
                        Text(_rating.toStringAsFixed(1)),
                        const SizedBox(width: 4),
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _categories.map((category) {
                    final isSelected = _selectedCategory == category;
                    return FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = selected ? category : null;
                        });
                      },
                      selectedColor: Theme.of(context).primaryColor.withOpacity(0.3),
                      checkmarkColor: Theme.of(context).primaryColor,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Language',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _languages.map((language) {
                    final isSelected = _selectedLanguage == language;
                    return FilterChip(
                      label: Text(language),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedLanguage = selected ? language : null;
                        });
                      },
                      selectedColor: Theme.of(context).primaryColor.withOpacity(0.3),
                      checkmarkColor: Theme.of(context).primaryColor,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                SwitchListTile(
                  title: const Text(
                    'Online Only',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('Show only creators who are currently online'),
                  value: _onlineOnly,
                  onChanged: (value) {
                    setState(() {
                      _onlineOnly = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _applyFilters,
                  child: const Text(
                    'Apply Filters',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
