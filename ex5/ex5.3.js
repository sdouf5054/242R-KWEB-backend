const express = require("express");
const { runQuery } = require("./database");
const app = express();
const port = 3000;

app.use(express.json());

app.get("/fare", async (req, res) => {
  const uid = req.query.uid;
  try {
    const sql = `
              SELECT users.name AS username, 
                     ROUND(SUM(types.fare_rate * (trains.distance / 1000)), -2) AS total_fare
              FROM tickets
              JOIN trains ON tickets.train = trains.id
              JOIN types ON trains.type = types.id
              JOIN users ON tickets.user = users.id
              WHERE tickets.user = ?
              GROUP BY users.name
          `;
    const result = await runQuery(sql, [uid]);
    const username = result[0]?.username || "Unknown User";
    const totalFare = result[0]?.total_fare || 0;
    res.send(`Total fare of ${username} is ${totalFare} KRW.`);
  } catch (error) {
    console.error(error);
    res.status(500).send("Internal Server Error");
  }
});

app.get("/train/status", async (req, res) => {
  const tid = req.query.tid;
  try {
    const sql = `
            SELECT COUNT(tickets.id) AS occupied, types.max_seats
            FROM trains
            JOIN types ON trains.type = types.id
            LEFT JOIN tickets ON trains.id = tickets.train
            WHERE trains.id = ?
            GROUP BY trains.id
        `;
    const result = await runQuery(sql, [tid]);
    const { occupied, max_seats } = result[0] || { occupied: 0, max_seats: 0 };

    if (occupied >= max_seats) {
      res.send(`Train ${tid} is sold out`);
    } else {
      res.send(`Train ${tid} is not sold out`);
    }
  } catch (error) {
    console.error(error);
    res.status(500).send("Internal Server Error");
  }
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
