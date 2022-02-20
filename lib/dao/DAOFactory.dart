import 'package:weather_application/dao/DAO.dart';

class DAOFactory {
  WeatherDAO _weatherDAO = new WeatherDAO();

  DAOFactory._() {

  }

  WeatherDAO getInstance() {return _weatherDAO; }

}