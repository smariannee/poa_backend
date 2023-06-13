import { SaveUserDto, UpdateStatusUserDto, UpdateUserDto } from "../../adapters/dto";
import { User } from "../../entities/user";

export interface  UserRepository {
    findAll(): Promise<User[]>;
    findById(id: number): Promise<User>;
    save(user: SaveUserDto): Promise<User>;
    update(user: UpdateUserDto): Promise<User>;
    updateStatus(user: UpdateStatusUserDto): Promise<User>;
    existsById(id: number): Promise<boolean>;
    existsByEmail(email: string): Promise<boolean>;
}