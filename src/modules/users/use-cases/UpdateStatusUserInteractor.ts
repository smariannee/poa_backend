import { UseCase } from "../../../kernel/contracts";
import { UpdateStatusUserDto } from "../adapters/dto";
import { User } from "../entities/user";
import { UserRepository } from "./ports/user.repository";

export class UpdateStatusUserInteractor implements UseCase<UpdateStatusUserDto, User> {
    constructor(private readonly userRepository: UserRepository) {}
    async execute(user: UpdateStatusUserDto): Promise<User> {
        if (!user.id) throw Error('Missing id')
        if (user.status === undefined) throw Error('Missing fields')
        if (isNaN(user.id)) throw Error('Invalid id')
        if (!await this.userRepository.existsById(user.id)) throw Error('Not found')
        return this.userRepository.updateStatus(user);
    }
}