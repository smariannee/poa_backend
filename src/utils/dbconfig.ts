import { Pool } from 'pg'
import dotenv from 'dotenv'

dotenv.config();

const PORT : string = process.env.PORTDB || '5432'

/**
 * @description Create Connection
 */
//
export const pool = new Pool({
    user: process.env.USER,
    password: process.env.PASSWORD,
    host: process.env.HOST,
    database: process.env.DATABASE,
    port: parseInt(PORT.toString()),

})

// timezone: 'utc',
