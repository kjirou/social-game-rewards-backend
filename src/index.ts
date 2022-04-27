import { ApolloServer } from 'apollo-server'

import gameTypeDefs from './schemas/game'
import queryTypeDefs from './schemas/query'
import { Game } from './generated/graphql'

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

// TODO: 型をつける。
const resolvers = {
  Query: {
    findGames: () => games,
  },
}

const server = new ApolloServer({
  typeDefs: [gameTypeDefs, queryTypeDefs],
  resolvers,
})

server.listen().then(({ url }) => {
  console.log(`The apollo server is running at ${url}.`);
})
