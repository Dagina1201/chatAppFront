import 'package:front/data/data.dart';
import 'package:front/global/constant/constant.dart';

// const api = 'http://localhost:5000/api/';
// bishu mac
// const api = 'http://192.168.68.102:5000/api/';
// const url = 'http://192.168.68.102:5000';
// dorjoo
const api = 'http://192.168.1.2:5000/api/';
const url = 'http://192.168.1.2:5000';


// {
//   "types": "LESSON",
//   "name": "dwm",
//   "number": 431,

//   "teacher": "65a8322ceb53acc4a45d1853"

// }

// {
//   "types": "GROUP",
// "chat": "65a83703cfd6999fe2e822a7",
// "groupNumber": 413


// }

const navBarValues = [
  {
    'icon': 'assets/icons/navigationBar/home.svg',
    'activeIcon': 'assets/icons/navigationBar/homeActive.svg',
    'label': 'Нүүр',
  },
  {
    'icon': 'assets/icons/navigationBar/emergency.svg',
    'activeIcon': 'assets/icons/navigationBar/emergencyActive.svg',
    'label': 'Яаралтай',
  },
  {
    'icon': 'assets/icons/navigationBar/notary.svg',
    'activeIcon': 'assets/icons/navigationBar/notaryActive.svg',
    'label': 'Захиалга',
  },
  {
    'icon': 'assets/icons/navigationBar/user.svg',
    'activeIcon': 'assets/icons/navigationBar/userActive.svg',
    'label': 'Профайл',
  },
];

List<Diagram> diagramValues = [
  Diagram(active: 0.1, name: 'mon', value: 0.5),
  Diagram(active: 0.2, name: 'tue', value: 0.78),
  Diagram(active: 0.0, name: 'wed', value: 0.9),
  Diagram(active: 0.9, name: 'thu', value: 0.9),
  Diagram(active: 1, name: 'fri', value: 1)
];
const chatFilters = [ChatTypes.ALL, ChatTypes.GROUP, ChatTypes.TEAM];


List<String> createStepTexts = [chooseGroup, chooseStudent];
