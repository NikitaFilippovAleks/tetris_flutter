part of 'blocks_selector.dart';

class BlockItem extends StatelessWidget {
  final Block blockData;
  final Size size;
  final bool isActive;
  final Function(Block) onTap;
  const BlockItem({
    super.key,
    required this.blockData,
    required this.size,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(blockData);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
              color: isActive ? Colors.purple[300]! : Colors.grey, width: 6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: BlockPainter(blockData, size),
      ),
    );
  }
}
