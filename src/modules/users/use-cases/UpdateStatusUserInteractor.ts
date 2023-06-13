import { UseCase } from "../../../kernel/contracts";
import { UpdateStatusUserDto } from "../adapters/dto";
import { User } from "../entities/user";
import { UserRepository } from "./ports/user.repository";

export class UpdateStatusUserInteractor implements UseCase<UpdateStatusUserDto, User> {
    constructor(private readonly userRepository: UserRepository) {}
    async execute(payload: UpdateStatusUserDto): Promise<User> {
        if (!payload.id) throw Error('Missing id')
        if (isNaN(payload.id)) throw Error('Invalid id')
        if (payload.status === undefined) throw Error('Missing fields')
        if (await this.userRepository.existsById(payload.id)) {
            const user = await this.userRepository.findById(payload.id)
            if (!payload.status && !user.availability) throw Error('User occupied')
        } else {
            throw Error('Not found')
        }
        return this.userRepository.updateStatus(payload);
    }
}