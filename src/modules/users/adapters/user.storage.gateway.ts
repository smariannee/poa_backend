import { pool } from "../../../utils/dbconfig";
import { User } from "../entities/user";
import { UserRepository } from "../use-cases/ports/user.repository";
import { SaveUserDto, UpdateStatusUserDto, UpdateUserDto } from "./dto";

export class UserStorageGateway implements UserRepository {

    async findAll(): Promise<User[]> {
        try {
            const response = await pool.query('select * from users');
            return response.rows;
        } catch (error) {
            console.error(error);
            throw Error('Server Error');
        }
    }

    async findById(id: number): Promise<User> {
        try {
            const response = await pool.query('select * from users where id = $1', [id]);
            return response.rows[0] as User;
        } catch (error) {
            console.error(error);
            throw Error('Server Error');
        }
    }

    async save(user: SaveUserDto): Promise<User> {
        try {
            const { name, lastname1, lastname2, email, password, phone_number, extension_number, role } = user;
            const response = await pool.query('insert into users(name, lastname1, lastname2, email, password, phone_number, extension_number, role) values($1, $2, $3, $4, $5, $6, $7, $8) returning *', [name, lastname1, lastname2, email, password, phone_number, extension_number, role]);
            return response.rows[0] as User;
        } catch (error) {
            console.error(error);
            throw Error('Server Error');
        }
    }

    async update(user: UpdateUserDto): Promise<User> {
        try {
            const {id, name, lastname1, email, phone_number, extension_number, role} = user;
            const response = await pool.query('UPDATE users SET name = $1, lastname= $2, email=$3,phone_number =$4 , extension_number =$5 , password=$6, role=$7 WHERE id = $8 RETURNING *', [name, lastname1, email, phone_number, extension_number, role, id]);
            return response.rows[0] as User;
        } catch (error) {
            console.error(error);
            throw Error('Server Error');
        }
    }

    async updateStatus(user: UpdateStatusUserDto): Promise<User> {
        try {
            const {id, status} = user;
            const response = await pool.query('UPDATE users SET status=$1 WHERE id = $2 RETURNING *', [status, id]);
            return response.rows[0] as User;
        } catch (error) {
            console.error(error);
            throw Error('Server Error');
        }
    }

    async existsById(id: number): Promise<boolean> {
        try {
            const response = await pool.query('SELECT * FROM users WHERE id = $1', [id]);
            return response.rows.length > 0;
        } catch (error) {
            console.error(error);
            throw Error('Server Error');
        }
    }

    async existsByEmail(email: string): Promise<boolean> {
        try {
            const response = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
            return response.rows.length > 0;
        } catch (error) {
            console.error(error);
            throw Error('Server Error');
        }
    }
    
}
