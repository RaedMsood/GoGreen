import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gogreen/features/address/data/models/address_model.dart';
import 'package:gogreen/features/address/data/models/states_model.dart';
import 'package:gogreen/features/address/presentation/riverpod/address_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'design_for_cities_and_districts_names_widget.dart';
import 'search_input_widget.dart';

class ListToViewAllStatesWidget extends ConsumerStatefulWidget {
  final AddressModel address;

  const ListToViewAllStatesWidget({super.key, required this.address});

  @override
  ConsumerState<ListToViewAllStatesWidget> createState() =>
      _ListToViewAllStatesWidgetState();
}

class _ListToViewAllStatesWidgetState
    extends ConsumerState<ListToViewAllStatesWidget> {
  TextEditingController searchForACity = TextEditingController();
  List<StatesModel> items = [];

  @override
  void initState() {
    items = ref.read(statesProvider.notifier).state.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var states = ref.watch(statesProvider);

    return SizedBox(
      height: 400.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          14.h.verticalSpace,

          /// Class Search Input
          SearchInputWidget(
            search: searchForACity,
            onChanged: (searchItem) {
              setState(() {
                items = states.data
                    .where((element) => element.name
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
                return ReactiveFormBuilder(
                  form: () => ref
                      .read(addressStoreProvider(widget.address).notifier)
                      .form
                      .group,
                  builder: (context, form, child) {
                    return DesignForCitiesAndDistrictsNamesWidget(
                      name: items[index].name.toString(),
                      onTap: () {
                        setState(() {
                          form.control('state_id').value = items[index].id;
                          form.control('state_name').value = items[index].name;
                          form.patchValue({'city_id': null});
                          form.patchValue({'city_name': null});
                          form.patchValue({'district_id': null});
                          form.patchValue({'district_name': null});
                        });

                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
              itemCount: items.length,
            ),
          ),
        ],
      ),
    );
  }
}
