import { ApolloServer, gql } from 'apollo-server'

// TODO: .graphql ファイルへ切り出す。
const typeDefs = gql`
  type Game {
    id: ID!
    name: String!
    url: String!
  }

  type Query {
    findGames: [Game]
  }
`

// TODO: GraphQL の型から生成する。
type Game = {
  id: string,
  name: string,
  url: string,
}

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

const server = new ApolloServer({ typeDefs, resolvers })

server.listen().then(({ url }) => {
  console.log(`The apollo server is running at ${url}.`);
})
