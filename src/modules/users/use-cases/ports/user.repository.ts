import {User} from "../../entities/user";
import {SaveUserDto, UpdateUserDto} from "../../adapters/userDTO";


export interface  UserRepository{

    findAll(): Promise<User[]>
    findById(id: number): Promise<User>;
    create(user: SaveUserDto): Promise<User>;
    update(user: UpdateUserDto): Promise<User>;
    updateStatus(id: number): Promise<User>;
    existByEmail(email: string): Promise<boolean>;


}