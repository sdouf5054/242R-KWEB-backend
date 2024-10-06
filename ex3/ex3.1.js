const express = require("express");
const app = express();
const port = 3002;

app.use(express.urlencoded({ extended: true }));

const getString = (obj) => {
  return Object.keys(obj)
    .map((k) => `${k}: ${obj[k]}`)
    .join("\n");
};

app.get("/", (req, res) => res.send(`GET / ${getString(req.query)}`));
app.post("/", (req, res) => res.send(`POST / ${getString(req.body)}`));
app.put("/", (req, res) => res.send(`PUT / ${getString(req.body)}`));
app.delete("/", (req, res) => res.send(`DELETE / ${getString(req.body)}`));

app.listen(port, () => console.log(`Server listening on port ${port}!`));
