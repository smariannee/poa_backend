import {UseCase} from "../../../kernel/contracts";
import {Process} from "../entities/process";
import {ProcessRepository} from "./port/process.repository";


export class GetAllProcessInteractor implements UseCase<void, Process[]> {
    constructor(private readonly processRepository: ProcessRepository) {
    }
    execute(): Promise<Process[]> {
        return this.processRepository.findAll()
    }
}
