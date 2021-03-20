////////////////////////////////////////////////////////////////
//класс для места на парковке, выполняет обновление состояния //
//места, индикации и сервомоторов - логика каждого места      //
//коструктор отсутствует, для инициализации используется метод//
//begin(trigpin, echopin, redledpin, greenledpin, servopin)   //
//  trigpin, echopin - пины ультразвукого дальномера          //
//  redledpin, greenledpin - пины красного и зелёного         //
//    светодиодов соответственно                              //
//  servopin - пин для управления сервомотором                //
//up() - метод должен вызываться каждый цикл для обновления   //
//    места                                                   //
//zabr(IDforPark) - метод для бронирования места              //
//  IDforPark - строка индентификатора для бронирования       //
//Rz(IDforPark) - метод для разбронирования                   //
//  IDforPark - см zabr(IDforPark).                           //
////////////////////////////////////////////////////////////////

#include <Servo.h>

const String server = "192.168.43.71";
const String ssid = "Redmi";
const String pass = "123412381234";

class Mesto {
  public:
    uint8_t ismesto = 0; // состояние места
    uint8_t trig;        //пин для создания ультразвукого импульса
    uint8_t echo;        // пин для принятия ультразвукого импульса
    uint8_t led1;        // пин красного светодиода
    uint8_t led2;        // пин зелёного светодиода
    boolean state = false;   //состояние светодиода
    unsigned long timerT = 0;  //таймер бронирования
    String myid = "";          //ID бронирующего клиента
    int distance = 20;         //максимальная дистанция
    int last = 0;              //прошедший градус сервомотора
    Servo s;
    void begin(uint8_t _trig, uint8_t _echo, uint8_t _led1, uint8_t _led2, uint8_t _s) {// функция для инициализации места
      trig = _trig;
      echo = _echo;
      led1 = _led1;
      led2 = _led2;
      pinMode(trig, OUTPUT);
      pinMode(echo, INPUT);
      pinMode(led1, OUTPUT);
      pinMode(led2, OUTPUT);
      s.attach(_s);
      s.write(45);
    }
    void zabr(String now_id) { // функция для бронирование; аргумент - строка - ID брони
      if (myid.equals("")) {
        ismesto = 1;
        myid = now_id;
        timerT = millis();
      }
    }
    void Rz(String now_id) { // разфункция для бронирование; аргумент - строка - ID брони
      if (!myid.equals("")) {
        if (now_id.equals(myid)) {
          ismesto = 0;
          myid = "";
        }
      }
    }
    void up() { // функция для обновления места(есть ли машина, какой цвет индикации, поворот заслонки и  проверка выхода таймаута)
      int cm;
      digitalWrite(trig, LOW);
      delayMicroseconds(2);
      digitalWrite(trig, HIGH);
      delayMicroseconds(5);
      digitalWrite(trig, LOW);
      cm = pulseIn(echo, HIGH, distance * 2 * 34) / 34 / 2;
    if ((cm != 0) && (cm < distance-5)) {
        ismesto = 2;
      } else if (ismesto != 1) {
        ismesto = 0;
      }
      switch (ismesto) {
        case 2:
          state = false;
          if (last != 45) {
            s.write(45);
            last = 45;
          }
          break;
        case 1:
          digitalWrite(led1, HIGH);
          digitalWrite(led2, HIGH);
          if (last != 135) {
            s.write(135);
            last = 135;
          }
          if (millis() - timerT > 15 * 1000) {
            ismesto = 0;
            myid = "";
          }
          Serial.println("in zabr");
          break;
        case 0:
          state = true;
          ismesto = 0;
          myid = "";
          if (last != 45) {
            s.write(45);
            last = 45;
          }
          break;
        default:
          break;
      }
      if (ismesto != 1) {
        digitalWrite(led1, !state);
        digitalWrite(led2, state);
      }
    }
};

//массив мест
Mesto ms[6];
//масив пинов для каждого места
uint8_t pins[6][5] = {
  {A0, A1, 42, 44, 5},
  {A0, A3, 22, 24, 6},
  {A0, A5, 40, 36, 7},
  {A0, A2, 28, 26, 8},
  {A0, A4, 30, 32, 9},
  {A0, A6, 34, 38, 10}
};

//загрузка библиотек для сервы и протокола ttl на кастомных пинах
#include <SoftwareSerial.h>
//объект SoftwareSerial для общения с esp8266
SoftwareSerial esp(A8, A9);

//"таймеры" для проверки соединения и для обновления мест соответственно
unsigned long t = 0;
unsigned long t1 = 0;
//массив символов для хранения состояния всех мест
char parkstate[] = "000100";


