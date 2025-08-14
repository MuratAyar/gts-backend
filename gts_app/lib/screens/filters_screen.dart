import 'package:flutter/material.dart';

/// Design tokens (HTML'deki renklerle eşleşir)
const _bg = Color(0xFFF8F9FC);
const _textPrimary = Color(0xFF0E111B);
const _textSecondary = Color(0xFF4E6097);
const _chipBg = Color(0xFFE7EAF3);
const _border = Color(0xFFD0D6E7);
const _blue = Color(0xFF143DB8);

enum SortBy { relevance, newest, priceLowHigh, priceHighLow }

class FiltersData {
  FiltersData({
    this.quick = const <String>{},
    this.category = 'All',
    this.makeModelQuery = '',
    this.capacityMin,
    this.capacityMax,
    this.boomMin,
    this.boomMax,
    this.yearMin,
    this.yearMax,
    this.priceMin,
    this.priceMax,
    this.locationQuery = '',
    this.sellerQuery = '',
    this.sortBy = SortBy.relevance,
  });

  Set<String> quick;
  String category;
  String makeModelQuery;
  int? capacityMin, capacityMax;
  int? boomMin, boomMax;
  int? yearMin, yearMax;
  int? priceMin, priceMax;
  String locationQuery;
  String sellerQuery;
  SortBy sortBy;

