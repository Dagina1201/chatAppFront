import 'package:front/data/data.dart';
import 'package:front/global/constant/constant.dart';

// const api = 'http://localhost:5000/api/';
// bishu mac
// const api = 'http://192.168.68.102:5000/api/';
// const url = 'http://192.168.68.102:5000';
// dorjoo
// const api = 'http://192.168.1.2:5000/api/';
// const url = 'http://192.168.1.2:5000';
// vps gerelt tsokh
const api = 'http://139.162.40.225:5050/api/';
const url = 'http://139.162.40.225:5050';

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

List<Diagram> diagramValues = [
  Diagram(active: 0.1, name: 'mon', value: 0.5),
  Diagram(active: 0.2, name: 'tue', value: 0.78),
  Diagram(active: 0.0, name: 'wed', value: 0.9),
  Diagram(active: 0.9, name: 'thu', value: 0.9),
  Diagram(active: 1, name: 'fri', value: 1)
];
const chatFilters = [ChatTypes.ALL, ChatTypes.GROUP, ChatTypes.TEAM];

List<String> createStepTexts = [chooseGroup, chooseStudent];
