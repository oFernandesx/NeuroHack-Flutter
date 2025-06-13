import 'package:flutter/material.dart';

class NavButtonBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const NavButtonBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xB3BAD6E0), // Azul claro com opacidade (~70%)
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context: context, 
            index: 0,
            label: 'Tarefas',
            icon: Icons.check_circle_outline,
            selectedColor: const Color(0xFFFA7B5B), 
          ),
          _buildNavItem(
            context: context, 
            index: 1,
            label: 'Calendário',
            icon: Icons.calendar_today,
            selectedColor: const Color(0xFF213554), 
          ),
          _buildNavItem(
            context: context, 
            index: 2,
            label: 'Perfil',
            icon: Icons.person_outline,
            selectedColor: const Color(0xFF213554), 
          ),
        ],
      ),
    );
  }


  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required String label,
    required IconData icon,
    required Color selectedColor,
  }) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemTapped(index), 
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
            color: isSelected ? selectedColor : Colors.black87,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected ? selectedColor : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
