const express = require("express");
const app = express();
const port = 3002;

app.get("/board/page/:page", (req, res) =>
  res.send(`Page is ${req.params.page}`)
);

app.listen(port, () => console.log(`Server listening on port ${port}!`));
