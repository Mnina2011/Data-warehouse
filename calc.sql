-- Відсотки заброньованих, вільних та недоступних номерів за день для кожного готелю
SELECT h.id         AS hotel_id,
       res.check_in AS date,
       ROUND(100.0 * COUNT(CASE WHEN r.status = 'booked' THEN 1 ELSE NULL END) / COUNT(*),
             2)     AS reserved_percentage,
       ROUND(100.0 * COUNT(CASE WHEN r.status = 'available' THEN 1 ELSE NULL END) / COUNT(*),
             2)     AS available_percentage,
       ROUND(100.0 * COUNT(CASE WHEN r.status = 'unavailable' THEN 1 ELSE NULL END) / COUNT(*),
             2)     AS unavailable_percentage
FROM Hotels h
         JOIN Cities c ON h.city_id = c.id
         JOIN Countries ct ON c.country_id = ct.id
         JOIN Rooms r ON h.id = r.hotel_id
         JOIN reservations res ON r.id = res.room_id
GROUP BY h.id, res.check_in;


-- Дохід за день для кожного готелю, кожної характеристики номерів та категорії готелю
SELECT h.id                      AS hotel_id,
       r.feature_id,
       h.category,
       res.check_in              AS date,
       ROUND(SUM(rv.revenue), 2) AS revenue
FROM Hotels h
         JOIN Rooms r ON h.id = r.hotel_id
         JOIN Reservations res ON r.id = res.room_id
         JOIN Revenue rv ON h.id = rv.hotel_id AND res.check_in = rv.date AND r.feature_id = rv.room_feature_id
         JOIN Cities c ON h.city_id = c.id
         JOIN Countries ct ON c.country_id = ct.id
GROUP BY h.id, r.feature_id, h.category, res.check_in;

-- Отримання відсотку заброньованих, вільних та недоступних номерів для кожного готелю
SELECT h.id                                                                  AS hotel_id,
       res.check_in                                                          AS date,
       100 * COUNT(CASE WHEN r.status = 'booked' THEN 1 END) / COUNT(*)      AS reserved_percentage,
       100 * COUNT(CASE WHEN r.status = 'available' THEN 1 END) / COUNT(*)   AS available_percentage,
       100 * COUNT(CASE WHEN r.status = 'unavailable' THEN 1 END) / COUNT(*) AS unavailable_percentage
FROM Hotels h
         JOIN Cities c ON h.city_id = c.id
         JOIN Countries ct ON c.country_id = ct.id
         JOIN Rooms r ON h.id = r.hotel_id
         JOIN reservations res ON r.id = res.room_id
GROUP BY h.id, res.check_in;


-- Отримання доходу та відсотку залежно від розташування готелю, категорії, характеристик та дати
SELECT h.id                                                             AS hotel_id,
       r.feature_id,
       h.category,
       res.check_in                                                     AS date,
       SUM(rv.revenue)                                                  AS revenue,
       100 * COUNT(CASE WHEN r.status = 'booked' THEN 1 END) / COUNT(*) AS booked_percentage
FROM Hotels h
         JOIN Rooms r ON h.id = r.hotel_id
         JOIN reservations res ON r.id = res.room_id
         JOIN Revenue rv ON h.id = rv.hotel_id AND res.check_in = rv.date AND r.feature_id = rv.room_feature_id
         JOIN Cities c ON h.city_id = c.id
         JOIN Countries ct ON c.country_id = ct.id
GROUP BY h.id, r.feature_id, h.category, res.check_in;
