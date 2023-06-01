import {UseCase} from "../../../kernel/contracts";
import {SaveAreaDto} from "../entities/areaDto";
import {Area} from "../entities/area";
import {AreaRepository} from "./ports/area.repository";

export class CreateAreaInteractor implements UseCase<SaveAreaDto, Area> {
    constructor(private readonly areaRepository: AreaRepository) {
    }
    async execute(payload: SaveAreaDto): Promise<Area> {
        return this.areaRepository.create(payload)
    }
}
