import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/features/address/data/models/address_model.dart';
import 'package:gogreen/features/address/data/models/city_model.dart';
import 'package:gogreen/features/address/presentation/riverpod/address_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'design_for_cities_and_districts_names_widget.dart';
import 'search_input_widget.dart';

class ListToViewAllCitiesWidget extends ConsumerStatefulWidget {
  final AddressModel address;
  final int stateId;

  const ListToViewAllCitiesWidget({super.key, required this.address,required this.stateId});

  @override
  ConsumerState<ListToViewAllCitiesWidget> createState() =>
      _ListToViewAllCitiesWidgetState();
}

class _ListToViewAllCitiesWidgetState
    extends ConsumerState<ListToViewAllCitiesWidget> {
  TextEditingController searchForACity = TextEditingController();
  List<CityModel> items = [];

  @override
  void initState() {
    items = ref
        .read(citiesProvider.notifier)
        .state
        .data
        .where((element) => element.stateId == widget.stateId)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cities = ref.watch(citiesProvider);

    return SizedBox(
      height: 400.h,
      child: ReactiveFormBuilder(
        form: () =>
            ref.read(addressStoreProvider(widget.address).notifier).form.group,
        builder: (context, form, child) {
          var citiesByState = cities.data
              .where((element) => element.stateId == form.value['state_id'])
              .toList();
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              14.h.verticalSpace,

              /// Class Search Input
              SearchInputWidget(
                search: searchForACity,
                onChanged: (searchItem) {
                  setState(() {
                    items = citiesByState
                        .where((element) => element.nameEn
                        .toString()
                        .toUpperCase()
                        .contains(searchItem.toString().toUpperCase()))
                        .toList();
                  });
                },
              ),

              /// Class Search Results Are Empty
              if (items.isEmpty) const SearchResultsAreEmptyWidget(),

              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.all(14.sp),
                  itemBuilder: (context, index) {
                    return DesignForCitiesAndDistrictsNamesWidget(
                      name: items[index].nameEn.toString(),
                      onTap: () {
                        setState(() {
                          form.control('city_id').value = items[index].id;
                          form.control('city_name').value = items[index].nameEn;
                          form.patchValue({'district_id': null});
                          form.patchValue({'district_name': null});
                        });

                        Navigator.of(context).pop();
                      },
                    );
                  },
                  itemCount: items.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
