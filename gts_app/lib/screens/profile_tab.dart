import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool isDarkMode = true;
  String currentLanguage = 'English';
  String currentCurrency = 'USD';
  String name = 'Ethan Carter';
  String username = '@ethan_carter';
  String profileImage =
      'https://lh3.googleusercontent.com/a-/YOUR_DEFAULT_PHOTO_URL';

  void _toggleTheme() {
    setState(() => isDarkMode = !isDarkMode);
  }

  void _editProfile() async {
    final nameController = TextEditingController(text: name);
    final usernameController = TextEditingController(text: username);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1d2030),
        title: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: 'Name', labelStyle: TextStyle(color: Colors.white)),
            ),
            TextField(
              controller: usernameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: 'Username', labelStyle: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final picker = ImagePicker();
                final image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  setState(() => profileImage = image.path);
                }
              },
              child: const Text('Change Photo'),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                name = nameController.text;
                username = usernameController.text;
              });
              Navigator.pop(context);
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  void _showSettingsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1d2030),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Preferences', style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Language', style: TextStyle(color: Colors.white)),
                DropdownButton<String>(
                  dropdownColor: const Color(0xFF1d2030),
                  value: currentLanguage,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (val) => setState(() => currentLanguage = val!),
                  items: const [
                    DropdownMenuItem(value: 'English', child: Text('English')),
                    DropdownMenuItem(value: 'Türkçe', child: Text('Türkçe')),
                    DropdownMenuItem(value: 'Deutsch', child: Text('Deutsch')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Currency', style: TextStyle(color: Colors.white)),
                DropdownButton<String>(
                  dropdownColor: const Color(0xFF1d2030),
                  value: currentCurrency,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (val) => setState(() => currentCurrency = val!),
                  items: const [
                    DropdownMenuItem(value: 'USD', child: Text('USD')),
                    DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                    DropdownMenuItem(value: 'TRY', child: Text('TRY')),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = isDarkMode ? Colors.white : Colors.black;
    final backgroundColor = isDarkMode ? const Color(0xFF131520) : Colors.white;
    final cardColor = isDarkMode ? const Color(0xFF1d2030) : Colors.grey[200];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Profile', style: TextStyle(color: themeColor)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: themeColor),
            onPressed: _showSettingsBottomSheet,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            CircleAvatar(
              radius: 60,
              backgroundImage: profileImage.startsWith('http')
                  ? NetworkImage(profileImage) as ImageProvider
                  : AssetImage(profileImage),
            ),
            const SizedBox(height: 10),
            Text(name, style: TextStyle(color: themeColor, fontSize: 20, fontWeight: FontWeight.bold)),
            Text(username, style: TextStyle(color: Colors.grey)),
            TextButton(
              onPressed: _editProfile,
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              children: [
                _infoCard('12', 'Listings', themeColor, cardColor!),
                _infoCard('3', 'Messages', themeColor, cardColor),
                _infoCard('2021', 'Member Since', themeColor, cardColor),
              ],
            ),
            const SizedBox(height: 16),
            _actionButton('My Listings', themeColor, cardColor),
            _actionButton('Favorites', themeColor, cardColor),
            _actionButton('Change Password', themeColor, cardColor),
            _actionButton('Notification Preferences', themeColor, cardColor),
            _actionButton('Contact Support', themeColor, cardColor),
            _actionButton('Log Out', themeColor, cardColor),
            const SizedBox(height: 20),
            SwitchListTile(
              title: Text('Dark Mode', style: TextStyle(color: themeColor)),
              value: isDarkMode,
              onChanged: (val) => _toggleTheme(),
              activeColor: Colors.orange,
            )
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String value, String label, Color textColor, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(value, style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold)),
          Text(label, style: TextStyle(color: textColor.withOpacity(0.6))),
        ],
      ),
    );
  }

  Widget _actionButton(String text, Color textColor, Color backgroundColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () {},
        child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
