import { SaveUserDto, UpdateStatusUserDto, UpdateUserDto } from "../../adapters/dto";
import { UpdatePasswordUserDto } from "../../adapters/dto/UpdatePasswordUserDto";
import { User } from "../../entities/user";

export interface  UserRepository {
    findAll(): Promise<User[]>;
    findById(id: number): Promise<User>;
    findByEmail(email: string): Promise<User>;
    save(user: SaveUserDto): Promise<User>;
    update(user: UpdateUserDto): Promise<User>;
    updateStatus(user: UpdateStatusUserDto): Promise<User>;
    updatePassword(user: UpdatePasswordUserDto): Promise<User>;
    existsById(id: number): Promise<boolean>;
    existsByEmail(email: string): Promise<boolean>;
}