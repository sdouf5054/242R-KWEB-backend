const express = require("express");
const app = express();
const port = 3002;

app.set("views", `${__dirname}`);
app.set("view engine", "pug");

app.use(express.urlencoded({ extended: true }));

app.get("/", (req, res) => res.render("login.pug"));
app.post("/login", (req, res) => {
  const { username } = req.body;
  const { password } = req.body;
  res.send(
    `login info is submitted!<br>Username: ${username}  Password: ${password} :)`
  );
});

app.listen(port, () => console.log(`Server listening on port ${port}!`));