////////////////////////////////////////////////////////////////
//////////////////////////////SETUP/////////////////////////////
////////////////////////////////////////////////////////////////

void setup() {
  //инициализация парковочных мест
  for (int i = 0; i < 6; i++) {
    ms[i].begin(pins[i][0], pins[i][1], pins[i][2], pins[i][3], pins[i][4]);
  }
  //инициализация Serial на скорости 9600 с esp
  esp.begin(9600);
  while (!esp);
  //соединение с сервером
  delay(5000);
//  reconnect();
  //это тестовая сторока
  ms[0].ismesto = 1;
  //Serial для отладки
  Serial.begin(9600);

//  delay(5000);
  //очищаем буфер esp
  esp.flush();
  //обновляем таймер
}

////////////////////////////////////////////////////////////////
//////////////////////////////LOOP//////////////////////////////
////////////////////////////////////////////////////////////////

void loop() {
//если прошла минута проверяем соединение
      if (millis() - t > 1000) {
        Serial.println("reconnect");
        esp.flush();
        esp.print("?????\r\n");
        String tmp = "";
        t = millis();
        while (true) {
          if (esp.available() > 0) {
            tmp += String(char(esp.read()));
          }
          if (tmp.indexOf("!") > -1) {
            break;
          }
          if (millis() - t > 5000) {
            reconnect();
            break;
          }
        }
        t = millis();
      }
  //если прошла секунда обновляем места и отправляем состояние на сервер
  if (millis() - t1 > 500) {
    for (int i = 0; i < 6; i++) {
      ms[i].up();
      parkstate[i] = char(ms[i].ismesto + 48);
      delay(75);
    }
    esp.print("!getpark!" + String(parkstate) + "\n");
    t1 = millis();
  }
  //m.ismesto set or get of 0 - свободно, 1 - забронировванио, 2 - занято

//если есть данные то считываем до '\n' и проверяем на команда, если так то выполняем
  if (esp.available() > 0) {
    String msg = esp.readStringUntil('\n');
    Serial.println(msg);
    if (msg.lastIndexOf("sp") > -1) {
      int i = msg.substring(6, 7).toInt();
      String IDf = msg.substring(7, msg.length());
      ms[i - 1].zabr(IDf);
    } else if (msg.lastIndexOf("it") > -1) {
      int i = msg.substring(6, 7).toInt();
      String IDf = msg.substring(7, msg.length());
      ms[i - 1].Rz(IDf);
    }
  }
}

//////////////////////////////////////
//function for connect to server     /
//ROSTELEKOM - ssid for wifi         /
//lenovozuk123 - password for wifi   /
//192.168.1.3 - ip server            /
//48999 - port for server            /
//ID1: -1 - id for init in server    /
//////////////////////////////////////
void reconnect() {
  Serial.println("stops");
  esp.print("\r\n+++\r\n");
  delay(500);
  Serial.println("test");
  if (!sendcmd("AT", "OK", 250))return;
  //  if (!sendcmd("AT+CWMODE=1", "OK", 250))return;
  Serial.println("wifi connect");
  if (!sendcmd("AT+CWJAP=\""+ssid+"\",\""+pass+"\"", "OK", 1000))return;
  //if (!sendcmd("AT+CIPSTART=\"TCP\",\"192.168.1.3\",48999", "OK", 5000))return; //94.180.117.139
  Serial.println("connect");
  esp.print("AT+CIPSTART=\"TCP\",\""+server+"\",48999\r\n");
  delay(1000);
  Serial.println("set mode to tcp");
  if (!sendcmd("AT+CIPMODE=1", "OK", 250))return;
  esp.print("AT+CIPSEND\r\n");
  delay(1000);
  esp.print("SYSSC: HELLO\nID1: -1\n");
}
//////////////////////////////////////
//function for send command to esp////
//ARGUMENTS(cmd, ans, timeout):      /
//cmd - String - command (example:AT)/
//ans - String - true answer         /
//      to command (example:OK)      /
//timeout - int - timeout            /
//      for wait answer              /
//                                   /
//return true:                       /
//  if esp return answer in timeout  /
//return false:                      /
//  if esp not return answer         /
//  in timeout                       /
//////////////////////////////////////
boolean sendcmd(String cmd, String ans, int timout) {
  String tmp = "";
  unsigned long t = millis();
  int count = 0;
  esp.print(cmd + "\r\n");
  while (tmp.indexOf(ans) < 0) {
    if (esp.available() > 0) {
      tmp += (char)esp.read();
    }
    if (millis() - t > timout) {
      esp.print(cmd + "\r\n");
      count++;
      if (count == 15) {
        return false;
      }
      t = millis();
    }
  }
  return true;
}
