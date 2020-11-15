import express from 'express';
import fileUpload from 'express-fileupload';
import fs from 'fs';
import cors from 'cors';
const app = express();

app.use(fileUpload({
  createParentPath: true
}));

let i = 0;

app.use(cors());
app.use(express.urlencoded());
app.post("/file",  async (request, response) => {
  const data = request.body.body;
  await fs.writeFile("./content/result" + i++ +".txt", data, () => {
    console.log("File saved! " + i - 1);
  });
  response.send(
      {
        "status": "ok"
      }
  )

})

const port = process.env.PORT || 80;

app.listen(port, () =>
    console.log(`App is listening on port ${port}.`)
);