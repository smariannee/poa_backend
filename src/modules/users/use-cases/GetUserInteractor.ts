import { UseCase } from "../../../kernel/contracts";
import { User } from "../entities/user";
import { UserRepository } from "./ports/user.repository";

export class GetUserInteractor implements UseCase<number, User> {
    constructor(private readonly userRepository: UserRepository) {}
    async execute(id: number): Promise<User> {
        if (!id) throw Error('Missing fields')
        if (isNaN(id)) throw Error('Invalid id')
        if (!await this.userRepository.existsById(id)) throw Error('Not found')
        return this.userRepository.findById(id);
    }
}