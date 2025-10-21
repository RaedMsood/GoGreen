import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'card_design_for_order_details_widget.dart';
import 'design_for_bill_data_widget.dart';

class BillOfOrderDetailsWidget extends StatelessWidget {
  final String orderStatus;
  final String orderNumber;
  final String theDate;
  final String priceOfProducts;
  final String deliveryPrice;
  final String totalSummation;

  const BillOfOrderDetailsWidget({
    super.key,
    required this.orderStatus,
    required this.orderNumber,
    required this.theDate,
    required this.priceOfProducts,
    required this.deliveryPrice,
    required this.totalSummation,
  });

  @override
  Widget build(BuildContext context) {
    // DateTime dateOrder = DateTime.parse(fromTimeGo);

    return CardDesignForOrderDetailsWidget(
      title: "The details",
      icon: Icons.file_open,
      child: Column(
        children: [
          DesignForBillDataWidget(
            title: "Order status",
            title2: orderStatus.toString(),
          ),
          DesignForBillDataWidget(
            title: "order number",
            title2: orderNumber.toString(),
          ),
          DesignForBillDataWidget(
            title: "the date",
            title2: theDate.toString(),
          ),
          DesignForBillDataWidget(
            title: "Price of products",
            title2: priceOfProducts.toString(),
          ),

          DesignForBillDataWidget(
            title: "Delivery price",
            title2: deliveryPrice.toString(),
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 0.4,
          ),
          3.h.verticalSpace,
          DesignForBillDataWidget(
            title: "total summation",
            title2: totalSummation.toString(),
          ),
        ],
      ),
    );
  }
}
