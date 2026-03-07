// lib/data/content_data.dart
import '../models/content_models.dart';

final List<Topic> topics = [
  Topic(
    id: 'greetings_basics',
    title: 'Greetings & Basics',
    icon: '👋',
    type: TopicType.greetings,
    phrases: [
      Phrase(
        english: 'Hello (Universal)',
        bengali: 'Assalamu Alaikum',
        bengaliScript: 'আসসালামু আলাইকুম',
        literal: 'Peace be upon you',
        culturalNote: 'Used by Muslims and widely accepted as a polite greeting in Bangladesh.',
      ),
      Phrase(
        english: 'How are you?',
        bengali: 'Kemon achen?',
        bengaliScript: 'কেমন আছেন?',
        isFormal: true,
        culturalNote: 'Formal/Polite form. Use with elders or strangers.',
      ),
      Phrase(
        english: 'How are you? (Friends)',
        bengali: 'Kemon acho?',
        bengaliScript: 'কেমন আছো?',
        isFormal: false,
        culturalNote: 'Informal form. Use with friends and younger people.',
      ),
      Phrase(
        english: 'I am fine',
        bengali: 'Bhalo achi',
        bengaliScript: 'ভালো আছি',
      ),
      Phrase(
        english: 'Thank you',
        bengali: 'Dhonnobad',
        bengaliScript: 'ধন্যবাদ',
      ),
      Phrase(
        english: 'Yes',
        bengali: 'Ji / Hain',
        bengaliScript: 'জি / হ্যাঁ',
        culturalNote: '"Ji" is more polite/formal. "Hain" is casual.',
      ),
      Phrase(
        english: 'No',
        bengali: 'Na',
        bengaliScript: 'না',
      ),
    ],
  ),
  Topic(
    id: 'introductions',
    title: 'Introductions',
    icon: '🤝',
    type: TopicType.introductions,
    phrases: [
      Phrase(
        english: 'My name is...',
        bengali: 'Amar naam...',
        bengaliScript: 'আমার নাম...',
      ),
      Phrase(
        english: 'What is your name?',
        bengali: 'Apnar naam ki?',
        bengaliScript: 'আপনার নাম কি?',
        isFormal: true,
      ),
      Phrase(
        english: 'I am from (Country/City)',
        bengali: 'Aami (Country/City) theke eshechi',
        bengaliScript: 'আমি (Country/City) থেকে এসেছি',
      ),
      Phrase(
        english: 'Nice to meet you',
        bengali: 'Apnar shathe porichoy hoye bhalo laglo',
        bengaliScript: 'আপনার সাথে পরিচয় হয়ে ভালো লাগলো',
      ),
    ],
  ),
  Topic(
    id: 'shopping_numbers',
    title: 'Shopping & Numbers',
    icon: '🛍️',
    type: TopicType.shopping,
    phrases: [
      Phrase(
        english: 'How much is this?',
        bengali: 'Etar daam koto?',
        bengaliScript: 'এটার দাম কত?',
      ),
      Phrase(
        english: 'Too expensive',
        bengali: 'Onek daam',
        bengaliScript: 'অনেক দাম',
      ),
      Phrase(
        english: 'Give me a lower price',
        bengali: 'Komati hobe / Kom rakhen',
        bengaliScript: 'কমাতে হবে / কম রাখেন',
        culturalNote: 'Bargaining is common in local markets.',
      ),
      Phrase(
        english: '1',
        bengali: 'Ek',
        bengaliScript: 'এক',
      ),
      Phrase(
        english: '2',
        bengali: 'Dui',
        bengaliScript: 'দুই',
      ),
      Phrase(
        english: '3',
        bengali: 'Tin',
        bengaliScript: 'তিন',
      ),
      Phrase(
        english: '4',
        bengali: 'Char',
        bengaliScript: 'চার',
      ),
      Phrase(
        english: '5',
        bengali: 'Paach',
        bengaliScript: 'পাঁচ',
      ),
      Phrase(
        english: '10',
        bengali: 'Dosh',
        bengaliScript: 'দশ',
      ),
       Phrase(
        english: '100',
        bengali: 'Ek-sho',
        bengaliScript: 'একশ',
      ),
    ],
  ),
  Topic(
    id: 'food_dining',
    title: 'Food & Dining',
    icon: '🍚',
    type: TopicType.food,
    phrases: [
      Phrase(
        english: 'I am hungry',
        bengali: 'Amar khudha lagse',
        bengaliScript: 'আমার ক্ষুধা লাগছে',
        culturalNote: 'Informal/Dhaka style.',
      ),
      Phrase(
        english: 'Water please',
        bengali: 'Pani den',
        bengaliScript: 'পানি দেন',
      ),
      Phrase(
        english: 'Rice',
        bengali: 'Bhaat',
        bengaliScript: 'ভাত',
      ),
      Phrase(
        english: 'Fish',
        bengali: 'Maach',
        bengaliScript: 'মাছ',
      ),
      Phrase(
        english: 'Chicken',
        bengali: 'Murgi',
        bengaliScript: 'মুরগি',
      ),
      Phrase(
        english: 'Spicy',
        bengali: 'Jhaal',
        bengaliScript: 'ঝাল',
      ),
      Phrase(
        english: 'Give me the bill',
        bengali: 'Bill ta den',
        bengaliScript: 'বিলটা দেন',
      ),
    ],
  ),
   Topic(
    id: 'directions',
    title: 'Directions',
    icon: '🗺️',
    type: TopicType.directions,
    phrases: [
      Phrase(
        english: 'Where is...?',
        bengali: '...kothay?',
        bengaliScript: '...কোথায়?',
      ),
      Phrase(
        english: 'Go straight',
        bengali: 'Shoja jan',
        bengaliScript: 'সোজা যান',
      ),
      Phrase(
        english: 'Turn left',
        bengali: 'Baame jan',
        bengaliScript: 'বামে যান',
      ),
      Phrase(
        english: 'Turn right',
        bengali: 'Daane jan',
        bengaliScript: 'ডানে যান',
      ),
      Phrase(
        english: 'Stop here',
        bengali: 'Eikhane thaman',
        bengaliScript: 'এইখানে থামান',
      ),
    ],
  ),
  Topic(
    id: 'family_elders',
    title: 'Family & Elders',
    icon: '👵',
    type: TopicType.family,
    phrases: [
      Phrase(
        english: 'Mother',
        bengali: 'Ma / Amma',
        bengaliScript: 'মা / আম্মা',
      ),
      Phrase(
        english: 'Father',
        bengali: 'Baba / Abba',
        bengaliScript: 'বাবা / আব্বা',
      ),
       Phrase(
        english: 'Sister (Older)',
        bengali: 'Apu / Bubu',
        bengaliScript: 'আপু / বুবু',
        culturalNote: 'Respectful term for older sister or female acquaintance.',
      ),
      Phrase(
        english: 'Brother (Older)',
        bengali: 'Bhaiya / Bhai',
        bengaliScript: 'ভাইয়া / ভাই',
      ),
      Phrase(
        english: 'Greeting elders (Hindu)',
        bengali: 'Nomoshkar',
        bengaliScript: 'নমস্কার',
        culturalNote: 'Specific greeting for Hindu elders.',
      ),
       Phrase(
        english: 'Greeting elders (Muslim)',
        bengali: 'Salam',
        bengaliScript: 'সালাম',
        culturalNote: 'Short for Assalamu Alaikum.',
      ),
    ],
  ),
];

// Scenarios for Roleplay Mode

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
          vocabulary: ['Ei je = Hey/Excuse me', 'Kemon = How', 'Acho = Are (Informal)'],
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
          vocabulary: ['Mama = Maternal Uncle (Bro/Friend)', 'Ki = What', 'Lagbe = Need'],
          culturalNote: '"Mama" is a very common informal address for strangers in Dhaka.',
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
           vocabulary: ['Etto = So much', 'Daam = Price', 'Hobe = Will happen/work?'],
           culturalNote: 'It is expected to ask for a lower price in open markets.',
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
