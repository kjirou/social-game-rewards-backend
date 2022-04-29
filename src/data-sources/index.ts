import { Game } from '../generated/graphql'
import { games } from './games'

export type StaticDataSources = {
  readonly games: readonly Game[],
}

export const staticDataSources: StaticDataSources = {
  games: games,
}
