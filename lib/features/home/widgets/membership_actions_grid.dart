import 'package:evo/features/home/widgets/membership_action_card.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:flutter/material.dart';

class MembershipActionsGrid extends StatelessWidget {
  const MembershipActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: context.t.homeScreen.explore,
            press: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: demoProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 20,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              return MembershipActionCard(
                product: demoProducts[index],
                onPress: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    required this.press,
  });

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: press,
          style: TextButton.styleFrom(foregroundColor: Colors.grey),
          child: const Text('See more'),
        ),
      ],
    );
  }
}

List<Product> demoProducts = [
  Product(
    id: 1,
    images: ['https://i.postimg.cc/c19zpJ6f/Image-Popular-Product-1.png'],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: 'Wireless Controller for PS4™',
    price: 64.99,
    description: 'Some description',
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 2,
    images: [
      'https://i.postimg.cc/CxD6nH74/Image-Popular-Product-2.png',
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: 'Nike Sport White - Man Pant',
    price: 50.5,
    description: 'Some description',
    rating: 4.1,
    isPopular: true,
  ),
  Product(
    id: 3,
    images: [
      'https://i.postimg.cc/1XjYwvbv/glap.png',
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: 'Gloves XC Omega - Polygon',
    price: 36.55,
    description: 'Some description',
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 4,
    images: [
      'https://i.postimg.cc/d1QWXMYW/Image-Popular-Product-3.png',
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    title: 'Gloves XC Omega - Polygon',
    price: 36.55,
    description: 'Some description',
    rating: 4.1,
    isFavourite: false,
    isPopular: true,
  ),
];
