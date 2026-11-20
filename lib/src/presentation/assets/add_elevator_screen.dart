import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gelismis_asansor_projesi/src/data/models/elevator_model.dart';
import 'package:gelismis_asansor_projesi/src/data/models/customer_model.dart';
import 'package:gelismis_asansor_projesi/src/data/repositories/customer_repository.dart';
import 'package:uuid/uuid.dart';

class AddElevatorScreen extends ConsumerStatefulWidget {
  final String? customerId; // Opsiyonel, detay sayfasından çağrılırsa dolu gelir.
  final ElevatorModel? elevatorToEdit;

  const AddElevatorScreen({super.key, this.customerId, this.elevatorToEdit});

  @override
  ConsumerState<AddElevatorScreen> createState() => _AddElevatorScreenState();
}

class _AddElevatorScreenState extends ConsumerState<AddElevatorScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _codeController;
  late final TextEditingController _idNumberController; // Yeni
  late final TextEditingController _nameController; // Brand/Model yerine Name
  late final TextEditingController _stopsController;
  late final TextEditingController _capacityPersonController;
  late final TextEditingController _capacityWeightController;
  late final TextEditingController _speedController;
  late final TextEditingController _usageTypeDetailController; // Yeni (Diğer için)

  ElevatorType _selectedType = ElevatorType.human; // Default
  String _driveType = 'Elektrik'; // Default: Elektrik, Hidrolik
  ElevatorTagColor _selectedTagColor = ElevatorTagColor.none;
  DateTime? _selectedTagDate;
  CustomerModel? _selectedCustomer;
  
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final elevator = widget.elevatorToEdit;
    
    _codeController = TextEditingController(text: elevator?.code);
    _idNumberController = TextEditingController(text: elevator?.idNumber);
    _nameController = TextEditingController(text: elevator?.name);
    _stopsController = TextEditingController(text: elevator?.stops?.toString());
    _capacityPersonController = TextEditingController(text: elevator?.capacityPerson?.toString());
    _capacityWeightController = TextEditingController(text: elevator?.capacityWeight?.toString());
    _speedController = TextEditingController(text: elevator?.speed?.toString());
    _usageTypeDetailController = TextEditingController(text: elevator?.usageTypeDetail);
    
    if (elevator != null) {
      _selectedType = elevator.type;
      _driveType = elevator.driveType ?? 'Elektrik';
      _selectedTagColor = elevator.tagColor;
      _selectedTagDate = elevator.tagDate;
      
      _selectedCustomer = elevator.customer;
    }

    // Eğer customerId parametre olarak geldiyse (ve düzenleme değilse veya müşteri seçili değilse)
    if (widget.customerId != null && _selectedCustomer == null) {
      final id = int.tryParse(widget.customerId!);
      if (id != null) {
        Future.microtask(() async {
           final customer = await ref.read(customerRepositoryProvider).getCustomerById(id);
           if (customer != null && mounted) {
             setState(() => _selectedCustomer = customer);
           }
        });
      }
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _idNumberController.dispose();
    _nameController.dispose();
    _stopsController.dispose();
    _capacityPersonController.dispose();
    _capacityWeightController.dispose();
    _speedController.dispose();
    _usageTypeDetailController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCustomer == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lütfen bir müşteri seçin')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final elevator = widget.elevatorToEdit;
      final ElevatorModel modelToSave;

      if (elevator != null) {
        // Edit Mode
        elevator.code = _codeController.text;
        elevator.idNumber = _idNumberController.text;
        elevator.name = _nameController.text;
        elevator.type = _selectedType;
        elevator.usageTypeDetail = _selectedType == ElevatorType.other ? _usageTypeDetailController.text : null;
        elevator.driveType = _driveType;
        elevator.stops = int.tryParse(_stopsController.text);
        elevator.capacityPerson = int.tryParse(_capacityPersonController.text);
        elevator.capacityWeight = int.tryParse(_capacityWeightController.text);
        elevator.speed = double.tryParse(_speedController.text);
        elevator.tagColor = _selectedTagColor;
        elevator.tagDate = _selectedTagDate;
        elevator.lastUpdatedLocal = DateTime.now();
        elevator.isSynced = false;
        modelToSave = elevator;
      } else {
        // Create Mode
        modelToSave = ElevatorModel(
          serverId: const Uuid().v4(),
          code: _codeController.text,
          idNumber: _idNumberController.text,
          name: _nameController.text, // Name
          type: _selectedType,
          usageTypeDetail: _selectedType == ElevatorType.other ? _usageTypeDetailController.text : null,
          driveType: _driveType,
          stops: int.tryParse(_stopsController.text),
          capacityPerson: int.tryParse(_capacityPersonController.text),
          capacityWeight: int.tryParse(_capacityWeightController.text),
          speed: double.tryParse(_speedController.text),
          tagColor: _selectedTagColor,
          tagDate: _selectedTagDate,
          isApproved: false,
          isSynced: false,
        );
        modelToSave.lastUpdatedLocal = DateTime.now();
      }
      
      // Link is handled by repo now, but we can set it here too for consistency
      modelToSave.customer = _selectedCustomer; 

      await ref.read(customerRepositoryProvider).addElevator(modelToSave, customer: _selectedCustomer);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(elevator != null ? 'Güncelleme başarılı.' : 'Asansör başarıyla eklendi.')),
        );

        // İlgili müşterinin detay provider'ını yenile ki asansör listesi güncellensin
        if (_selectedCustomer != null) {
          ref.invalidate(customerDetailProvider(_selectedCustomer!.id!));
        }

        context.pop();
       }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Hata: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _selectCustomer() async {
    if (widget.elevatorToEdit != null) return; 

    final customers = await ref.read(customerRepositoryProvider).getCustomers(CustomerFilter());
    if (!mounted) return;

    final selected = await showDialog<CustomerModel>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Müşteri Seç'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView.builder(
            itemCount: customers.length,
            itemBuilder: (ctx, i) => ListTile(
              title: Text(customers[i].name),
              onTap: () => Navigator.pop(ctx, customers[i]),
            ),
          ),
        ),
      ),
    );

    if (selected != null) {
      setState(() => _selectedCustomer = selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.elevatorToEdit != null ? 'Düzenle' : 'Yeni Asansör Ekle')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Müşteri Seçimi
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(_selectedCustomer?.name ?? 'Müşteri Seçiniz *', 
                  style: TextStyle(color: _selectedCustomer == null ? Colors.red : Colors.black, fontWeight: FontWeight.bold)
                ),
                subtitle: const Text('Asansörün bağlı olduğu bina'),
                trailing: widget.elevatorToEdit == null ? const Icon(Icons.arrow_drop_down) : null,
                onTap: widget.customerId == null && widget.elevatorToEdit == null ? _selectCustomer : null, 
              ),
              const Divider(),
              const SizedBox(height: 16),
              
              // Bina İçi Adı (Zorunlu ve En Üstte)
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Bina İçi Adı * (Örn: A Blok Asansörü)', 
                  border: OutlineInputBorder()
                ),
                validator: (v) => v!.isEmpty ? 'Zorunlu alan' : null,
              ),
              const SizedBox(height: 16),

              // Tahrik Tipi (Elektrik / Hidrolik)
              const Text('Tahrik Tipi', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Elektrik'),
                      // ignore: deprecated_member_use
                      value: 'Elektrik',
                      // ignore: deprecated_member_use
                      groupValue: _driveType,
                      // ignore: deprecated_member_use
                      onChanged: (v) => setState(() => _driveType = v!),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Hidrolik'),
                      // ignore: deprecated_member_use
                      value: 'Hidrolik',
                      // ignore: deprecated_member_use
                      groupValue: _driveType,
                      // ignore: deprecated_member_use
                      onChanged: (v) => setState(() => _driveType = v!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(
                  labelText: 'Asansör Seri No', 
                  hintText: 'Etiket üzerindeki kod',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _idNumberController,
                decoration: const InputDecoration(
                  labelText: 'Asansör Kimlik Numarası', 
                  hintText: '123456789/01',
                  border: OutlineInputBorder()
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                ],
              ),

              const SizedBox(height: 16),
              
              DropdownButtonFormField<ElevatorType>(
                initialValue: _selectedType,
                decoration: const InputDecoration(labelText: 'Kullanım Amacı', border: OutlineInputBorder()),
                items: ElevatorType.values.map((e) {
                   String label = '';
                   switch(e) {
                     case ElevatorType.human: label = 'İNSAN ASANSÖRÜ'; break;
                     case ElevatorType.freight: label = 'YÜK ASANSÖRÜ'; break;
                     case ElevatorType.stretcher: label = 'SEDYE ASANSÖRÜ'; break;
                     case ElevatorType.moncharge: label = 'MONŞARJ'; break;
                     case ElevatorType.vehicle: label = 'ARAÇ ASANSÖRÜ'; break;
                     case ElevatorType.service: label = 'SERVİS ASANSÖRÜ'; break;
                     case ElevatorType.disabled: label = 'ENGELLİ ASANSÖRÜ'; break;
                     case ElevatorType.platform: label = 'PLATFORM'; break;
                     case ElevatorType.other: label = 'DİĞER'; break;
                   }
                   return DropdownMenuItem(value: e, child: Text(label));
                }).toList(),
                onChanged: (v) => setState(() => _selectedType = v!),
              ),
              
              // Diğer seçiliyse detay alanı göster
              if (_selectedType == ElevatorType.other) ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _usageTypeDetailController,
                  decoration: const InputDecoration(labelText: 'Diğer (Belirtiniz)', border: OutlineInputBorder()),
                ),
              ],

              const SizedBox(height: 16),
              
              Row(
                children: [
                   Expanded(
                    child: TextFormField(
                      controller: _stopsController,
                      decoration: const InputDecoration(labelText: 'Durak', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                   Expanded(
                    child: TextFormField(
                      controller: _speedController,
                      decoration: const InputDecoration(labelText: 'Hız (m/s)', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
               const SizedBox(height: 16),
              Row(
                children: [
                   Expanded(
                    child: TextFormField(
                      controller: _capacityPersonController,
                      decoration: const InputDecoration(labelText: 'Kapasite (Kişi)', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                   Expanded(
                    child: TextFormField(
                      controller: _capacityWeightController,
                      decoration: const InputDecoration(labelText: 'Kapasite (Kg)', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Etiket Seçimi
              DropdownButtonFormField<ElevatorTagColor>(
                initialValue: _selectedTagColor,
                decoration: const InputDecoration(labelText: 'Etiket Rengi', border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: ElevatorTagColor.none, child: Text('ETİKET GİRİLMEDİ')),
                  DropdownMenuItem(value: ElevatorTagColor.red, child: Text('KIRMIZI ETİKET (60 Gün)')),
                  DropdownMenuItem(value: ElevatorTagColor.yellow, child: Text('SARI ETİKET (120 Gün)')),
                  DropdownMenuItem(value: ElevatorTagColor.blue, child: Text('MAVİ ETİKET (365 Gün)')),
                  DropdownMenuItem(value: ElevatorTagColor.green, child: Text('YEŞİL ETİKET (365 Gün)')),
                ],
                onChanged: (v) => setState(() => _selectedTagColor = v!),
              ),
              const SizedBox(height: 16),
              
              if (_selectedTagColor != ElevatorTagColor.none) ...[
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(_selectedTagDate == null ? 'Etiket Tarihi Seçiniz' : '${_selectedTagDate!.day}.${_selectedTagDate!.month}.${_selectedTagDate!.year}'),
                  leading: const Icon(Icons.date_range),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _selectedTagDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      setState(() => _selectedTagDate = date);
                    }
                  },
                ),
                const SizedBox(height: 16),
              ],

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
