import express from 'express';
import fileUpload from 'express-fileupload';
import fs from 'fs';
import cors from 'cors';
const app = express();

app.use(fileUpload({
  createParentPath: true
}));

app.use(cors());

app.post("/file", async (request, response) => {
  const file = request.files.file;
  await fs.writeFile('./content/' + file.name, file.data,() => {
    console.log('File saved with name: ' + file.name);
  });
  response.send({
    status: true,
    message: 'File is uploaded',
    data: {
      name: file.name,
      mimetype: file.mimetype,
      size: file.size
    }
  });
})

const port = process.env.PORT || 80;

app.listen(port, () =>
    console.log(`App is listening on port ${port}.`)
);