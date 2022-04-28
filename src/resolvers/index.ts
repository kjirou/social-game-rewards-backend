import { Game, Resolvers } from '../generated/graphql'

const games: Game[] = [
  {
    id: 'fate_grand_order',
    name: 'Fate Grand/Order',
    url: 'https://www.fate-go.jp/',
  },
  {
    id: 'idolmaster_cinderella_girls',
    name: 'アイドルマスターシンデレラガールズ',
    url: 'https://cinderella.idolmaster.jp/',
  },
  {
    id: 'umamusume_pretty_derby',
    name: 'ウマ娘 プリティーダービー',
    url: 'https://umamusume.jp/',
  },
]

export const resolvers: Resolvers = {
  Query: {
    findGames: () => games,
  },
}
