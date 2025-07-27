import 'package:flutter/material.dart';

class ListingsTab extends StatelessWidget {
  const ListingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF131520);
    const textColor = Colors.white;
    const subTextColor = Color(0xFF99a0c2);

    Widget craneItem({
      required String title,
      required String capacity,
      required String location,
      required String imageUrl,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text("Capacity: $capacity", style: const TextStyle(color: subTextColor, fontSize: 13)),
                  Text("Location: $location", style: const TextStyle(color: subTextColor, fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Crane Listings",
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          craneItem(
            title: 'Mobile Crane',
            capacity: '50 tons',
            location: 'Industrial Park',
            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDarSLJtlDR2lRA0oH94DBbRpJgiDOrYMCdAfmV8tEgqv12QP8tK7_UV4pirervwIL2a6UENOJNyaPLkwFT4g6NiAzmGcdwiBhrYHgb6ybeS0Cfje_GPOLuxH-L5d_BmQs4KUXaYNxqg81lfy9jdD21klbi4L5cmsC4Fq3oCo-O7GlzW68A_f3lvr5yP7JbTUaNwASdUEJ4SCI0h92i270wthMw0whFcWe58TLPvnnGlqS155VOH6x0hPTuFPAAZaezAiHRpsGa6Oc',
          ),
          craneItem(
            title: 'Tower Crane',
            capacity: '100 tons',
            location: 'Construction Site',
            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB9ftzS1vTZSE1uz6YZvsAFOjd0LwzKkcfPce7lSanSbaGsuTS5W4B-_wuHPCWAt2MUqNj6ps8haj3QNs3Rt3LAOUS22Ygi_SDMb3riczZ2JOAIf9-Yl_9vcPGoKbJGXJUDiymd-oGZGXguRDv89Iimb3cGI5Z6xZDTI0gVHqHNHgPL9ig1maQ148ak3OnPZZgvM6eb8UWY8jzlttOcI4Re5uuAtosoyBa5f11vYtanBfeETxPRpq9_UqFklFlJ0vCZiT5FBSTFkDM',
          ),
          craneItem(
            title: 'Overhead Crane',
            capacity: '25 tons',
            location: 'Warehouse District',
            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDMdnhp-t3sZNaWo7QORGhTSIW-Wt1MrQjlAK5WNiewAR-Xbakkfm90sPinUAzmnXXxZ0eiiCuRXbHlG-xXhGPEisW53FzHSdV_LHvOVEAks0Y99lntLGop_G4YE4YtxPfOt2j1S3XDiWYbdKbTAm2j9SjeUyZMYmabe_D56Z7cDgCFu6WCfqZfCmuTduXEhhCm-Cks3wuO_a-GepzgxsbTlvjqZl-V3dn-oH5nV5S_tBEYrS9MWNFFRZx4mFvCmLIy5ZGeu2Vi8TQ',
          ),
          craneItem(
            title: 'Gantry Crane',
            capacity: '75 tons',
            location: 'Port Area',
            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCj6N55yLHCbPXYIu2_zGZgQj_LwscOG4sCBef0XD6h2NqTCBGdXZeU9YWIgXh3NNELbQDf6QDrsLb9udcWOYeIHRitUk_vuVzsNo6qCO4g4rGljDbkdlxO1pEhczeqJoxELhPuH8YrJXDfwCHZhrFCh4xSiEEs2fIGejg7UssyHgMvn2bHrS2RkREWXlbKDuQghdzl1un9RPwnjfOQuFW3-pFRbsauvHjxzz-7SN6OYmTMJTiYLeScKmi_v0wCOcPDOU6ZqjPuaaY',
          ),
          craneItem(
            title: 'Jib Crane',
            capacity: '15 tons',
            location: 'Manufacturing Plant',
            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAuEQmXKz45BibHSERLVXgmeaQp8JdDE9uM-XJjdLgxoULKx9A5gJxGGjwlBuY1_WXtzi0sZ-hzHRP9sel_4E7SVsZDlciCKAaCTA4nm3Dn-MYe8u7HUthEVlWO3bUzK72LmlG9lYiiVmNieVIp3d8ihOc1rpa37a-YwUsHtlelsH97PvQenN2wLdazHy-9eY-iQ6QUgcWkXa9PHcbDUhfzQNf2C_jt4bQnJWRCN844gYViWP6vKmrx_WHoOMOn0EEaG-0bbMKgARI',
          ),
        ],
      ),
    );
  }
}
