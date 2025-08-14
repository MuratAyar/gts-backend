import 'package:flutter/material.dart';
import 'screens/listings_screen.dart';
import 'screens/filters_screen.dart';
void main() => runApp(const CraneFinderApp());

class CraneFinderApp extends StatelessWidget {
  const CraneFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CraneFinder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F9FC), // #f8f9fc
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF143DB8),
          primary: const Color(0xFF143DB8), // #143db8
          secondary: const Color(0xFF0E111B), // #0e111b
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF0E111B)),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum TopTab { cranes, equipment, parts }

class _HomeScreenState extends State<HomeScreen> {
  TopTab selectedTab = TopTab.cranes;

  // form selections
  String? category;
  String? make;
  String? model;

  bool agree = false;
  int bottomIndex = 0;

  final categories = const ['', 'All Terrain', 'Crawler', 'Rough Terrain'];
  final makes = const ['', 'Liebherr', 'Grove', 'Tadano'];
  final models = const ['', 'LTM 1100-5.2', 'GMK 4100L-1', 'GR-550XL'];

  final List<Map<String, String>> featured = const [
    {
      "img":
          "https://lh3.googleusercontent.com/aida-public/AB6AXuAnj7gIl1k5FNRZvx5zTBwMVrult5c7F_h8Ox_OOUXpDG_11TV577Zvs38OupbgckPSpBosJz7qq79_St_zXbIVpyonXetsp_RE8KlcO3IzQ-cGBaJdaDjyQjpY__gavoFcMpW8xnZiNRmYQVNB-KN2eB5_UFz0rU56hXbT-qgUdYmmqNvEaQSsJQwkIXu7VgAp8p6vkgO9b6JleK5WM4sfTn0X2toKVTxRCDEqmnr7y6cFD2o6yiParlDjfWnaUBzKih3_kLWDpQ",
      "title": "All Terrain Crane - 2023",
      "price": "\$1,200,000"
    },
    {
      "img":
          "https://lh3.googleusercontent.com/aida-public/AB6AXuAxtaxWMPd9PWXKzxW66MR7aDv1KMXvJ0rp_EVwNFlEu1c_PF6CTMCLyeFNZ5sdQ-aR8rZO6kEkBPHiddfKr9W8d_hZJLbmrc06FPWQ7W79VvnYEmYTlbfpx4wGjcxTiXpOgMkrEiZJbrB7Do-_S1Y26nbd_oDu9QUIkZLadz518SlrKbnO1wGaYizThIqd2vhVIPT20-_w_WVwMswmnFOFGDXIECLmnCsb4i_W5Da-GElu_5KqDHvkFyy44sDysdATQvm98jZMMA",
      "title": "Crawler Crane - 2022",
      "price": "\$850,000"
    },
    {
      "img":
          "https://lh3.googleusercontent.com/aida-public/AB6AXuChimDxd29IWLaAvaFx6iKmDkrSXsRm5l3zRXb8oDejDL0Fu0eCs8AuXQMnliX57A7HyK9JsTutDYHFXiIdg6VsMyWUe_CF9nJcck9ka7qH8IgWOTQcd2n51sdCr2qbu7XQGx-7odQRHN1nsmkHEPaDFRhV8egpHtESEFpYIK6WJgDVLH6EO2ELpQGn9fKut5Tm81WdcebKwIkbN5m0PrHO-Ps5Wq6Tj8DfVp8H5J4IsPqcXupKUgQco8APXDJWgXk-Rx0kwehhaQ",
      "title": "Rough Terrain Crane - 2021",
      "price": "\$600,000"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildBody()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomIndex,
        onTap: (i) => setState(() => bottomIndex = i),
        selectedItemColor: const Color(0xFF0E111B),
        unselectedItemColor: const Color(0xFF4E6097),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Listings'),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt_outlined), label: 'Camera'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined), label: 'Map'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (bottomIndex) {
      case 0:
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeaderBar(onMenu: () {}),
              _HeroSection(
                title: "Find the perfect crane for your project",
                subtitle:
                    "Explore our extensive inventory of cranes, equipment, and parts from leading manufacturers.",
                onSearch: () {},
              ),
              // Tabs
              Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFD0D6E7))),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _TopTabChip(
                      label: "Cranes",
                      selected: selectedTab == TopTab.cranes,
                      onTap: () => setState(() => selectedTab = TopTab.cranes),
                    ),
                    _TopTabChip(
                      label: "Equipment",
                      selected: selectedTab == TopTab.equipment,
                      onTap: () =>
                          setState(() => selectedTab = TopTab.equipment),
                    ),
                    _TopTabChip(
                      label: "Parts",
                      selected: selectedTab == TopTab.parts,
                      onTap: () => setState(() => selectedTab = TopTab.parts),
                    ),
                  ],
                ),
              ),

              // Dropdowns
              _LabeledDropdown(
                label: "Category",
                value: category,
                items: categories,
                onChanged: (v) => setState(() => category = v),
              ),
              _LabeledDropdown(
                label: "Manufacturer (Make)",
                value: make,
                items: makes,
                onChanged: (v) => setState(() => make = v),
              ),
              _LabeledDropdown(
                label: "Model",
                value: model,
                items: models,
                onChanged: (v) => setState(() => model = v),
              ),

              // Search button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                    backgroundColor: const Color(0xFF143DB8),
                    foregroundColor: const Color(0xFFF8F9FC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Search"),
                ),
              ),

              // Chips
              const _ChipRow(
                  chips: ["All Terrain", "Crawler", "Rough Terrain"]),

              // Featured
              const _SectionTitle("Featured Listings"),
              SizedBox(
                height: 210,
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  scrollDirection: Axis.horizontal,
                  itemCount: featured.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, i) {
                    final f = featured[i];
                    return _FeaturedCard(
                        imageUrl: f["img"]!,
                        title: f["title"]!,
                        price: f["price"]!);
                  },
                ),
              ),

              // Why choose us
              const _SectionTitle("Why Choose Us"),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      "CraneFinder Benefits",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "We offer a comprehensive marketplace for cranes, equipment, and parts, connecting buyers and sellers globally.",
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _FeatureCard(
                      icon: Icons.verified_user,
                      title: "Trusted Marketplace",
                      subtitle: "Verified listings and secure transactions.",
                    ),
                    _FeatureCard(
                      icon: Icons.local_shipping,
                      title: "Fast Shipping",
                      subtitle: "Efficient delivery to any location.",
                    ),
                    _FeatureCard(
                      icon: Icons.groups_2,
                      title: "Global Network",
                      subtitle:
                          "Access a wide range of international sellers and buyers.",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Stats
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: _StatCard(
                            label: "Active Listings", value: "+1.2K")),
                    SizedBox(width: 12),
                    Expanded(child: _StatCard(label: "Countries", value: "48")),
                    SizedBox(width: 12),
                    Expanded(
                        child: _StatCard(label: "Satisfaction", value: "99%")),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // How it works
              const _SectionTitle("How It Works"),
              const _TimelineSteps(
                steps: [
                  StepItem(Icons.add, "List Item"),
                  StepItem(Icons.check, "Approval"),
                  StepItem(Icons.upload, "Publish"),
                  StepItem(Icons.chat_bubble, "Messaging"),
                  StepItem(Icons.handshake, "Sell/Rent"),
                ],
              ),

              // Newsletter
              const _NewsletterBlock(),

              // Terms
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Checkbox(
                      value: agree,
                      activeColor: const Color(0xFF143DB8),
                      onChanged: (v) => setState(() => agree = v ?? false),
                    ),
                    const Expanded(
                      child: Text("I agree to the terms and conditions"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );

      case 1:
        return const _SimplePage(
          title: "Listings",
          subtitle: "Browse cranes, equipment and parts.",
          icon: Icons.list_alt,
        );

      case 2:
        return const _SimplePage(
          title: "Camera",
          subtitle: "Open camera to capture listing photos.",
          icon: Icons.camera_alt_outlined,
        );

      case 3:
        return const _SimplePage(
          title: "Map",
          subtitle: "See nearby listings on the map.",
          icon: Icons.location_on_outlined,
        );

      case 4:
        return const _ProfilePage();

      default:
        return const SizedBox.shrink();
    }
  }
}

