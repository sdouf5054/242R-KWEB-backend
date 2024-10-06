import { readdir } from "node:fs/promises";

try {
  const files = await readdir(path);
  for (const file of files) console.log(file);
} catch (err) {
  console.error(err);
}
