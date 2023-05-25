
import {User} from '../entities/user';
import {UserRepository} from '../use-cases/ports/user.repository';
import {QueryResult} from "pg";
import {SaveUserDto, UpdateStatusUserDto, UpdateUserDto} from "./userDTO";
import {pool} from "../../../utils/dbconfig";

export class UserStorageGateway implements UserRepository {

    async create(user: SaveUserDto): Promise<User> {
        try {
            const {name, lastname, email, password, role} = user;

            const response = await pool.query(
                'INSERT INTO users (name, lastname, email, password, role) values ($1, $2, $3, $4, $5) RETURNING *',
                [name, lastname, email, password, role]
            );
            return response.rows[0] as User;
        } catch (error) {
            throw new Error('Error database' + error);
        }
    }

    async findById(id: number): Promise<User> {
        try {
            const response = await pool.query(
                'SELECT id,name,lastname,email,status,role FROM users WHERE id = $1',
                [id]
            );
            return response.rows[0] as User;
        } catch (error) {
            throw new Error('Error database' + error);
        }
    }

    async findAll(): Promise<User[]> {
        try {
            const response = await pool.query('SELECT id,name,lastname,email,status,role FROM users');
            return response.rows;
        } catch (error) {
            throw new Error('Error database' + error);
        }
    }

    async update(user: UpdateUserDto): Promise<User> {
        try {
            const {id, name, lastname, email, password, role} = user;

            const response = await pool.query(
                'UPDATE users SET name = $1, lastname= $2, email=$3, password=$4, role=$5 WHERE id = $6 RETURNING *',
                [name, lastname, email, password, role, id]
            );
            return response.rows[0] as User;
        } catch (error) {
            throw new Error('Error database' + error);
        }
    }

    async updateStatus(user: UpdateStatusUserDto): Promise<User> {
        try {
            const {id, status} = user;

            const response = await pool.query(
                'UPDATE users SET status=$1 WHERE id = $2 RETURNING *',
                [status, id]
            );
            return response.rows[0] as User;
        } catch (error) {
            throw new Error('Error database' + error);
        }
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
