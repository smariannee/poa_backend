import { UseCase } from "../../../kernel/contracts";
import { GetUserDto } from "../adapters/dto";
import { User } from "../entities/user";
import { UserRepository } from "./ports/user.repository";

export class GetAllUsersInteractor implements UseCase<GetUserDto, User[]> {
    constructor(private readonly userRepository: UserRepository) {}
    execute(): Promise<User[]> {
        return this.userRepository.findAll()
    }
}