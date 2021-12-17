import 'package:app/pages/discount_page.dart';
import 'package:app/pages/restaurant_page.dart';
import 'package:app/pages/user_profile_page.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RestaurantPage()));
                      },
                      child: const Icon(Icons.restaurant_menu_outlined)),
                  const Text(
                    'Restaurants',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfilePage()));
                    },
                    child: const Icon(Icons.person_outline),
                  ),
                  const Text(
                    'Profile',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DiscountPage()));
                    },
                    child: const Icon(Icons.price_change_outlined),
                  ),
                  const Text(
                    'Discounts',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