// ---------------- UI PARTIALS ----------------

class _HeaderBar extends StatelessWidget {
  final VoidCallback onMenu;
  const _HeaderBar({required this.onMenu});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8F9FC),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          const Spacer(),
          const Text(
            "CraneFinder",
            style: TextStyle(
              color: Color(0xFF0E111B),
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onMenu,
            icon: const Icon(Icons.menu, color: Color(0xFF0E111B)),
          ),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onSearch;
  const _HeroSection({
    required this.title,
    required this.subtitle,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    const img =
        "https://lh3.googleusercontent.com/aida-public/AB6AXuAv3AjLCf_eHzJHNDLDsktFU2e7PhAZVNrO51PH29h9ptMpJmhv88gQNoE8hK-R_qS-eA3CQ8gDaumQ75lHjn0eaezkTsCG3UinCpimLCLJtzrJYZyazO2UkeVqrzGDztPpfARi0efyIj-Ndbh0k9wB96T-DGhLsBwMz7RVSTeJIeU1i_i7kq4otzXZlHrzudGL0uRQkjidoNcJuHa5pfYDZ0rsuwam1xlwnwyEhdOrO72qVsxnNtnLws50j63nKrQw5yLYGMVGig";

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(img, fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.4),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF143DB8),
                      foregroundColor: Color(0xFFF8F9FC),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: onSearch,
                    child: const Text("Search"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopTabChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _TopTabChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor =
        selected ? const Color(0xFF143DB8) : Colors.transparent;
    final textColor =
        selected ? const Color(0xFF0E111B) : const Color(0xFF4E6097);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 10),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Container(height: 3, color: borderColor),
            ],
          ),
        ),
      ),
    );
  }
}

