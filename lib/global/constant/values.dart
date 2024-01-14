import 'package:front/data/data.dart';
import 'package:front/global/constant/constant.dart';

// const api = 'http://localhost:5000/api/';
// bishu mac
// const api = 'http://192.168.68.102:5000/api/';
// const url = 'http://192.168.68.102:5000';
// dorjoo
const api = 'http://192.168.1.2:5000/api/';
const url = 'http://192.168.1.2:5000';
// dorjiy dorjoohover
const user1 = "652227c1517423fded167b17";
const user1Tkn = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImRvcmpvb2hvdmVyQHVmZS5lZHUubW4iLCJpYXQiOjE3MDQ3ODI1OTAsImV4cCI6MTcwNTM4NzM5MH0.e9Ab3qc5KxZ_mjIQBMsuC2u3cWG4FjcTV8jhBKRv5bg";
//dorj b20fa1709
const user2 = "652227f0a08d7adcbfbf28ea";
const user2Tkn = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImIyMGZhMTcwOUB1ZmUuZWR1Lm1uIiwiaWF0IjoxNzA0NzgyNjIzLCJleHAiOjE3MDUzODc0MjN9.gm9T9KXG1bOtkUFsdSlv9JWQVzHUSKLz6CLitzAsSig";
// teacher ddorjoo
const teacherTkn = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImRkb3Jqb28yNjhAdWZlLmVkdS5tbiIsImlhdCI6MTcwNDc4MzAwMiwiZXhwIjoxNzA1Mzg3ODAyfQ.OARzFK1BqsRU7jZaoGO9NTvQ_4AQVlFJFFz9hky5J1s";
const teacher1 = "659cebb17ec673b2d3edd3b5";
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

List<Chat> groups = [
  Chat(
      name: "MGM",
      number: 331,
      users: [],
      groupNumber: 231,
      sId: '1'),
  Chat(
      name: "MKT",
      number: 221,
      users: [],
      groupNumber: 375,
      sId: '2'),
  Chat(
      name: "DBM",
      number: 221,
      users: [],
      groupNumber: 257,
      sId: '3'),
  Chat(
      name: "BET",
      number: 223,
      users: [],
      groupNumber: 278,
      sId: '4'),
  Chat(
      name: "LAW",
      number: 333,
      users: [],
      groupNumber: 299,
      sId: '5'),
  Chat(
      name: "LAW",
      number: 333,
      users: [],
      groupNumber: 299,
      sId: '6'),
  Chat(
      name: "LAW",
      number: 333,
      users: [],
      groupNumber: 299,
      sId: '7'),
];
List<User> users = [
  User(
    sId: '1',
    nickname: 'Эса',
  ),
  User(
    sId: '2',
    nickname: 'adsf',
  ),
  User(
    sId: '3',
    nickname: 'asdfasdf',
  ),
  User(
    sId: '4',
    nickname: 'adf',
  ),
  User(
    sId: '5',
    nickname: 'aadf',
  ),
  User(
    sId: '6',
    nickname: 'adsfds',
  ),
  User(
    sId: '7',
    nickname: 'Эса',
  ),
  User(
    sId: '7',
    nickname: 'Эса',
  ),
  User(
    sId: '7',
    nickname: 'Эса',
  ),
  User(
    sId: '7',
    nickname: 'Эса',
  ),
  User(
    sId: '7',
    nickname: 'Эса',
  ),
  User(
    sId: '7',
    nickname: 'Эса',
  ),
  User(
    sId: '7',
    nickname: 'Эса',
  ),
];

List<String> createStepTexts = [chooseGroup, chooseStudent];
List<Message> messages = [
  Message(
      messageType: MessageTypes.TEXT,
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      chat: '1',
      sender: User(nickname: 'Eca', sId: '1')),
  Message(
      messageType: MessageTypes.TEXT,
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      chat: '1',
      sender: User(nickname: 'Eca', sId: '1')),
  Message(
      messageType: MessageTypes.TEXT,
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      chat: '1',
      sender: User(nickname: 'Bishu', sId: '2')),
  Message(
      messageType: MessageTypes.TEXT,
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      chat: '1',
      sender: User(nickname: 'Dorj', sId: '3')),
];
