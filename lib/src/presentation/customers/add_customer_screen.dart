import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gelismis_asansor_projesi/src/data/models/customer_model.dart';
import 'package:gelismis_asansor_projesi/src/data/repositories/customer_repository.dart';
import 'package:uuid/uuid.dart';

import 'package:gelismis_asansor_projesi/src/core/constants/turkey_cities.dart';
import 'package:gelismis_asansor_projesi/src/data/models/maintenance_group_model.dart';
import 'package:gelismis_asansor_projesi/src/presentation/maintenance/maintenance_group_detail_screen.dart';
import 'package:gelismis_asansor_projesi/src/presentation/maintenance/maintenance_group_list_screen.dart';

class AddCustomerScreen extends ConsumerStatefulWidget {
  final CustomerModel? customerToEdit;
  
  const AddCustomerScreen({super.key, this.customerToEdit});

  @override
  ConsumerState<AddCustomerScreen> createState() => _AddCustomerScreenState();
}


class _AddCustomerScreenState extends ConsumerState<AddCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _addressController;
  // late final TextEditingController _cityController; // Removed
  // late final TextEditingController _districtController; // Removed
  late final TextEditingController _authorizedPersonController;
  late final TextEditingController _phoneController;
  late final TextEditingController _notesController;
  late final TextEditingController _monthlyFeeController;

  String? _selectedCity;
  String? _selectedDistrict;
  List<String> _districts = [];

  List<MaintenanceGroupModel> _maintenanceGroups = [];
  MaintenanceGroupModel? _selectedGroup;
  bool _isCreatingNewGroup = false;
  final TextEditingController _newGroupNameController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMaintenanceGroups();
    final customer = widget.customerToEdit;
    
    _nameController = TextEditingController(text: customer?.name);
    _addressController = TextEditingController(text: customer?.address);
    // _cityController = TextEditingController(text: customer?.city);
    // _districtController = TextEditingController(text: customer?.district);
    _authorizedPersonController = TextEditingController(text: customer?.authorizedPerson);
    _phoneController = TextEditingController(text: customer?.phone);
    _notesController = TextEditingController(text: customer?.notes);
    _monthlyFeeController = TextEditingController(text: customer?.monthlyMaintenanceFee?.toString());

    if (customer != null) {
      _selectedCity = customer.city;
      _selectedDistrict = customer.district;
      // Populate districts if city is selected
      if (_selectedCity != null && turkeyCities.containsKey(_selectedCity)) {
        _districts = turkeyCities[_selectedCity]!;
      }
    }
  }

  Future<void> _loadMaintenanceGroups() async {
    final groups = await ref.read(customerRepositoryProvider).getMaintenanceGroups();
    
    if (mounted) {
      setState(() {
        _maintenanceGroups = groups;
      });
      
      if (widget.customerToEdit != null) {
         final currentGroup = widget.customerToEdit!.maintenanceGroup;
         
         if (mounted && currentGroup != null) {
            setState(() {
              // Listeden ID'si eşleşen grubu bulup seçili yapalım (Referans eşitliği için)
              try {
                _selectedGroup = _maintenanceGroups.firstWhere((g) => g.id == currentGroup.id);
              } catch (_) {
                // Eğer listede yoksa (silinmiş vs.) null kalsın
                _selectedGroup = null;
              }
            });
         }
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    // _cityController.dispose();
    // _districtController.dispose();
    _authorizedPersonController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    _monthlyFeeController.dispose();
    _newGroupNameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final customer = widget.customerToEdit;
      
      MaintenanceGroupModel? groupToAssign = _selectedGroup;

      if (_isCreatingNewGroup && _newGroupNameController.text.trim().isNotEmpty) {
          final repo = ref.read(customerRepositoryProvider);
          final newName = _newGroupNameController.text.trim();
          final newGroupId = await repo.createMaintenanceGroup(newName);
          // Reload to get the object
          // Instead of reloading all, we can try to get the specific group or just reload all and find by ID
          final groups = await repo.getMaintenanceGroups();
          try {
             groupToAssign = groups.firstWhere((g) => g.id == newGroupId);
          } catch (_) {
             if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Yeni grup oluşturulamadı veya bulunamadı.')));
          }
      }
      
      final CustomerModel modelToSave;
      // ... (code for creating modelToSave)
      
      if (customer != null) {
        // Düzenleme modu
        customer.name = _nameController.text;
        customer.address = _addressController.text;
        customer.city = _selectedCity!;
        customer.district = _selectedDistrict!;
        customer.authorizedPerson = _authorizedPersonController.text;
        customer.phone = _phoneController.text;
        customer.notes = _notesController.text;
        customer.monthlyMaintenanceFee = double.tryParse(_monthlyFeeController.text);
        customer.lastUpdatedLocal = DateTime.now();
        customer.isSynced = false;
        
        modelToSave = customer;
      } else {
         // Yeni kayıt
         modelToSave = CustomerModel(
           // ...
           serverId: const Uuid().v4(),
           name: _nameController.text,
           address: _addressController.text,
           city: _selectedCity!,
           district: _selectedDistrict!,
           authorizedPerson: _authorizedPersonController.text,
           phone: _phoneController.text,
           notes: _notesController.text,
           monthlyMaintenanceFee: double.tryParse(_monthlyFeeController.text),
           isApproved: false,
           isSynced: false,
         );
         modelToSave.lastUpdatedLocal = DateTime.now();
      }

       final repo = ref.read(customerRepositoryProvider);
       // Pass group explicitly
       final savedId = await repo.addCustomer(modelToSave, group: groupToAssign);

       if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(customer != null ? 'Güncelleme başarılı.' : 'Bina başarıyla eklendi.')),
        );
        
        // Force refresh multiple providers
        ref.invalidate(customerListProvider);
        if (customer != null) {
            ref.invalidate(customerDetailProvider(customer.id!));
        }
        if (groupToAssign != null) {
            // refresh existing group details if we added to it
             ref.invalidate(maintenanceGroupDetailProvider(groupToAssign.id!)); 
             ref.invalidate(maintenanceGroupsProvider); // Refresh the list of groups
        }
        
        if (customer == null) {
           // Yeni eklendi, ilk asansörü ekleme sayfasına yönlendir
           context.pushReplacementNamed(
             'add_elevator', 
             pathParameters: {'customerId': savedId.toString()}
           );
        } else {
           // Sadece güncelleme yapıldı, asansör var mı kontrol et
           
           if (!mounted) return;
           
           if (customer.elevators.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Dikkat: Bu binanın henüz kayıtlı bir asansörü bulunmamaktadır! Lütfen en az bir asansör ekleyin.'),
                  backgroundColor: Colors.orange,
                  duration: Duration(seconds: 4),
                )
              );
           }
           context.pop();
        }
      }

    } catch (e) {
      if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hata: $e')));
      }
    } finally {
       if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.customerToEdit != null ? 'Düzenle' : 'Yeni Bina/Müşteri Ekle')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Bina / Müşteri Adı *', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Zorunlu alan' : null,
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _selectedCity,
                      decoration: const InputDecoration(labelText: 'İl *', border: OutlineInputBorder()),
                      items: turkeyCities.keys.map((city) {
                        return DropdownMenuItem(value: city, child: Text(city));
                      }).toList(),
                      onChanged: (val) {
                         setState(() {
                           _selectedCity = val;
                           _selectedDistrict = null; // İl değişince ilçeyi sıfırla
                           if (val != null) {
                             _districts = turkeyCities[val] ?? [];
                           } else {
                             _districts = [];
                           }
                         });
                      },
                      validator: (v) => v == null ? 'İl seçiniz' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _selectedDistrict,
                      decoration: const InputDecoration(labelText: 'İlçe *', border: OutlineInputBorder()),
                      items: _districts.map((district) {
                        return DropdownMenuItem(value: district, child: Text(district));
                      }).toList(),
                      onChanged: (val) {
                         setState(() => _selectedDistrict = val);
                      },
                      validator: (v) => v == null ? 'İlçe seçiniz' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Açık Adres', border: OutlineInputBorder()),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _authorizedPersonController,
                decoration: const InputDecoration(labelText: 'Yetkili Kişi', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
               TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Telefon', border: OutlineInputBorder()),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notlar', border: OutlineInputBorder()),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _monthlyFeeController,
                decoration: const InputDecoration(labelText: 'Aylık Bakım Ücreti (TL)', border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 16),
              const Divider(),
              Text('Bakım Grubu / Bölge Seçimi', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              
              if (!_isCreatingNewGroup)
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<MaintenanceGroupModel>(
                        initialValue: _selectedGroup,
                        decoration: const InputDecoration(
                          labelText: 'Bakım Grubu',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          const DropdownMenuItem<MaintenanceGroupModel>(
                            value: null,
                            child: Text('Seçiniz / Yok'),
                          ),
                          ..._maintenanceGroups.map((group) {
                            return DropdownMenuItem(
                              value: group, 
                              child: Text(group.name),
                            );
                          }),
                        ],
                        onChanged: (val) {
                          setState(() {
                            _selectedGroup = val;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton.filledTonal(
                      icon: const Icon(Icons.add),
                      tooltip: 'Yeni Grup Oluştur',
                      onPressed: () {
                        setState(() {
                          _isCreatingNewGroup = true;
                          _selectedGroup = null;
                        });
                      },
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _newGroupNameController,
                        decoration: const InputDecoration(
                          labelText: 'Yeni Grup Adı',
                          border: OutlineInputBorder(),
                          hintText: 'Örn: Bölge 3',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton.filledTonal(
                      icon: const Icon(Icons.close),
                      tooltip: 'İptal',
                      onPressed: () {
                        setState(() {
                          _isCreatingNewGroup = false;
                          _newGroupNameController.clear();
                        });
                      },
                    ),
                  ],
                ),
                
               const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _isLoading ? null : _save,
                  icon: const Icon(Icons.save),
                  label: _isLoading ? const CircularProgressIndicator() : const Text('KAYDET'),
                  style: FilledButton.styleFrom(padding: const EdgeInsets.all(16)),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
