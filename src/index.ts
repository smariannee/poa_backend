import * as dotenv from "dotenv";
import express, {Application, Request, Response} from "express";
import cors from "cors";
import userRoutes from "./modules/users/adapters/user.routes";

dotenv.config();

const PORT = process.env.PORT || 3000;
const app: Application = express();
const API:string = 'poa';

app.use(cors({
    credentials:true,
    origin: 'http://localhost:3000'
}))

app.use(express.json({limit: "50mb"}));
app.use(express.urlencoded({extended: false}))

app.get('/test', (req:Request, res:Response) => res.send('Welcome to POA (Annual Operational Program)'))


app.use(`/${API}/users`,userRoutes);



//----
app.get('*',  (req:Request, res:Response) =>res.status(404).send('Page Not Found'))

app.listen(PORT, () => console.log(`📑 Server starting on port ${PORT}`));