import * as dotenv from "dotenv";
import express, { Application } from "express";
import cors from "cors";

dotenv.config();

const PORT = process.env.PORT || 3000;
const app: Application = express();

app.use(cors({
    credentials:true,
    origin: 'http://localhost:3000'
}))
app.use(express.json({limit: "50mb"}));
app.use(express.urlencoded({extended: false}))

app.get('/test', (req, res) => res.send('Welcome to POA (Annual Operational Program)'))
//----
app.get('*',  (req, res) =>res.status(404).send('Page Not Found'))

app.listen(PORT, () => console.log(`📑 Server starting on port ${PORT}`));