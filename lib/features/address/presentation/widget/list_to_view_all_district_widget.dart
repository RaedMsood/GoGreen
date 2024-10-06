import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/features/address/data/models/address_model.dart';
import 'package:gogreen/features/address/data/models/district_model.dart';
import 'package:gogreen/features/address/presentation/riverpod/address_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'design_for_cities_and_districts_names_widget.dart';
import 'search_input_widget.dart';

class ListToViewAllDistrictWidget extends ConsumerStatefulWidget {
  final AddressModel address;
  final int cityId;

  const ListToViewAllDistrictWidget({
    super.key,
    required this.address,
    required this.cityId,
  });

  @override
  ConsumerState<ListToViewAllDistrictWidget> createState() =>
      _ListToViewAllDistrictWidgetState();
}

class _ListToViewAllDistrictWidgetState
    extends ConsumerState<ListToViewAllDistrictWidget> {
  TextEditingController searchForADist = TextEditingController();
  List<DistrictModel> items = [];

  @override
  void initState() {
    items = ref
        .read(districtsProvider.notifier)
        .state
        .data
        .where((element) => element.cityId == widget.cityId)
        .toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var districts = ref.watch(districtsProvider);

    return SizedBox(
      height: 400.h,
      child: ReactiveFormBuilder(
        form: () =>
            ref.read(addressStoreProvider(widget.address).notifier).form.group,
        builder: (context, form, child) {
          var districtByCity = districts.data
              .where((element) => element.cityId == form.value['city_id'])
              .toList();
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              14.h.verticalSpace,

              /// Class Search Input
              SearchInputWidget(
                search: searchForADist,
                onChanged: (searchItem) {
                  setState(() {
                    items = districtByCity
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
                          form.control('district_id').value = items[index].id;
                          form.control('district_name').value =
                              items[index].nameEn;
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
