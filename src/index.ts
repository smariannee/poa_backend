import * as dotenv from 'dotenv';
import express, {Application, Request, Response} from 'express';
import cors from 'cors';
import userRoutes from './modules/users/adapters/user.routes';
import authRoutes from './modules/auth/adapters/auth.routes';
import areaRoutes from './modules/areas/adapters/area.routes';
import processRoutes from './modules/process/adapters/process.routes';

dotenv.config();

const PORT = process.env.PORT || 3000;
const HOST = process.env.HOST || 'localhost';

const app: Application = express();
const API:string = 'poa';

app.use(cors({
    credentials:true,
    origin: `http://${PORT}:${HOST}`
}))

app.use(express.json({limit: '50mb'}));
app.use(express.urlencoded({extended: false}))

app.get('/test', (req:Request, res:Response) => res.send('Welcome to POA (Annual Operational Program)'))


app.use(`/${API}/auth`,authRoutes);
app.use(`/${API}/users`,userRoutes);
app.use(`/${API}/areas`,areaRoutes);
app.use(`/${API}/process`,processRoutes);



//----
app.get('*',  (req:Request, res:Response) =>res.status(404).send('Page Not Found'))

app.listen(PORT, () => console.log(`📑 Server starting on port ${PORT}`));