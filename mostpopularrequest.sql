-- A. У 2021 році для кожної країни та місяця проаналізувати частку номерів, які зарезервовані, вільні та недоступні.
SELECT
  Countries.name AS country_name,
  EXTRACT(MONTH FROM Reservations.check_in) AS month,
  COUNT(CASE WHEN Rooms.status = 'reserved' THEN 1 END) * 100.0 / COUNT(*) AS reserved_percent,
  COUNT(CASE WHEN Rooms.status = 'free' THEN 1 END) * 100.0 / COUNT(*) AS free_percent,
  COUNT(CASE WHEN Rooms.status = 'unavailable' THEN 1 END) * 100.0 / COUNT(*) AS unavailable_percent
FROM Reservations
JOIN Rooms ON Reservations.room_id = Rooms.id
JOIN Hotels ON Rooms.hotel_id = Hotels.id
JOIN Cities ON Hotels.city_id = Cities.id
JOIN Countries ON Cities.country_id = Countries.id
WHERE EXTRACT(YEAR FROM Reservations.check_in) = 2021
GROUP BY Countries.name, EXTRACT(MONTH FROM Reservations.check_in)
ORDER BY Countries.name, EXTRACT(MONTH FROM Reservations.check_in);

-- B. У 2021 році для кожної країни проаналізувати частину номерів, які зарезервовані. Привʼязати до кожної країни рейтинг відповідно до частки зарезервованих кімнат для цієї країни у 2021 році відносно всіх кімнат в цій країні. Країна із найвищим відсотком зарезервованих номерів у 2021 році повинна мати рейтинг 1.
WITH CountryReservationPercentages AS (
  SELECT
    Countries.name AS country_name,
    COUNT(CASE WHEN Rooms.status = 'reserved' THEN 1 END) * 100.0 / COUNT(*) AS reserved_percent
  FROM Rooms
  JOIN Hotels ON Rooms.hotel_id = Hotels.id
  JOIN Cities ON Hotels.city_id = Cities.id
  JOIN Countries ON Cities.country_id = Countries.id
  JOIN Reservations ON Rooms.id = Reservations.room_id
  WHERE EXTRACT(YEAR FROM Reservations.check_in) = 2021
  GROUP BY Countries.name
),
CountryRanks AS (
  SELECT
    country_name,
    RANK() OVER (ORDER BY reserved_percent DESC) AS rank
  FROM CountryReservationPercentages
)
SELECT
  Countries.name AS country_name,
  CountryRanks.rank AS reservation_rank
FROM CountryRanks
JOIN Countries ON CountryRanks.country_name = Countries.name;

-- C. У 2021 році для кожної країни та місяця проаналізувати дохід 4-зіркових готелів і сукупний дохід 4-зіркових готелів.
SELECT
  Countries.name AS country_name,
  EXTRACT(MONTH FROM Revenue.date) AS month,
  SUM(CASE WHEN Hotels.category = 4 THEN Revenue.revenue END) AS four_star_revenue,
  SUM(Revenue.revenue) AS total_revenue
FROM Revenue
JOIN Rooms ON Revenue.room_feature_id = Rooms.feature_id AND Revenue.hotel_id = Rooms.hotel_id
JOIN Hotels ON Rooms.hotel_id = Hotels.id
JOIN Cities ON Hotels.city_id = Cities.id
JOIN Countries ON Cities.country_id = Countries.id
WHERE EXTRACT(YEAR FROM Revenue.date) = 2021
GROUP BY Countries.name, EXTRACT(MONTH FROM Revenue.date)
ORDER BY Countries.name, EXTRACT(MONTH FROM Revenue.date);
-- D. Для кожної країни та року проаналізувати загальний дохід від державних свят.
SELECT
  Countries.name AS country_name,
  EXTRACT(YEAR FROM Reservations.check_in) AS year,
  SUM(Revenue.revenue) AS total_revenue
FROM Reservations
JOIN Rooms ON Reservations.room_id = Rooms.id
JOIN Hotels ON Rooms.hotel_id = Hotels.id
JOIN Cities ON Hotels.city_id = Cities.id
JOIN Countries ON Cities.country_id = Countries.id
JOIN Revenue ON Rooms.feature_id = Revenue.room_feature_id AND Hotels.id = Revenue.hotel_id AND Reservations.check_in = Revenue.date
WHERE Revenue.room_feature_id = 1  -- Assume feature_id 1 corresponds to government holiday rooms
GROUP BY Countries.name, EXTRACT(YEAR FROM Reservations.check_in)
ORDER BY Countries.name, EXTRACT(YEAR FROM Reservations.check_in);
-- E. У 2021 році для кожного готелю проаналізувати загальний дохід від номерів із супутниковим телебаченням та джакузі.
SELECT
Hotels.name AS hotel_name,
SUM(CASE WHEN RoomFeatures.name = 'Satellite TV' THEN Revenue.revenue ELSE 0 END) AS satellite_tv_revenue,
SUM(CASE WHEN RoomFeatures.name = 'Jacuzzi' THEN Revenue.revenue ELSE 0 END) AS jacuzzi_revenue,
SUM(Revenue.revenue) AS total_revenue
FROM Hotels
JOIN Rooms ON Rooms.hotel_id = Hotels.id
JOIN RoomFeatures ON RoomFeatures.id = Rooms.feature_id
JOIN Revenue ON Revenue.hotel_id = Hotels.id AND Revenue.room_feature_id = RoomFeatures.id
WHERE EXTRACT(YEAR FROM Revenue.date) = 2021
GROUP BY Hotels.id, Hotels.name;