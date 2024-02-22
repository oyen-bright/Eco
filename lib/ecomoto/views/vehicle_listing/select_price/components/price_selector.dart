part of "../select_price_view.dart";

class PriceSelector extends StatefulWidget {
  final int initialPrice;
  final ValueChanged<int> onChanged;

  const PriceSelector({
    Key? key,
    required this.initialPrice,
    required this.onChanged,
  }) : super(key: key);

  @override
  PriceSelectorState createState() => PriceSelectorState();
}

class PriceSelectorState extends State<PriceSelector> {
  late int _price;

  @override
  void initState() {
    super.initState();
    _price = widget.initialPrice;
  }

  void _decrementQuantity() {
    setState(() {
      _price -= 1;
      widget.onChanged(_price);
    });
  }

  void _incrementQuantity() {
    setState(() {
      _price += 1;
      widget.onChanged(_price);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          style: IconButton.styleFrom(
            enableFeedback: true,
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          icon: const Icon(
            Icons.remove_circle,
            size: 28,
          ),
          onPressed: _decrementQuantity,
        ),
        Text(
          '${AppConstants.appCurrency}$_price',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.lightPurple,
          ),
        ),
        IconButton(
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            enableFeedback: true,
            visualDensity: VisualDensity.compact,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          icon: const Icon(
            Icons.add_circle_outlined,
            size: 28,
          ),
          onPressed: _incrementQuantity,
        ),
      ],
    );
  }
}
