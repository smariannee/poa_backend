import {pool} from "../../../utils/dbconfig";
import {AreaRepository} from "../use-cases/ports/area.repository";
import {Area} from "../entities/area";
import {SaveAreaDto, UpdateAreaDto, UpdateStatusAreaDto} from "../entities/areaDto";
import {QueryResult} from "pg";

function mappingArea(row: any) {
    return ({
        id: row.area_id,
        area: row.area,
        status: row.status,
        director: {
            id: row.director_id,
            name: row.director_name,
            lastname: row.director_lastname,
            email: row.director_email,
            role: row.director_role,
            password: row.director_password,
            status: row.director_status
        },
        assistant: {
            id: row.assistant_id,
            name: row.assistant_name,
            lastname: row.assistant_lastname,
            email: row.assistant_email,
            role: row.assistant_role,
            password: row.assistant_password,
            status: row.assistant_status
        }
    }) as Area
}

export class AreaStorageGateway implements AreaRepository {

    async create(areaO: SaveAreaDto): Promise<Area> {
        try {
            const {area, director, assistant} = areaO;

            const response = await pool.query(
                'INSERT INTO areas (area, director, assistant) values ($1, $2, $3) RETURNING *',
                [area, director, assistant]
            );
            return response.rows[0] as Area;
        } catch (error) {
            throw new Error('Error database' + error);
        }
    }

    async existByName(name: string): Promise<boolean> {
        try {
            const response: QueryResult = await pool.query(
                'SELECT count(\'area\') FROM areas WHERE area = $1;',
                [name]
            );
            return response.rows[0].count > 0;
        } catch (error) {
            throw new Error('Error database' + error);
        }
    }

    async findAll(): Promise<Area[]> {
        try {
            const response = await pool.query('SELECT * FROM areas_users');
            const result = response.rows;
            return result.map(row => mappingArea(row))
        } catch (error) {
            throw new Error('Error database' + error);
        }
    }

    async findById(id: number): Promise<Area> {
        try {
            const response = await pool.query('SELECT * FROM areas_users WHERE area_id  = $1', [id]);
            const result = response.rows;
            return result.map(row => mappingArea(row))[0]
        } catch (error) {
            throw new Error('Error database' + error);
        }
    }

    async update(areaO: UpdateAreaDto): Promise<Area> {
        try {
            const {id, area, director, assistant} = areaO;

            const response = await pool.query(
                'UPDATE areas SET area= $1, director  = $2, assistant = $3 WHERE id = $4 RETURNING *',
                [area, director, assistant, id]
            );
            return response.rows[0] as Area;
        } catch (error) {
            throw new Error('Error database' + error);
        }
    }

    async updateStatus(areaO: UpdateStatusAreaDto): Promise<Area> {
        try {
            const {id, status} = areaO;

            const response = await pool.query(
                'UPDATE areas SET status = $1 WHERE id = $2 RETURNING *',
                [status, id]
            );
            return response.rows[0] as Area;
        } catch (error) {
            throw new Error('Error database' + error);
        }
    }

}
