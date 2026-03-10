import '../models/content_models.dart';

final List<Scenario> scenarios = [
  Scenario(
    id: 'greeting_friend',
    title: 'Greeting a Friend',
    description: 'Casual conversation with a friend you meet on the street.',
    difficulty: Difficulty.beginner,
    steps: [
      DialogueStep(
        stepId: 'step1',
        speakerName: 'Friend',
        textBengali: 'Ei je! Kemon acho?',
        textScript: 'এই যে! কেমন আছো?',
        textEnglish: 'Hey there! How are you?',
        options: [
          ResponseOption(
            textBengali: 'Bhalo achi. Tumi kemon?',
            textScript: 'ভালো আছি। তুমি কেমন?',
            textEnglish: 'I am good. How are you?',
            nextStepId: 'step2_good',
          ),
          ResponseOption(
            textBengali: 'Beshi bhalo na.',
            textScript: 'বেশি ভালো না।',
            textEnglish: 'Not very good.',
            nextStepId: 'step2_bad',
          ),
        ],
        hint: Hint(
          vocabulary: [
            'Ei je = Hey/Excuse me',
            'Kemon = How',
            'Acho = Are (Informal)',
          ],
          culturalNote: 'Standard informal greeting among friends.',
        ),
      ),
      DialogueStep(
        stepId: 'step2_good',
        speakerName: 'Friend',
        textBengali: 'Ami-o bhalo. Kothay jaccho?',
        textScript: 'আমিও ভালো। কোথায় যাচ্ছো?',
        textEnglish: 'I am also good. Where are you going?',
        options: [
          ResponseOption(
            textBengali: 'Bazare jacchi.',
            textScript: 'বাজারে যাচ্ছি।',
            textEnglish: 'Going to the market.',
            nextStepId: 'end',
          ),
          ResponseOption(
            textBengali: 'Bashay jacchi.',
            textScript: 'বাসায় যাচ্ছি।',
            textEnglish: 'Going home.',
            nextStepId: 'end',
          ),
        ],
        hint: Hint(
          vocabulary: ['Ami-o = I also', 'Kothay = Where', 'Jaccho = Going'],
        ),
      ),
      DialogueStep(
        stepId: 'step2_bad',
        speakerName: 'Friend',
        textBengali: 'Ken? Ki hoyeche?',
        textScript: 'কেন? কি হয়েছে?',
        textEnglish: 'Why? What happened?',
        options: [
          ResponseOption(
            textBengali: 'Shorir kharap.',
            textScript: 'শরীর খারাপ।',
            textEnglish: 'I feel sick (Body is bad).',
            nextStepId: 'end',
          ),
        ],
        hint: Hint(
          vocabulary: ['Ken = Why', 'Ki = What', 'Hoyeche = Happened'],
        ),
      ),
      DialogueStep(
        stepId: 'end',
        speakerName: 'Friend',
        textBengali: 'Accha, pore kotha hobe. Allah Hafez.',
        textScript: 'আচ্ছা, পরে কথা হবে। আল্লাহ হাফেজ।',
        textEnglish: 'Okay, talk later. Goodbye.',
        options: [
          ResponseOption(
            textBengali: 'Allah Hafez.',
            textScript: 'আল্লাহ হাফেজ।',
            textEnglish: 'Goodbye.',
            nextStepId: 'COMPLETE',
          ),
        ],
      ),
    ],
  ),
  Scenario(
    id: 'market_haggling',
    title: 'Haggling at the Market',
    description: 'Buying vegetables and negotiating the price.',
    difficulty: Difficulty.intermediate,
    steps: [
      DialogueStep(
        stepId: 'step1',
        speakerName: 'Shopkeeper',
        textBengali: 'Mama, ki lagbe? Aashun.',
        textScript: 'মামা, কি লাগবে? আসেন।',
        textEnglish: 'Brother, what do you need? Come.',
        options: [
          ResponseOption(
            textBengali: 'Alu koto kore?',
            textScript: 'আলু কত করে?',
            textEnglish: 'How much for potatoes?',
            nextStepId: 'step2',
          ),
        ],
        hint: Hint(
          vocabulary: [
            'Mama = Maternal Uncle (Bro/Friend)',
            'Ki = What',
            'Lagbe = Need',
          ],
          culturalNote:
              '"Mama" is a very common informal address for strangers in Dhaka.',
        ),
      ),
      DialogueStep(
        stepId: 'step2',
        speakerName: 'Shopkeeper',
        textBengali: '40 taka keji. Ekdom fresh.',
        textScript: '৪০ টাকা কেজি। একদম ফ্রেশ।',
        textEnglish: '40 Taka per kg. Absolutely fresh.',
        options: [
          ResponseOption(
            textBengali: 'Etto daam? 30 takay hobe?',
            textScript: 'এত দাম? ৩০ টাকায় হবে?',
            textEnglish: 'So expensive? Will 30 work?',
            nextStepId: 'step3_haggle',
          ),
          ResponseOption(
            textBengali: 'Thik ache, 2 keji den.',
            textScript: 'ঠিক আছে, ২ কেজি দেন।',
            textEnglish: 'Okay, give me 2 kg.',
            nextStepId: 'end_buy',
          ),
        ],
        hint: Hint(
          vocabulary: [
            'Etto = So much',
            'Daam = Price',
            'Hobe = Will happen/work?',
          ],
          culturalNote:
              'It is expected to ask for a lower price in open markets.',
        ),
      ),
      DialogueStep(
        stepId: 'step3_haggle',
        speakerName: 'Shopkeeper',
        textBengali: 'Na mama, 35 er niche hobe na.',
        textScript: 'না মামা, ৩৫ এর নিচে হবে না।',
        textEnglish: 'No brother, can\'t go below 35.',
        options: [
          ResponseOption(
            textBengali: 'Accha den.',
            textScript: 'আচ্ছা দেন।',
            textEnglish: 'Okay give it.',
            nextStepId: 'end_buy',
          ),
          ResponseOption(
            textBengali: 'Na, tahole lagbe na.',
            textScript: 'না, তাহলে লাগবে না।',
            textEnglish: 'No, then I don\'t need it.',
            nextStepId: 'end_leave',
          ),
        ],
      ),
      DialogueStep(
        stepId: 'end_buy',
        speakerName: 'Shopkeeper',
        textBengali: 'Ei nen mama. Dhonnobad.',
        textScript: 'এই নেন মামা। ধন্যবাদ।',
        textEnglish: 'Here you go brother. Thank you.',
        options: [
          ResponseOption(
            textBengali: 'Dhonnobad.',
            textScript: 'ধন্যবাদ।',
            textEnglish: 'Thank you.',
            nextStepId: 'COMPLETE',
          ),
        ],
      ),
      DialogueStep(
        stepId: 'end_leave',
        speakerName: 'Shopkeeper',
        textBengali: 'Accha, 32 taka den! Niye jan.',
        textScript: 'আচ্ছা, ৩২ টাকা দেন! নিয়ে যান।',
        textEnglish: 'Okay, give 32 Taka! Take it.',
        options: [
          ResponseOption(
            textBengali: 'Thik ache, den.',
            textScript: 'ঠিক আছে, দেন।',
            textEnglish: 'Okay, give it.',
            nextStepId: 'COMPLETE',
          ),
        ],
        hint: Hint(
          vocabulary: [],
          culturalNote: 'Walking away is a powerful negotiation tactic!',
        ),
      ),
    ],
  ),
];
