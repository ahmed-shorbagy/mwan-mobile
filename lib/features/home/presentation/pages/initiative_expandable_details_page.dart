import 'package:flutter/material.dart';

class InitiativeExpandableDetailsPage extends StatefulWidget {
  final Map<String, dynamic> initiative;

  const InitiativeExpandableDetailsPage({super.key, required this.initiative});

  @override
  State<InitiativeExpandableDetailsPage> createState() =>
      _InitiativeExpandableDetailsPageState();
}

class _InitiativeExpandableDetailsPageState
    extends State<InitiativeExpandableDetailsPage> {
  final Map<String, bool> _expandedState = {
    'بيانات المبادرة': true,
    'خطة التنفيذ': false,
    'المستهدفات': false,
    'التحديات - المخاطر - المعيقات': false,
  };

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            widget.initiative['title'] ?? 'المدخرات النقدية بالعملات الصعبة',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildExpandableSection(
                title: 'بيانات المبادرة',
                isInitiallyExpanded: true,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputField(
                      'اسم المبادرة',
                      widget.initiative['title'],
                    ),
                    _buildInputField(
                      'اسم التكليف المرتبط',
                      'اسم التكليف المرتبط يظهر هنا',
                    ),
                    const SizedBox(height: 16),
                    _buildDateRow(),
                    const SizedBox(height: 16),
                    _buildInputField(
                      'وصف المبادرة',
                      'اسم التكليف المرتبط يظهر هنا اسم التكليف المرتبط يظهر هنا اسم التكليف المرتبط يظهر هنا اسم التكليف المرتبط يظهر هنا',
                      maxLines: 4,
                    ),
                    _buildInputField('مسار المبادرة', 'اسم مسار المبادرة هنا'),
                    _buildInputField('الجهة المالكة', 'اسم الجهة المالكة هنا'),
                    _buildInputField(
                      'الاعتمادية',
                      'اسم التكليف المرتبط يظهر هنا اسم التكليف المرتبط يظهر هنا اسم التكليف المرتبط يظهر هنا',
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              _buildExpandableSection(
                title: 'خطة التنفيذ',
                content: Container(),
              ),
              const SizedBox(height: 8),
              _buildExpandableSection(
                title: 'المستهدفات',
                content: Container(),
              ),
              const SizedBox(height: 8),
              _buildExpandableSection(
                title: 'التحديات - المخاطر - المعيقات',
                content: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    String value, {
    int maxLines = 1,
    bool isDarkBg = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
            maxLines: maxLines,
          ),
        ),
      ],
    );
  }

  Widget _buildWeightField(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الوزن',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF4CAF50),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateRow() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'تاريخ البداية',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '02/12/2022',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'تاريخ النهاية',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '02/12/2026',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        _buildWeightField('10%'),
      ],
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required Widget content,
    bool isInitiallyExpanded = false,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        final isExpanded = _expandedState[title] ?? false;

        return Container(
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
              color: isExpanded ? Colors.green : const Color(0xFF4F4F4F),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Theme(
            data: ThemeData(dividerColor: Colors.transparent),
            child: ExpansionTile(
              initiallyExpanded: isInitiallyExpanded,
              onExpansionChanged: (expanded) {
                setState(() {
                  _expandedState[title] = expanded;
                });
              },
              title: Text(
                title,
                style: TextStyle(
                  color: Colors.green[400],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              collapsedIconColor: Colors.green[400],
              iconColor: Colors.green[400],
              backgroundColor: Colors.transparent,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: content,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
