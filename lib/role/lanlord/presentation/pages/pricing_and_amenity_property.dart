import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentverse/role/lanlord/presentation/cubit/add_property_cubit.dart';
import 'package:rentverse/role/lanlord/presentation/cubit/add_property_state.dart';
import 'package:rentverse/common/colors/custom_color.dart';

class PricingAndAmenityPropertyPage extends StatefulWidget {
  const PricingAndAmenityPropertyPage({super.key});

  @override
  State<PricingAndAmenityPropertyPage> createState() =>
      _PricingAndAmenityPropertyPageState();
}

class _PricingAndAmenityPropertyPageState
    extends State<PricingAndAmenityPropertyPage> {
  late String _furnishing;
  late List<String> _features;
  late List<String> _facilities;
  late List<String> _views;
  late List<int> _billingPeriodIds;
  late int _listingTypeId;
  late TextEditingController _priceController;

  static const _furnishingOptions = [
    'Unfurnished',
    'Fully Furnished',
    'Partly Furnished',
    'Negotiable',
  ];

  static const _billingOptions = [
    {'id': 1, 'label': 'Month to month'},
    {'id': 2, 'label': '3 months'},
    {'id': 3, 'label': '6 months'},
    {'id': 4, 'label': 'At least one year'},
  ];

  static const _listingOptions = [
    {'id': 1, 'label': 'Rent'},
    {'id': 2, 'label': 'Sell'},
    {'id': 3, 'label': 'Both sell & rent'},
  ];

  @override
  void initState() {
    super.initState();
    final state = context.read<AddPropertyCubit>().state;
    _furnishing = state.furnishing;
    _features = List<String>.from(state.features);
    _facilities = List<String>.from(state.facilities);
    _views = List<String>.from(state.views);
    _billingPeriodIds = List<int>.from(state.billingPeriodIds);
    if (_billingPeriodIds.isEmpty) _billingPeriodIds.add(1);
    _listingTypeId = state.listingTypeId;
    _priceController = TextEditingController(text: state.price);
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('Pricing & Amenity Details'),
        centerTitle: true,
      ),
      body: BlocBuilder<AddPropertyCubit, AddPropertyState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'How is your unit available?',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _furnishingOptions
                      .map(
                        (opt) => ChoiceChip(
                          label: Text(opt),
                          selected: _furnishing == opt,
                          onSelected: (_) {
                            setState(() => _furnishing = opt);
                            _pushChanges();
                          },
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),
                _TagEditor(
                  title: 'What are the features of your property?',
                  values: _features,
                  onChanged: (vals) {
                    setState(() => _features = vals);
                    _pushChanges();
                  },
                  suggestions: const [
                    'Private Lift',
                    'Private Gym',
                    'Swimming Pool',
                  ],
                ),
                const SizedBox(height: 16),
                _TagEditor(
                  title: 'Nearby facilities',
                  values: _facilities,
                  onChanged: (vals) {
                    setState(() => _facilities = vals);
                    _pushChanges();
                  },
                  suggestions: const ['Train Station', 'Bus Station'],
                ),
                const SizedBox(height: 16),
                _TagEditor(
                  title: 'What are the views of your property?',
                  values: _views,
                  onChanged: (vals) {
                    setState(() => _views = vals);
                    _pushChanges();
                  },
                  suggestions: const [
                    'Park View',
                    'Mountain View',
                    'City View',
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Are you looking to sell or rent your property?',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                ..._listingOptions.map(
                  (opt) => RadioListTile<int>(
                    value: opt['id'] as int,
                    groupValue: _listingTypeId,
                    onChanged: (val) {
                      if (val == null) return;
                      setState(() => _listingTypeId = val);
                      _pushChanges();
                    },
                    title: Text(opt['label'] as String),
                    dense: true,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Are you looking to sell or rent your property?',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                ..._billingOptions.map(
                  (opt) {
                    final id = opt['id'] as int;
                    final isSelected = _billingPeriodIds.contains(id);
                    return CheckboxListTile(
                      value: isSelected,
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            _billingPeriodIds.add(id);
                          } else {
                            _billingPeriodIds.remove(id);
                          }
                        });
                        _pushChanges();
                      },
                      title: Text(opt['label'] as String),
                      dense: true,
                      controlAffinity: ListTileControlAffinity.leading,
                    );
                  },
                ),
                const SizedBox(height: 12),
                const Text(
                  'Price (Rp)',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '1.000.000',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (_) => _pushChanges(),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _reset,
                        child: const Text('Reset'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appPrimaryColor,
                        ),
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _pushChanges() {
    context.read<AddPropertyCubit>().updatePricing(
      furnishing: _furnishing,
      features: _features,
      facilities: _facilities,
      views: _views,
      billingPeriodIds: _billingPeriodIds,
      price: _priceController.text,
      listingTypeId: _listingTypeId,
    );
  }

  void _reset() {
    context.read<AddPropertyCubit>().resetPricing();
    final state = context.read<AddPropertyCubit>().state;
    setState(() {
      _furnishing = state.furnishing;
      _features = List<String>.from(state.features);
      _facilities = List<String>.from(state.facilities);
      _views = List<String>.from(state.views);
      _billingPeriodIds = List<int>.from(state.billingPeriodIds);
      if (_billingPeriodIds.isEmpty) _billingPeriodIds.add(1);
      _listingTypeId = state.listingTypeId;
      _priceController.text = state.price;
    });
  }

  void _save() {
    _pushChanges();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Pricing & amenities saved')));
    Navigator.of(context).maybePop();
  }
}

class _TagEditor extends StatefulWidget {
  const _TagEditor({
    required this.title,
    required this.values,
    required this.onChanged,
    this.suggestions = const [],
  });

  final String title;
  final List<String> values;
  final List<String> suggestions;
  final ValueChanged<List<String>> onChanged;

  @override
  State<_TagEditor> createState() => _TagEditorState();
}

class _TagEditorState extends State<_TagEditor> {
  late List<String> _current;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _current = List<String>.from(widget.values);
  }

  @override
  void didUpdateWidget(covariant _TagEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.values != widget.values) {
      _current = List<String>.from(widget.values);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _current
              .map(
                (e) => InputChip(label: Text(e), onDeleted: () => _remove(e)),
              )
              .toList(),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Add item',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _addFromInput,
              style: ElevatedButton.styleFrom(
                backgroundColor: appPrimaryColor,
                minimumSize: const Size(60, 44),
              ),
              child: const Text('Add'),
            ),
          ],
        ),
        if (widget.suggestions.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            children: widget.suggestions
                .map(
                  (s) => ActionChip(
                    label: Text(s),
                    onPressed: () {
                      _add(s);
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ],
    );
  }

  void _addFromInput() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _add(text);
    _controller.clear();
  }

  void _add(String value) {
    if (_current.contains(value)) return;
    setState(() => _current.add(value));
    widget.onChanged(_current);
  }

  void _remove(String value) {
    setState(() => _current.remove(value));
    widget.onChanged(_current);
  }
}