  FiltersData copy() => FiltersData(
        quick: {...quick},
        category: category,
        makeModelQuery: makeModelQuery,
        capacityMin: capacityMin,
        capacityMax: capacityMax,
        boomMin: boomMin,
        boomMax: boomMax,
        yearMin: yearMin,
        yearMax: yearMax,
        priceMin: priceMin,
        priceMax: priceMax,
        locationQuery: locationQuery,
        sellerQuery: sellerQuery,
        sortBy: sortBy,
      );
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    this.initial,
    this.initialResultCount = 123, // canlı sayımı backend’den bağlayabilirsiniz
  });

  final FiltersData? initial;
  final int initialResultCount;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late FiltersData _data;
  late int _resultCount;

  final _makeModel = TextEditingController();
  final _location = TextEditingController();
  final _seller = TextEditingController();

  final _capacityMin = TextEditingController();
  final _capacityMax = TextEditingController();
  final _boomMin = TextEditingController();
  final _boomMax = TextEditingController();
  final _yearMin = TextEditingController();
  final _yearMax = TextEditingController();
  final _priceMin = TextEditingController();
  final _priceMax = TextEditingController();

  final _quickChoices = const ['Available Now', 'Recently Added', 'Price Reduced'];
  final _categories = const ['All', 'Crawler Cranes', 'Mobile Cranes', 'Tower Cranes'];

  @override
  void initState() {
    super.initState();
    _data = (widget.initial ?? FiltersData()).copy();
    _resultCount = widget.initialResultCount;

    _makeModel.text = _data.makeModelQuery;
    _location.text = _data.locationQuery;
    _seller.text = _data.sellerQuery;

    _capacityMin.text = _data.capacityMin?.toString() ?? '';
    _capacityMax.text = _data.capacityMax?.toString() ?? '';
    _boomMin.text = _data.boomMin?.toString() ?? '';
    _boomMax.text = _data.boomMax?.toString() ?? '';
    _yearMin.text = _data.yearMin?.toString() ?? '';
    _yearMax.text = _data.yearMax?.toString() ?? '';
    _priceMin.text = _data.priceMin?.toString() ?? '';
    _priceMax.text = _data.priceMax?.toString() ?? '';
  }

  void _clearAll() {
    setState(() {
      _data = FiltersData();
      _resultCount = widget.initialResultCount;
      _makeModel.clear();
      _location.clear();
      _seller.clear();
      _capacityMin.clear();
      _capacityMax.clear();
      _boomMin.clear();
      _boomMax.clear();
      _yearMin.clear();
      _yearMax.clear();
      _priceMin.clear();
      _priceMax.clear();
    });
  }

  void _reset() => _clearAll();

  // Demo: Her değişimde sahte bir “live count” hesapla
  void _recalcCount() {
    // Burayı backend’e bağladığınızda gerçek sayım ile değiştirin.
    final filled = [
      _makeModel.text,
      _location.text,
      _seller.text,
      _capacityMin.text,
      _capacityMax.text,
      _boomMin.text,
      _boomMax.text,
      _yearMin.text,
      _yearMax.text,
      _priceMin.text,
      _priceMax.text,
      if (_data.category != 'All') _data.category,
      ..._data.quick,
    ].where((e) => e.trim().isNotEmpty).length;

    setState(() {
      _resultCount = (widget.initialResultCount - filled * 3).clamp(0, 9999);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 720;

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(onBack: () => Navigator.pop(context), onClearAll: _clearAll),
            Expanded(
              child: isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Sol index (basit hal)
                        SizedBox(
                          width: 180,
                          child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            children: const [
                              _IndexItem('Quick Filters'),
                              _IndexItem('Category'),
                              _IndexItem('Manufacturer & Model'),
                              _IndexItem('Specs'),
                              _IndexItem('Price'),
                              _IndexItem('Location'),
                              _IndexItem('Seller & Meta'),
                              _IndexItem('Sort'),
                            ],
                          ),
                        ),
                        const VerticalDivider(color: _border, width: 1),
                        Expanded(child: _buildFiltersContent()),
                      ],
                    )
                  : _buildFiltersContent(),
            ),
            _BottomBar(
              onReset: _reset,
              resultCount: _resultCount,
              onApply: () {
                // Form değerlerini _data’ya yaz
                _data
                  ..makeModelQuery = _makeModel.text
                  ..locationQuery = _location.text
                  ..sellerQuery = _seller.text
                  ..capacityMin = _parseInt(_capacityMin.text)
                  ..capacityMax = _parseInt(_capacityMax.text)
                  ..boomMin = _parseInt(_boomMin.text)
                  ..boomMax = _parseInt(_boomMax.text)
                  ..yearMin = _parseInt(_yearMin.text)
                  ..yearMax = _parseInt(_yearMax.text)
                  ..priceMin = _parseInt(_priceMin.text)
                  ..priceMax = _parseInt(_priceMax.text);

                Navigator.pop(context, _data); // Listings sayfasına filtreleri döndür
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFiltersContent() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _SectionTitle('Quick Filters'),
        _ChipWrap(
          children: _quickChoices.map((label) {
            final selected = _data.quick.contains(label);
            return FilterChip(
              selected: selected,
              backgroundColor: _chipBg,
              selectedColor: _chipBg,
              side: const BorderSide(color: Colors.transparent),
              label: Text(label, style: _chipText),
              onSelected: (v) {
                setState(() {
                  v ? _data.quick.add(label) : _data.quick.remove(label);
                });
                _recalcCount();
              },
            );
          }).toList(),
        ),
        _SectionTitle('Category'),
        _ChipWrap(
          children: _categories.map((label) {
            final selected = _data.category == label;
            return ChoiceChip(
              selected: selected,
              backgroundColor: _chipBg,
              selectedColor: _chipBg,
              side: const BorderSide(color: Colors.transparent),
              label: Text(label, style: _chipText),
              onSelected: (_) {
                setState(() => _data.category = label);
                _recalcCount();
              },
            );
          }).toList(),
        ),
        _SectionTitle('Manufacturer & Model'),
        _Padded(_TextField(
          controller: _makeModel,
          hint: 'Search',
          onChanged: (_) => _recalcCount(),
        )),
        _SectionTitle('Specs'),
        _Padded(Row(
          children: [
            Expanded(
              child: _LabeledField(
                label: 'Capacity (tons)',
                hint: 'Min',
                controller: _capacityMin,
                onChanged: (_) => _recalcCount(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _LabeledField(
                label: '',
                hint: 'Max',
                controller: _capacityMax,
                onChanged: (_) => _recalcCount(),
              ),
            ),
          ],
        )),
        _Padded(Row(
          children: [
            Expanded(
              child: _LabeledField(
                label: 'Boom Length (ft)',
                hint: 'Min',
                controller: _boomMin,
                onChanged: (_) => _recalcCount(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _LabeledField(
                label: '',
                hint: 'Max',
                controller: _boomMax,
                onChanged: (_) => _recalcCount(),
              ),
            ),
          ],
        )),
        _Padded(Row(
          children: [
            Expanded(
              child: _LabeledField(
                label: 'Year',
                hint: 'Min',
                controller: _yearMin,
                onChanged: (_) => _recalcCount(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _LabeledField(
                label: '',
                hint: 'Max',
                controller: _yearMax,
                onChanged: (_) => _recalcCount(),
              ),
            ),
          ],
        )),
        _SectionTitle('Price'),
        _Padded(Row(
          children: [
            Expanded(
              child: _LabeledField(
                label: 'Price',
                hint: 'Min',
                controller: _priceMin,
                onChanged: (_) => _recalcCount(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _LabeledField(
                label: '',
                hint: 'Max',
                controller: _priceMax,
                onChanged: (_) => _recalcCount(),
              ),
            ),
          ],
        )),
        _SectionTitle('Location'),
        _Padded(_TextField(
          controller: _location,
          hint: 'Search',
          onChanged: (_) => _recalcCount(),
        )),
        _SectionTitle('Seller & Meta'),
        _Padded(_TextField(
          controller: _seller,
          hint: 'Search',
          onChanged: (_) => _recalcCount(),
        )),
        _SectionTitle('Sort'),
        _Padded(Column(
          children: [
            _SortTile(
              title: 'Relevance',
              group: _data.sortBy,
              value: SortBy.relevance,
              onChanged: _onSortChanged,
            ),
            _SortTile(
              title: 'Newest',
              group: _data.sortBy,
              value: SortBy.newest,
              onChanged: _onSortChanged,
            ),
            _SortTile(
              title: 'Price (Low to High)',
              group: _data.sortBy,
              value: SortBy.priceLowHigh,
              onChanged: _onSortChanged,
            ),
            _SortTile(
              title: 'Price (High to Low)',
              group: _data.sortBy,
              value: SortBy.priceHighLow,
              onChanged: _onSortChanged,
            ),
          ],
        )),
        const SizedBox(height: 12),
      ],
    );
  }

  void _onSortChanged(SortBy? v) {
    if (v == null) return;
    setState(() => _data.sortBy = v);
    _recalcCount();
  }

  static int? _parseInt(String s) {
    final t = s.trim();
    if (t.isEmpty) return null;
    return int.tryParse(t);
  }
}

/// UI helpers –––––––––––––––––––––––––––––––––––––––––

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onBack, required this.onClearAll});
  final VoidCallback onBack;
  final VoidCallback onClearAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _bg,
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: _textPrimary),
            onPressed: onBack,
          ),
          const Expanded(
            child: Text(
              'Filters',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.15,
              ),
            ),
          ),
          TextButton(
            onPressed: onClearAll,
            child: const Text(
              'Clear all',
              style: TextStyle(
                color: _textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.onReset,
    required this.resultCount,
    required this.onApply,
  });

  final VoidCallback onReset;
  final int resultCount;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _bg,
        border: Border(top: BorderSide(color: _border)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: _chipBg,
                side: BorderSide.none,
                foregroundColor: _textPrimary,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: onReset,
              child: const Text('Reset'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _blue,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: onApply,
              child: Text('Show $resultCount results'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        text,
        style: const TextStyle(
          color: _textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.15,
        ),
      ),
    );
  }
}

class _ChipWrap extends StatelessWidget {
  const _ChipWrap({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: children,
      ),
    );
  }
}

const _chipText = TextStyle(
  color: _textPrimary,
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

class _Padded extends StatelessWidget {
  const _Padded(this.child);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: child,
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.controller,
    required this.hint,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: _chipBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      style: const TextStyle(color: _textPrimary),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.hint,
    required this.controller,
    this.onChanged,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              label,
              style: const TextStyle(
                color: _textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        _TextField(controller: controller, hint: hint, onChanged: onChanged),
      ],
    );
  }
}

class _SortTile extends StatelessWidget {
  const _SortTile({
    required this.title,
    required this.group,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final SortBy group;
  final SortBy value;
  final ValueChanged<SortBy?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: RadioListTile<SortBy>(
        value: value,
        groupValue: group,
        onChanged: onChanged,
        title: Text(title, style: const TextStyle(color: _textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        activeColor: _blue,
      ),
    );
  }
}

class _IndexItem extends StatelessWidget {
  const _IndexItem(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        text,
        style: const TextStyle(color: _textSecondary, fontWeight: FontWeight.w600),
      ),
      onTap: () {
      
      },
    );
  }
}
