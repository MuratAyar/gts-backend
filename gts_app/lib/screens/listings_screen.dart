import 'package:flutter/material.dart';

/// Design tokens (HTML renkleri)
const _bg = Color(0xFFF8F9FC);
const _textPrimary = Color(0xFF0E111B);
const _textSecondary = Color(0xFF4E6097);
const _chipBg = Color(0xFFE7EAF3);
const _border = Color(0xFFD0D6E7);
const _blue = Color(0xFF143DB8);

class ListingItem {
  final String brand;
  final String model;
  final String specs; // "2020 · 500T · 1000 hours"
  final String imageUrl;

  ListingItem(this.brand, this.model, this.specs, this.imageUrl);
}

class ListingsScreen extends StatefulWidget {
  const ListingsScreen({super.key});

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen>
    with SingleTickerProviderStateMixin {
  final _tabs = const ['Cranes', 'Equipment', 'Parts'];
  late final TabController _tabController;

  final _categories = const [
    'All Terrain',
    'Crawler',
    'Rough Terrain',
    'Truck Mounted',
    'Tower',
  ];
  String _sort = 'Newest';

  // Demo veriler (HTML’deki görsellerle eşleştirildi)
  final _items = <ListingItem>[
    ListingItem(
      'CraneCo',
      'Model X500',
      '2020 · 500T · 1000 hours',
      'https://lh3.googleusercontent.com/aida-public/AB6AXuDeWXMxb9H6N0moXlo1pY6r57ar8fkm3v2aBIWmxnYxwGHbalN7Z95QQmFmd1tRYl8ueCvNsdJgIOwWyEqgWG5fmr3JYRW6QCEwRX_5R_bLeXO0dbAzfrzau5-0WksJnFCwu7onw43xE8SjYaMihHzVLwz2i7y9mtuSgnjYqWSpwJ4PISH2O6r4taRUYb4ZBm1HD8Nlg_a5F6mclXCpFcur2A05xWzi-KcLT_tOBSwjsLdG0SsSvkTn_JuYNjcbtjmJfej7th9yxg',
    ),
    ListingItem(
      'CraneCo',
      'Model X500',
      '2020 · 500T · 1000 hours',
      'https://lh3.googleusercontent.com/aida-public/AB6AXuCmIOc6uP1B-QNMK-uX7IaIQ_2dJMK9j3ygZhZDzIekgYgqetBuJiQj5xJL4El5Gi5uieyIZAE703z9C5kVAEYZ_N4vijqGExqEq-KvWWiOgyTb0AmLualPXYjjIfpcb1awgrbs8N_Wp_Dis5IdPQNzCOIoSW0aa2g90UH0uu3jNyeBOl8byTCcqcXBlzNheH1J1SGchl9JcEJYu-X7QElGuPp74q1XcZyczPxtzAT8lozysNC-i1B-VP9TOaV6hfJGMrm8F7VGRg',
    ),
    ListingItem(
      'CraneCo',
      'Model X500',
      '2020 · 500T · 1000 hours',
      'https://lh3.googleusercontent.com/aida-public/AB6AXuAeNjEmMJpIMxjVtUGVDNzRxr48c7_8roF0Tt9gHofFIlFr1rtzvHx1GamWmuBIkPVnZYaPQ2pwfM0QLFJBXP_dgfgWEoklvoUFutFgMipcZRu4HEWP7uEB7cEpAST_CjsrAhPReZ9tb2x_OkxxtASeAyhzJEL_NN-fS9HUmE9_15UYt9q4heLuMQ7HNADd-7A7Qkm17LZr3DlbkxPnecCpUTnfP-y_OhCB8LAf98kG7w8slcEZU8q8MDdpdaJ68UzIRRYnEHKrqg',
    ),
    ListingItem(
      'CraneCo',
      'Model X500',
      '2020 · 500T · 1000 hours',
      'https://lh3.googleusercontent.com/aida-public/AB6AXuDBEtEldvSSs7MrFfd1frsB3PAoXoBSiUrs8zMBjaCPUbrg80mCbofzx01x23YrHbJybNrXD2HXL55GoqQ9w9OGiqZscqV0Wk8yJcSMjGHyM1WNlvi0QMl1lunOQZYJHtZhTuPhrBDq_lrhUoMbRJiYAtbpHnjjKG9NxbuB4dZ00eV-3TnclDSCnYbhWi-ryuibSQorgd7jT2tOOc8MpD78AIzokKH-O4zbRavb5W-md2aqLIRRznJ4F5cwpescmZdbwDAk4dHtaQ',
    ),
  ];

  int _bottomIndex = 1; // Listings seçili

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            // Üst başlık + filtre butonu
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 8, 6),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Listings',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.15,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Filters',
                    icon: const Icon(Icons.tune, color: _textPrimary),
                    onPressed: () async {
                      // Filtre ekranın varsa:
                      // await Navigator.pushNamed(context, '/filters');
                      // TODO: route eklemediysen yukarıdaki satırı yorumla.
                      // Geçici: sıralama bottom sheet’i gösterelim
                      _openSortSheet();
                    },
                  ),
                ],
              ),
            ),

            // Sekmeler
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: _border)),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: _textPrimary,
                unselectedLabelColor: _textSecondary,
                labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold, letterSpacing: 0.15),
                indicatorColor: _blue,
                tabs: _tabs.map((t) => Tab(text: t)).toList(),
              ),
            ),

            // Kategori chip’leri (yatay kaydırmalı)
            SizedBox(
              height: 48,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) => _chip(_categories[i]),
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemCount: _categories.length,
              ),
            ),

            // Sort by
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.transparent)),
                color: _bg,
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text('Sort by',
                        style: TextStyle(color: _textPrimary, fontSize: 16)),
                  ),
                  InkWell(
                    onTap: _openSortSheet,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_sort,
                            style: const TextStyle(
                                color: _textPrimary, fontSize: 16)),
                        const SizedBox(width: 4),
                        const Icon(Icons.expand_more, color: _textPrimary),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Liste
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: List.generate(
                  _tabs.length,
                  (index) => ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: _items.length,
                    itemBuilder: (context, i) => _listingCard(_items[i]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Alt menü (5’li)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomIndex,
        onTap: (i) {
          setState(() => _bottomIndex = i);
          // TODO: i'ye göre ilgili sayfaya yönlendirmeyi ekleyin.
          // Örn: if (i == 0) Navigator.pushReplacement(... HomeScreen());
          // Şimdilik sadece seçimi güncelliyoruz.
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: _bg,
        selectedItemColor: _textPrimary,
        unselectedItemColor: _textSecondary,
        selectedLabelStyle:
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        unselectedLabelStyle:
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            // “filled” efekti için aynı ikon ama seçili rengi farklı
            icon: Icon(Icons.list_alt),
            label: 'Listings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Post Ad',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // ————————————————— UI parçaları

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _chipBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: _textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _listingCard(ListingItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Sol metinler
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.brand,
                    style: const TextStyle(
                        color: _textSecondary, fontSize: 13)),
                const SizedBox(height: 2),
                Text(
                  item.model,
                  style: const TextStyle(
                      color: _textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(item.specs,
                    style: const TextStyle(
                        color: _textSecondary, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Sağ görsel (aspect-video)
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openSortSheet() async {
    final options = ['Newest', 'Oldest', 'Price (Low → High)', 'Price (High → Low)'];
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        itemBuilder: (c, i) => ListTile(
          title: Text(
            options[i],
            style: const TextStyle(
                color: _textPrimary, fontWeight: FontWeight.w600),
          ),
          trailing: options[i] == _sort
              ? const Icon(Icons.check, color: _blue)
              : null,
          onTap: () => Navigator.pop(c, options[i]),
        ),
        separatorBuilder: (_, __) => const Divider(height: 1, color: _border),
        itemCount: options.length,
      ),
    );

    if (selected != null) {
      setState(() => _sort = selected);
      // TODO: burada listeyi seçime göre sırala / sorguyu yenile
    }
  }
}
