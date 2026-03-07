import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/content_models.dart';
import '../providers/app_provider.dart';
import '../widgets/audio_button.dart';

class RoleplayScreen extends StatefulWidget {
  final Scenario scenario;

  const RoleplayScreen({Key? key, required this.scenario}) : super(key: key);

  @override
  _RoleplayScreenState createState() => _RoleplayScreenState();
}

class _RoleplayScreenState extends State<RoleplayScreen> {
  late DialogueStep currentStep;
  // Mix of DialogueStep (Tutor) and ResponseOption (User)
  final List<dynamic> history = []; 

  @override
  void initState() {
    super.initState();
    currentStep = widget.scenario.steps.first;
  }

  void _advanceScenario(ResponseOption selectedOption) {
    setState(() {
      history.add(currentStep); // Add Tutor's previous question
      history.add(selectedOption); // Add User's answer
    });

    if (selectedOption.nextStepId == 'COMPLETE') {
      _showCompletionDialog();
      return;
    }
    
    // Find next step
    final nextStep = widget.scenario.steps.firstWhere(
      (step) => step.stepId == selectedOption.nextStepId,
      orElse: () => widget.scenario.steps.first, 
    );

    setState(() {
      currentStep = nextStep;
    });
  }

  void _showCompletionDialog() {
    // Mark scenario as complete
    Provider.of<AppProvider>(context, listen: false).completeScenario(widget.scenario.id);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Scenario Complete!'),
        content: const Text('You successfully finished the conversation.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back
            },
            child: const Text('Finish'),
          ),
        ],
      ),
    );
  }

  void _showHint(Hint hint) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hints', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            if (hint.vocabulary.isNotEmpty) ...[
              const Text('Vocabulary:', style: TextStyle(fontWeight: FontWeight.bold)),
              ...hint.vocabulary.map((v) => Text('• $v')),
              const SizedBox(height: 8),
            ],
            if (hint.literalTranslation != null) ...[
              const Text('Literal Translation:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(hint.literalTranslation!),
              const SizedBox(height: 8),
            ],
            if (hint.culturalNote != null) ...[
              const Text('Cultural Note:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(hint.culturalNote!),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.scenario.title)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: history.length + 1,
              itemBuilder: (context, index) {
                if (index == history.length) {
                  return _buildTutorBubble(currentStep, isCurrent: true);
                }
                
                final item = history[index];
                if (item is DialogueStep) {
                  return _buildTutorBubble(item, isCurrent: false);
                } else if (item is ResponseOption) {
                  return _buildUserBubble(item);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          _buildResponseArea(),
        ],
      ),
    );
  }

  Widget _buildTutorBubble(DialogueStep step, {required bool isCurrent}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isCurrent ? Colors.blue[50] : Colors.grey[200],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
            bottomLeft: Radius.zero,
          ),
          border: isCurrent ? Border.all(color: Colors.blue.shade200) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(step.speakerName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blue[800])),
            const SizedBox(height: 4),
            Text(step.textBengali, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Text(step.textEnglish, style: TextStyle(fontSize: 14, color: Colors.grey[600], fontStyle: FontStyle.italic)),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AudioButton(textToSpeak: step.textScript, color: Colors.blue),
                if (step.hint != null)
                  IconButton(
                    icon: const Icon(Icons.lightbulb_outline, color: Colors.orange),
                    onPressed: () => _showHint(step.hint!),
                    tooltip: 'Show Hint',
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserBubble(ResponseOption option) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: Colors.teal[100],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.zero,
            bottomLeft: Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('You', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.teal)),
            const SizedBox(height: 4),
            Text(option.textBengali, style: const TextStyle(fontSize: 16), textAlign: TextAlign.right),
            const SizedBox(height: 4),
            Text(option.textEnglish, style: TextStyle(fontSize: 14, color: Colors.grey[700], fontStyle: FontStyle.italic), textAlign: TextAlign.right),
          ],
        ),
      ),
    );
  }

  Widget _buildResponseArea() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, -2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Choose your reply:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 8),
          ...currentStep.options.map((option) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                alignment: Alignment.centerLeft,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () => _advanceScenario(option),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(option.textBengali, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(option.textEnglish, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                  AudioButton(textToSpeak: option.textScript, color: Colors.grey),
                ],
              ),
            ),
          )).toList(),
        ],
      ),
    );
  }
}
