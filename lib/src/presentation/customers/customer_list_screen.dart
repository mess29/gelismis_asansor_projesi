import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:gelismis_asansor_projesi/src/data/repositories/customer_repository.dart';

import 'package:gelismis_asansor_projesi/src/core/constants/turkey_cities.dart'; 

class CustomerListScreen extends ConsumerStatefulWidget {
  const CustomerListScreen({super.key});

  @override
  ConsumerState<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends ConsumerState<CustomerListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final customersAsync = ref.watch(customerListProvider);
    final filter = ref.watch(customerFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Müşteri & Bina Listesi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_special),
            tooltip: 'Bakım Bölgeleri',
            onPressed: () => context.goNamed('maintenance_groups'),
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            tooltip: 'Sıralama',
            onPressed: () => _showSortDialog(context, ref, filter),
          ),
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.filter_list),
                if (filter.city != null)
                   const Positioned(
                     right: 0,
                     top: 0,
                     child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
                   ),
              ],
            ),
            onPressed: () => _showFilterDialog(context, filter),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.pushNamed('add_customer');
          // Sayfa geri gelince listeyi yenile
          ref.invalidate(customerListProvider);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Ara (Bina Adı, Adres...)',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                ref.read(customerFilterProvider.notifier).state = filter.copyWith(query: value);
              },
            ),
          ),
          
          // Active Filters Chips
          if (filter.city != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    InputChip(
                      label: Text(filter.city!),
                      onDeleted: () {
                         ref.read(customerFilterProvider.notifier).state = filter.copyWith(city: null, district: null);
                      },
                      deleteIcon: const Icon(Icons.close, size: 18),
                    ),
                    const SizedBox(width: 8),
                    if (filter.district != null)
                       InputChip(
                        label: Text(filter.district!),
                        onDeleted: () {
                           ref.read(customerFilterProvider.notifier).state = filter.copyWith(district: null);
                        },
                        deleteIcon: const Icon(Icons.close, size: 18),
                      ),
                  ],
                ),
              ),
            ),

          Expanded(
            child: customersAsync.when(
              data: (customers) {
                if (customers.isEmpty) {
                  return const Center(child: Text('Kayıt bulunamadı.'));
                }
                return ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (context, index) {
                    final customer = customers[index];
                    return ListTile(
                      leading: const Icon(Icons.location_city),
                      title: Text(customer.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${customer.district}, ${customer.city}'),
                          Text(customer.address, style: const TextStyle(fontSize: 12)),
                          if (customer.maintenanceGroup != null)
                             Container(
                               margin: const EdgeInsets.only(top: 4),
                               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                               decoration: BoxDecoration(
                                 color: Colors.blue.shade50,
                                 borderRadius: BorderRadius.circular(4),
                                 border: Border.all(color: Colors.blue.shade200),
                               ),
                               child: Text(
                                 customer.maintenanceGroup!.name,
                                 style: TextStyle(color: Colors.blue.shade800, fontSize: 10, fontWeight: FontWeight.bold),
                               ),
                             ),
                        ],
                      ),
                      isThreeLine: true,
                      onTap: () {
                         context.goNamed(
                          'customer_detail',
                          pathParameters: {'customerId': customer.id.toString()},
                        );
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Hata: $err')),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context, CustomerFilter currentFilter) {
    String? selectedCity = currentFilter.city;
    String? selectedDistrict = currentFilter.district;
    List<String> districts = selectedCity != null ? (turkeyCities[selectedCity] ?? []) : [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Filtrele', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: selectedCity,
                    decoration: const InputDecoration(labelText: 'İl', border: OutlineInputBorder()),
                    items: turkeyCities.keys.map((city) {
                      return DropdownMenuItem(value: city, child: Text(city));
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedCity = val;
                        selectedDistrict = null; // Reset district
                        districts = val != null ? (turkeyCities[val] ?? []) : [];
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: selectedDistrict,
                    decoration: const InputDecoration(labelText: 'İlçe', border: OutlineInputBorder()),
                    items: districts.isNotEmpty 
                        ? districts.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList()
                        : [], 
                    onChanged: districts.isNotEmpty ? (val) {
                      setState(() => selectedDistrict = val);
                    } : null,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            ref.read(customerFilterProvider.notifier).state = CustomerFilter(query: currentFilter.query); // Reset but keep query
                            context.pop();
                          },
                          child: const Text('Temizle'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                             ref.read(customerFilterProvider.notifier).state = currentFilter.copyWith(
                               city: selectedCity,
                               district: selectedDistrict,
                             );
                             context.pop();
                          },
                          child: const Text('Uygula'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showSortDialog(BuildContext context, WidgetRef ref, CustomerFilter currentFilter) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(title: Text('Sıralama Ölçütü', style: TextStyle(fontWeight: FontWeight.bold))),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.sort_by_alpha),
                title: const Text('Ad (A-Z)'),
                trailing: currentFilter.sortField == SortField.name && currentFilter.sortOrder == SortOrder.asc ? const Icon(Icons.check) : null,
                onTap: () {
                  ref.read(customerFilterProvider.notifier).state = currentFilter.copyWith(sortField: SortField.name, sortOrder: SortOrder.asc);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.sort_by_alpha),
                title: const Text('Ad (Z-A)'),
                trailing: currentFilter.sortField == SortField.name && currentFilter.sortOrder == SortOrder.desc ? const Icon(Icons.check) : null,
                onTap: () {
                  ref.read(customerFilterProvider.notifier).state = currentFilter.copyWith(sortField: SortField.name, sortOrder: SortOrder.desc);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_city),
                title: const Text('İl (Adres)'),
                trailing: currentFilter.sortField == SortField.city ? const Icon(Icons.check) : null,
                onTap: () {
                  ref.read(customerFilterProvider.notifier).state = currentFilter.copyWith(sortField: SortField.city, sortOrder: SortOrder.asc);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.map),
                title: const Text('İlçe (Adres)'),
                trailing: currentFilter.sortField == SortField.district ? const Icon(Icons.check) : null,
                onTap: () {
                  ref.read(customerFilterProvider.notifier).state = currentFilter.copyWith(sortField: SortField.district, sortOrder: SortOrder.asc);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Eklenme Tarihi (Yeniden Eskiye)'),
                trailing: currentFilter.sortField == SortField.date && currentFilter.sortOrder == SortOrder.desc ? const Icon(Icons.check) : null,
                onTap: () {
                  ref.read(customerFilterProvider.notifier).state = currentFilter.copyWith(sortField: SortField.date, sortOrder: SortOrder.desc);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Eklenme Tarihi (Eskiden Yeniye)'),
                trailing: currentFilter.sortField == SortField.date && currentFilter.sortOrder == SortOrder.asc ? const Icon(Icons.check) : null,
                onTap: () {
                  ref.read(customerFilterProvider.notifier).state = currentFilter.copyWith(sortField: SortField.date, sortOrder: SortOrder.asc);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
