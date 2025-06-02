import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconGrid extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      'iconPath': 'assets/svgs/todays_rate.svg',
      'label': "Today's Rate",
      'route': '/todaysRate',
    },
    {
      'iconPath': 'assets/svgs/stock_entry.svg',
      'label': "Stock Entry",
      'route': '/stockEntry',
    },
    {
      'iconPath': 'assets/svgs/crm.svg',
      'label': "CRM",
      'route': '/crm',
    },
    {
      'iconPath': 'assets/svgs/jewellery_catalogue.svg',
      'label': "Jewellery Catalogue",
      'route': '/jewelleryCatalogue',
    },
    {
      'iconPath': 'assets/svgs/purchase.svg',
      'label': "Purchase",
      'route': '/purchase',
    },
    {
      'iconPath': 'assets/svgs/counter_change.svg',
      'label': "Counter Change",
      'route': '/counterChange',
    },
    {
      'iconPath': 'assets/svgs/pos.svg',
      'label': "POS",
      'route': '/pos',
    },
    {
      'iconPath': 'assets/svgs/customer_feedback.svg',
      'label': "Customer Feedback",
      'route': '/customerFeedback',
    },
    {
      'iconPath': 'assets/svgs/gold_scheme.svg',
      'label': "Gold Scheme",
      'route': '/goldScheme',
    },
    {
      'iconPath': 'assets/svgs/estimate.svg',
      'label': "Estimate",
      'route': '/estimate',
    },
    {
      'iconPath': 'assets/svgs/orders.svg',
      'label': "Orders",
      'route': '/orders',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, item['route']);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.075,
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  // color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,

                  child: Center(
                    child:
                    SvgPicture.asset(
                      item['iconPath'],
                      width: MediaQuery.of(context).size.width * 0.0075,
                      height: MediaQuery.of(context).size.height * 0.09,
                    )

                    // SvgPicture.asset(
                    //   item['iconPath'],
                    //   width: 24,
                    //   height: 24,
                    //   colorFilter:
                    //   ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    // ),
                  ),
                ),
              ),
              SizedBox(height: 6),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Text(
                  item['label'].replaceFirst(' ', '\n'),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
