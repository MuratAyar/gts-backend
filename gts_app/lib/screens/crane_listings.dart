import 'package:flutter/material.dart';

class CraneListingsPage extends StatefulWidget {
  const CraneListingsPage({super.key});

  @override
  State<CraneListingsPage> createState() => _CraneListingsPageState();
}

class _CraneListingsPageState extends State<CraneListingsPage> {
  final textColor = const Color(0xFF8e9acc);
  final cardColor = const Color(0xFF181d35);
  final bgColor = const Color(0xFF101323);

  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> allCranes = [
    {
      "title": "Mobile Crane",
      "specs": "Capacity: 50 tons · Year: 2018 · Condition: Excellent",
      "desc": "Location: Industrial Park · Description: Well-maintained mobile crane.",
      "image":
          "https://lh3.googleusercontent.com/aida-public/AB6AXuDarSLJtlDR2lRA0oH94DBbRpJgiDOrYMCdAfmV8tEgqv12QP8tK7_UV4pirervwIL2a6UENOJNyaPLkwFT4g6NiAzmGcdwiBhrYHgb6ybeS0Cfje_GPOLuxH-L5d_BmQs4KUXaYNxqg81lfy9jdD21klbi4L5cmsC4Fq3oCo-O7GlzW68A_f3lvr5yP7JbTUaNwASdUEJ4SCI0h92i270wthMw0whFcWe58TLPvnnGlqS155VOH6x0hPTuFPAAZaezAiHRpsGa6Oc"
    },
    {
      "title": "Tower Crane",
      "specs": "Capacity: 100 tons · Year: 2015 · Condition: Good",
      "desc": "Location: Construction Site · Description: Reliable tower crane for heavy lifting.",
      "image":
          "https://lh3.googleusercontent.com/aida-public/AB6AXuB9ftzS1vTZSE1uz6YZvsAFOjd0LwzKkcfPce7lSanSbaGsuTS5W4B-_wuHPCWAt2MUqNj6ps8haj3QNs3Rt3LAOUS22Ygi_SDMb3riczZ2JOAIf9-Yl_9vcPGoKbJGXJUDiymd-oGZGXguRDv89Iimb3cGI5Z6xZDTI0gVHqHNHgPL9ig1maQ148ak3OnPZZgvM6eb8UWY8jzlttOcI4Re5uuAtosoyBa5f11vYtanBfeETxPRpq9_UqFklFlJ0vCZiT5FBSTFkDM"
    },
    {
      "title": "Gantry Crane",
      "specs": "Capacity: 75 tons · Year: 2017 · Condition: Good",
      "desc": "Location: Port Area · Description: Durable gantry crane for port operations.",
      "image":
          "https://lh3.googleusercontent.com/aida-public/AB6AXuCj6N55yLHCbPXYIu2_zGZgQj_LwscOG4sCBef0XD6h2NqTCBGdXZeU9YWIgXh3NNELbQDf6QDrsLb9udcWOYeIHRitUk_vuVzsNo6qCO4g4rGljDbkdlxO1pEhczeqJoxELhPuH8YrJXDfwCHZhrFCh4xSiEEs2fIGejg7UssyHgMvn2bHrS2RkREWXlbKDuQghdzl1un9RPwnjfOQuFW3-pFRbsauvHjxzz-7SN6OYmTMJTiYLeScKmi_v0wCOcPDOU6ZqjPuaaY"
    },
    // Daha fazla vinç eklenebilir
  ];

  String searchTerm = "";

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredCranes = allCranes
        .where((crane) =>
            crane['title']!.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();

    Widget craneCard(Map<String, String> crane) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(crane["specs"]!, style: TextStyle(color: textColor, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text(crane["title"]!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(crane["desc"]!, style: TextStyle(color: textColor, fontSize: 12)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(crane["image"]!, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Burada detay sayfasına geçilebilir
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF282d43),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("İncele"),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Üst başlık
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Spacer(),
                  const Text(
                    "Crane Listings",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.tune, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Arama çubuğu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                onChanged: (val) {
                  setState(() {
                    searchTerm = val;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search cranes...",
                  hintStyle: TextStyle(color: textColor),
                  filled: true,
                  fillColor: cardColor,
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Filtrelenmiş liste
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredCranes.length,
                itemBuilder: (context, index) {
                  return craneCard(filteredCranes[index]);
                },
              ),
            ),
          ],
        ),
      ),

      // Alt navigasyon
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: cardColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: textColor,
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Listings'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          // Giriş yapılmamışsa login'e yönlendirme burada yapılabilir
        },
      ),
    );
  }
}
  