class _LabeledDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  const _LabeledDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFD0D6E7)),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: value,
            items: items
                .map((e) => DropdownMenuItem(
                      value: e.isEmpty ? null : e,
                      child: Text(e.isEmpty ? '' : e),
                    ))
                .toList(),
            onChanged: onChanged,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFF8F9FC),
              enabledBorder: border,
              focusedBorder: border,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChipRow extends StatelessWidget {
  final List<String> chips;
  const _ChipRow({required this.chips});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: chips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFE7EAF3), // chip bg
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              chips[i],
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0E111B),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Color(0xFF0E111B),
          height: 1.1,
        ),
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  const _FeaturedCard({
    required this.imageUrl,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: 2,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFF0E111B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: const TextStyle(
              color: Color(0xFF4E6097),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 158),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFD0D6E7)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF0E111B)),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: Color(0xFF4E6097),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD0D6E7)),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

class StepItem {
  final IconData icon;
  final String label;
  const StepItem(this.icon, this.label);
}

class _TimelineSteps extends StatelessWidget {
  final List<StepItem> steps;
  const _TimelineSteps({required this.steps});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(steps.length, (i) {
          final step = steps[i];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  if (i > 0)
                    Container(
                      width: 1.5,
                      height: 8,
                      color: const Color(0xFFD0D6E7),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child:
                        Icon(step.icon, size: 22, color: const Color(0xFF0E111B)),
                  ),
                  if (i < steps.length - 1)
                    Container(
                      width: 1.5,
                      height: 24,
                      color: const Color(0xFFD0D6E7),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 16),
                  child: Text(
                    step.label,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _NewsletterBlock extends StatelessWidget {
  const _NewsletterBlock();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Column(
        children: [
          const Text(
            "Stay Updated",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Get the latest listings and industry news delivered to your inbox.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    filled: true,
                    fillColor: const Color(0xFFE7EAF3), // #e7eaf3
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 14),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF143DB8),
                  foregroundColor: const Color(0xFFF8F9FC),
                  minimumSize: const Size(110, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: const Text("Subscribe"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SimplePage extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const _SimplePage({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HeaderBar(onMenu: () {}),
        const SizedBox(height: 16),
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 64, color: const Color(0xFF4E6097)),
                const SizedBox(height: 16),
                Text(title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text(subtitle, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HeaderBar(onMenu: () {}),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 36,
                child: Icon(Icons.person, size: 40),
              ),
              const SizedBox(height: 12),
              const Text("Your Company",
                  style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              const Text("user@example.com"),
              const SizedBox(height: 16),
              _ProfileTile(
                  icon: Icons.collections_bookmark_outlined,
                  title: "My Listings",
                  onTap: () {}),
              const SizedBox(height: 8),
              _ProfileTile(
                  icon: Icons.favorite_border,
                  title: "Favorites",
                  onTap: () {}),
              const SizedBox(height: 8),
              _ProfileTile(
                  icon: Icons.workspace_premium_outlined,
                  title: "Subscription / Plan",
                  onTap: () {}),
              const SizedBox(height: 8),
              _ProfileTile(
                  icon: Icons.notifications_none,
                  title: "Notifications",
                  onTap: () {}),
              const SizedBox(height: 8),
              _ProfileTile(
                  icon: Icons.logout, title: "Log out", onTap: () {}),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _ProfileTile(
      {required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE6E9F2)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF0E111B)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
