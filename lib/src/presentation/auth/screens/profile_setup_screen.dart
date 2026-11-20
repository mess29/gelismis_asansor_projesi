import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gelismis_asansor_projesi/src/core/router/app_router.dart';
import 'package:gelismis_asansor_projesi/src/data/models/user_profile.dart';
import 'package:gelismis_asansor_projesi/src/presentation/auth/providers/profile_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _companyController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  
  bool _isLoading = false;

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      setState(() => _isLoading = true);
      
      final prefs = await SharedPreferences.getInstance();
      final savedEmail = prefs.getString('savedEmail') ?? 'test@test.com';

      final userProfile = UserProfile(
        fullName: _fullNameController.text.trim(),
        companyName: _companyController.text.trim(),
        email: savedEmail,
        phoneNumber: _phoneController.text.trim(),
        age: _ageController.text.trim(),
      );

      await ref.read(profileProvider.notifier).updateProfile(userProfile);

      if (mounted) {
        setState(() => _isLoading = false);
        // Eğer geri dönebiliyorsak (Ayarlardan geldiyse) geri dön, yoksa dashboard'a git
        if (context.canPop()) {
          context.pop();
        } else {
          context.go(AppRoutes.dashboard);
        }
      }
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _companyController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Eğer kullanıcı profil bilgisi varsa alanları doldurur
    final profileAsyncValue = ref.watch(profileProvider);

    if (profileAsyncValue is AsyncData && profileAsyncValue.value != null && _fullNameController.text.isEmpty) {
      _fullNameController.text = profileAsyncValue.value!.fullName;
      _companyController.text = profileAsyncValue.value!.companyName;
      _phoneController.text = profileAsyncValue.value!.phoneNumber;
      _ageController.text = profileAsyncValue.value!.age;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Bilgileri'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primary.withValues(alpha: 0.8),
              theme.colorScheme.secondaryContainer,
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: 8),
              Icon(
                Icons.person_outline,
                size: 64,
                color: theme.colorScheme.onPrimary,
              ),
              const SizedBox(height: 12),
              Text(
                'Profilinizi Tamamlayın',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Sistemdeki işlemleriniz bu bilgilere göre kaydedilecektir. Gelecekte sahada kullanılacak detaylı bilgilerinizi aşağıdan ekleyebilirsiniz.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            'Kişisel ve Kurumsal Bilgiler',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                        controller: _fullNameController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Ad Soyad',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Ad Soyad boş olamaz';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      
                      TextFormField(
                        controller: _companyController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Firma / Şirket Adı',
                          prefixIcon: const Icon(Icons.business),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Firma adı boş olamaz';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Telefon Numarası',
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Telefon numarası boş olamaz';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _saveProfile(),
                        decoration: InputDecoration(
                          labelText: 'Yaş',
                          prefixIcon: const Icon(Icons.cake),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Yaş boş olamaz';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Lütfen geçerli bir sayı girin';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      
                      _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : FilledButton(
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: _saveProfile,
                              child: const Text(
                                'KAYDET VE DEVAM ET',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          const SizedBox(height: 48), // Alttan bolca boşluk
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
