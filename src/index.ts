import { ApolloServer } from 'apollo-server'

import { resolvers } from './resolvers'
import gameTypeDefs from './schemas/game'
import queryTypeDefs from './schemas/query'

const server = new ApolloServer({
  typeDefs: [gameTypeDefs, queryTypeDefs],
  resolvers,
})

server.listen().then(({ url }) => {
  console.log(`The apollo server is running at ${url}.`);
})
