import {UseCase} from "../../../kernel/contracts";
import {UpdateAreaDto} from "../entities/areaDto";
import {Area} from "../entities/area";
import {AreaRepository} from "./ports/area.repository";

export class UpdateAreaInteractor implements UseCase<UpdateAreaDto, Area> {
    constructor(private readonly areaRepository: AreaRepository) {
    }

    execute(payload: UpdateAreaDto): Promise<Area> {
        return this.areaRepository.update(payload)
    }
}

