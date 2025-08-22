import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mon_appli/home/login_page.dart';

class Parametres extends StatefulWidget {
  const Parametres({super.key});

  @override
  State<Parametres> createState() => ParametresState();
}

class ParametresState extends State<Parametres> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;

  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _biometricAuthEnabled = false;
  String _selectedLanguage = 'Français';
  String _selectedTheme = 'Auto';

  final List<String> _languages = ['Français', 'English', 'Español'];
  final List<String> _themes = ['Auto', 'Clair', 'Sombre'];

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
  }

  void _signOut() async {
    try {
      await _auth.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur de déconnexion: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer le compte'),
        content: const Text(
          'Êtes-vous sûr de vouloir supprimer définitivement votre compte ? Cette action est irréversible.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Ici vous ajouterez la logique de suppression du compte
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fonctionnalité de suppression à implémenter'),
                ),
              );
            },
            child: const Text(
              'Supprimer',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Changer la langue'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _languages.length,
            itemBuilder: (context, index) {
              final language = _languages[index];
              return ListTile(
                title: Text(language),
                trailing: _selectedLanguage == language
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  setState(() {
                    _selectedLanguage = language;
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Changer le thème'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _themes.length,
            itemBuilder: (context, index) {
              final theme = _themes[index];
              return ListTile(
                title: Text(theme),
                trailing: _selectedTheme == theme
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () {
                  setState(() {
                    _selectedTheme = theme;
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Section Profil
          _buildSectionHeader('Profil'),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(
                        Icons.person,
                        color: Colors.blue.shade800,
                        size: 30,
                      ),
                    ),
                    title: Text(
                      _currentUser?.displayName ?? 'Utilisateur',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      _currentUser?.email ?? 'Non connecté',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // Navigation vers la page d'édition du profil
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: BorderSide(color: Colors.blue.shade400),
                          ),
                          child: Text(
                            'Modifier le profil',
                            style: TextStyle(
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Section Préférences
          _buildSectionHeader('Préférences'),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildSettingSwitch(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  subtitle: 'Activer/désactiver les notifications',
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
                _buildDivider(),
                _buildSettingSwitch(
                  icon: Icons.dark_mode,
                  title: 'Mode sombre',
                  subtitle: 'Activer le mode sombre',
                  value: _darkModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      _darkModeEnabled = value;
                    });
                  },
                ),
                _buildDivider(),
                _buildSettingSwitch(
                  icon: Icons.fingerprint,
                  title: 'Authentification biométrique',
                  subtitle: 'Déverrouiller avec empreinte/visage',
                  value: _biometricAuthEnabled,
                  onChanged: (value) {
                    setState(() {
                      _biometricAuthEnabled = value;
                    });
                  },
                ),
                _buildDivider(),
                _buildSettingOption(
                  icon: Icons.language,
                  title: 'Langue',
                  subtitle: _selectedLanguage,
                  onTap: _showLanguageDialog,
                ),
                _buildDivider(),
                _buildSettingOption(
                  icon: Icons.palette,
                  title: 'Thème',
                  subtitle: _selectedTheme,
                  onTap: _showThemeDialog,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Section Confidentialité et sécurité
          _buildSectionHeader('Confidentialité et sécurité'),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildSettingOption(
                  icon: Icons.lock,
                  title: 'Changer le mot de passe',
                  subtitle: 'Mettre à jour votre mot de passe',
                  onTap: () {
                    // Navigation vers le changement de mot de passe
                  },
                ),
                _buildDivider(),
                _buildSettingOption(
                  icon: Icons.security,
                  title: 'Sécurité',
                  subtitle: 'Paramètres de sécurité avancés',
                  onTap: () {
                    // Navigation vers les paramètres de sécurité
                  },
                ),
                _buildDivider(),
                _buildSettingOption(
                  icon: Icons.visibility_off,
                  title: 'Confidentialité',
                  subtitle: 'Gérer vos données personnelles',
                  onTap: () {
                    // Navigation vers les paramètres de confidentialité
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Section Aide et support
          _buildSectionHeader('Aide et support'),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildSettingOption(
                  icon: Icons.help,
                  title: 'Centre d\'aide',
                  subtitle: 'Trouver des réponses à vos questions',
                  onTap: () {
                    // Navigation vers le centre d'aide
                  },
                ),
                _buildDivider(),
                _buildSettingOption(
                  icon: Icons.contact_support,
                  title: 'Nous contacter',
                  subtitle: 'Support technique et assistance',
                  onTap: () {
                    // Navigation vers le formulaire de contact
                  },
                ),
                _buildDivider(),
                _buildSettingOption(
                  icon: Icons.info,
                  title: 'À propos',
                  subtitle: 'Informations sur l\'application',
                  onTap: () {
                    // Navigation vers la page À propos
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Section Compte
          _buildSectionHeader('Compte'),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildSettingOption(
                  icon: Icons.exit_to_app,
                  title: 'Déconnexion',
                  subtitle: 'Se déconnecter de votre compte',
                  onTap: _signOut,
                  isDestructive: true,
                ),
                _buildDivider(),
                _buildSettingOption(
                  icon: Icons.delete,
                  title: 'Supprimer le compte',
                  subtitle: 'Supprimer définitivement votre compte',
                  onTap: _showDeleteAccountDialog,
                  isDestructive: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Version de l'application
          Center(
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.blueGrey,
        ),
      ),
    );
  }

  Widget _buildSettingSwitch({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon, color: Colors.blue.shade700),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey.shade600),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.blue,
    );
  }

  Widget _buildSettingOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : Colors.blue.shade700,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isDestructive ? Colors.red : null,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: isDestructive ? Colors.red.shade600 : Colors.grey.shade600,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 56,
      endIndent: 16,
      color: Colors.grey.shade200,
    );
  }
}