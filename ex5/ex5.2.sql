-- 1. ID가 11인 노선을 예매한 모든 승객의 ID(id), 이름(name), 좌석 번호(seat_number)를 좌석 번호의 오름차순
-- 으로 조회
SELECT users.id, users.name, tickets.seat_number
FROM tickets
JOIN users ON tickets.user = users.id
WHERE tickets.train = 11
ORDER BY tickets.seat_number ASC;

-- 2. 각 사용자의 ID(id), 이름(name), 탑승 열차 수(trains_count), 총 거리(total_distance)를 총 거리의 내림
-- 차순으로 상위 6명만 조회
SELECT users.id, users.name, COUNT(tickets.train) AS trains_count, 
       ROUND(SUM(trains.distance / 10), 4) AS total_distance
FROM users
JOIN tickets ON users.id = tickets.user
JOIN trains ON tickets.train = trains.id
GROUP BY users.id
ORDER BY total_distance DESC, users.name ASC
LIMIT 6;

-- 3. 각 노선의 ID(id), 열차 종류(type), 출발역(src_stn), 도착역(dst_stn), 여행 시간(travel_time)을 여행 시
-- 간의 내림차순으로 상위 6개만 조회
SELECT trains.id, types.name AS type, stations_src.name AS src_stn, stations_dst.name AS dst_stn, 
       TIMEDIFF(trains.arrival, trains.departure) AS travel_time
FROM trains
JOIN types ON trains.type = types.id
JOIN stations AS stations_src ON trains.source = stations_src.id
JOIN stations AS stations_dst ON trains.destination = stations_dst.id
ORDER BY travel_time DESC
LIMIT 6;

-- 4. 각 노선의 열차 종류(type), 출발역(src_stn), 도착역(dst_stn), 출발 시각(departure), 도착 시각(arrival),
-- 운임(fare; 원 단위)을 출발 시각의 오름차순으로 모두 조회
SELECT types.name AS type, stations_src.name AS src_stn, stations_dst.name AS dst_stn, 
       trains.departure, trains.arrival, 
       ROUND(types.fare_rate * (trains.distance / 1000), -2) AS fare
FROM trains
JOIN types ON trains.type = types.id
JOIN stations AS stations_src ON trains.source = stations_src.id
JOIN stations AS stations_dst ON trains.destination = stations_dst.id
ORDER BY trains.departure ASC;

-- 5. 각 노선의 ID(id), 열차 종류(type), 출발역(src_stn), 도착역(dst_stn), 예매된 좌석 수(occupied), 최대 좌석
-- 수(maximum)를 노선의 ID의 오름차순으로 모두 조회 (예매한 사용자가 없는 노선은 제외)
SELECT trains.id, types.name AS type, stations_src.name AS src_stn, stations_dst.name AS dst_stn, 
       COUNT(tickets.id) AS occupied, types.max_seats AS maximum
FROM trains
JOIN types ON trains.type = types.id
JOIN stations AS stations_src ON trains.source = stations_src.id
JOIN stations AS stations_dst ON trains.destination = stations_dst.id
JOIN tickets ON trains.id = tickets.train
GROUP BY trains.id
ORDER BY trains.id ASC;

-- 6. 각 노선의 ID(id), 열차 종류(type), 출발역(src_stn), 도착역(dst_stn), 예매된 좌석 수(occupied), 최대 좌석
-- 수(maximum)를 노선의 ID의 오름차순으로 모두 조회 (예매한 사용자가 없는 노선도 포함)
SELECT trains.id, types.name AS type, stations_src.name AS src_stn, stations_dst.name AS dst_stn, 
       COUNT(tickets.id) AS occupied, types.max_seats AS maximum
FROM trains
JOIN types ON trains.type = types.id
JOIN stations AS stations_src ON trains.source = stations_src.id
JOIN stations AS stations_dst ON trains.destination = stations_dst.id
LEFT OUTER JOIN tickets ON trains.id = tickets.train
GROUP BY trains.id
ORDER BY trains.id ASC;