const express = require("express");
const app = express();
const port = 3002;

app.get("/factorial", (req, res) => {
  const { number } = req.query;
  res.redirect(`/factorial/${number}`);
});

app.get("/factorial/:number", (req, res) => {
  const { number } = req.params;
  if (isNaN(number)) {
    return res.send("Please provide a valid integer.");
  }
  const factorial = (n) => {
    return n ? n * factorial(n - 1) : 1;
  };
  res.send(`factorial ${number} is ${factorial(number)}`);
});

app.listen(port, () => console.log(`Server listening on port ${port}!`));
