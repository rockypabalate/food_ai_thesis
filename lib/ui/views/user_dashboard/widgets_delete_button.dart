import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteButton({
    Key? key,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5,
      right: 6,
      child: Container(
        width: 28, // Set a smaller width
        height: 28, // Set a smaller height
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white, // Changed to solid white background
          border: Border.all(
            color: const Color.fromARGB(255, 146, 146, 146).withOpacity(0.7),
            width: 0.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(0),
        child: PopupMenuButton<String>(
          icon: const Icon(
            Icons.more_vert,
            color: Colors.black,
            size: 20.0,
          ),
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: 'delete',
                height: 40,
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete'),
                  ],
                ),
              ),
            ];
          },
          onSelected: (String value) {
            if (value == 'delete') {
              onDelete();
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}
