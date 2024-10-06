// fs (File System): readdir, stat, stats.isDirectory
// path: extname, join
const fs = require("fs");
const path = require("path");
const util = require("util");

const readdir = util.promisify(fs.readdir);
const stat = util.promisify(fs.stat);

async function exploreDirectory(dir) {
  try {
    const files = await readdir(dir);

    for (const file of files) {
      const filePath = path.join(dir, file);
      const stats = await stat(filePath);

      if (stats.isDirectory()) {
        await exploreDirectory(filePath);
      } else {
        if (path.extname(file) === ".js") {
          console.log(filePath);
        }
      }
    }
  } catch (err) {
    console.error("Error:", err);
  }
}

module.exports = {
  exploreDirectory,
};
