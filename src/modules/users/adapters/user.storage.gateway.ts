
import {User} from '../entities/user';
import {UserRepository} from '../use-cases/ports/user.repository';
import {QueryResult} from "pg";
import {SaveUserDto, UpdateUserDto} from "./userDTO";
import {pool} from "../../../utils/dbconfig";

export class UserStorageGateway implements UserRepository {

    async create(payload: SaveUserDto): Promise<User> {
        try {
            const {name, lastname, email, password, status, role} = payload;
            const response = await pool.query(
                'INSERT INTO users (name, lastname, email, password, status, role) values ($1, $2, $3, $4, $5, $6) RETURNING *',
                [name, lastname, email, password, status, role]
            );
            return response.rows[0] as User;
        } catch (error) {
            throw new Error('Error database' + error);
        }
    }

    async findById(id: number): Promise<User> {
        try {
            const response = await pool.query(
                'SELECT * FROM users WHERE id = $1',
                [id]
            );
            return response.rows[0] as User;
        } catch (error) {
            throw new Error('Error database' + error);
        }
    }

    async findAll(): Promise<User[]> {
        try {
            const response = await pool.query('SELECT * FROM users');
            return response.rows;
        } catch (error) {
            throw new Error('Error database' + error);
        }
    }

    async update(user: UpdateUserDto): Promise<User> {
        throw new Error('NOT implement');
    }

    async updateStatus(id: number): Promise<User> {
        throw new Error('NOT implement');
    }

    async existByEmail(email: string): Promise<boolean> {
        try {
            const response: QueryResult = await pool.query(
                'SELECT count(\'email\') FROM users WHERE email = $1;',
                [email]
            );
            return response.rows[0].count > 0;
        } catch (error) {
            throw new Error('Error database' + error);
        }
    }
}
